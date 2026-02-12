import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/app_user.dart';
import '../../data/firebase_auth_repository.dart';

class AuthState {
  final AppUser? user;
  final bool isLoading;
  final bool isInitialized;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.isInitialized = false,
    this.error,
  });

  AuthState copyWith({
    AppUser? user,
    bool clearUser = false,
    bool? isLoading,
    bool? isInitialized,
    String? error,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error,
    );
  }
}

final authRepositoryProvider = Provider((ref) => FirebaseAuthRepository());

class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState(isLoading: true)) {
    _init();
  }

  void _init() {
    _repository.authStateChanges.listen(
      (user) {
        state = state.copyWith(
          user: user,
          isLoading: false,
          isInitialized: true,
        );
      },
      onError: (e) {
        state = state.copyWith(
          isLoading: false,
          isInitialized: true,
          error: e.toString(),
        );
      },
    );
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.signInWithEmail(email, password);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.signUpWithEmail(name, email, password);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateProfile({
    required String name,
    String? phoneNumber,
    String? bio,
    String? profileImageUrl,
    bool clearProfileImage = false,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.updateProfile(
        name: name,
        phoneNumber: phoneNumber,
        bio: bio,
        profileImageUrl: profileImageUrl,
        clearProfileImage: clearProfileImage,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    await _repository.signOut();
    // Use clearUser to explicitly null out the user state
    state = state.copyWith(clearUser: true, isLoading: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
