import 'package:flutter/material.dart';
import 'locale_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStrings {
  final Locale locale;
  AppStrings(this.locale);

  bool get isAr => locale.languageCode == 'ar';

  String get appName => isAr ? 'برو سيرفس' : 'Pro-Service';
  String get hello => isAr ? 'مرحباً' : 'Hello';
  String get noAccount => isAr ? 'ليس لديك حساب؟' : 'Don\'t have an account?';
  
  // Auth
  String get login => isAr ? 'تسجيل الدخول' : 'Login';
  String get signUp => isAr ? 'إنشاء حساب' : 'Sign Up';
  String get email => isAr ? 'البريد الإلكتروني' : 'Email';
  String get password => isAr ? 'كلمة المرور' : 'Password';
  String get fullName => isAr ? 'الاسم الكامل' : 'Full Name';
  String get phoneNumber => isAr ? 'رقم الهاتف' : 'Phone Number';
  String get welcomeBack => isAr ? 'مرحباً بعودتك' : 'Welcome Back';
  String get joinUs => isAr ? 'انضم إلينا واحجز مهمتك الأولى' : 'Join us and book your first task';
  String get alreadyHaveAccount => isAr ? 'لديك حساب بالفعل؟' : 'Already have an account?';
  String get dontHaveAccount => isAr ? 'ليس لديك حساب؟' : 'Don\'t have an account?';
  String get invalidEmail => isAr ? 'بريد إلكتروني غير صالح' : 'Invalid email format';
  String get emailRequired => isAr ? 'البريد الإلكتروني مطلوب' : 'Email is required';
  String get passwordRequired => isAr ? 'كلمة المرور مطلوبة' : 'Password is required';
  String get passwordTooShort => isAr ? 'يجب أن تكون كلمة المرور 8 أحرف على الأقل' : 'Password must be at least 8 characters';
  String get passwordWeak => isAr ? 'يجب أن تحتوي كلمة المرور على أحرف وأرقام' : 'Password must contain both letters and numbers';
  String get nameRequired => isAr ? 'الاسم مطلوب' : 'Name is required';

  // Onboarding
  String get onboardingTitle1 => isAr ? 'ابحث عن خدمات الخبراء' : 'Find Expert Services';
  String get onboardingDesc1 => isAr ? 'احجز محترفين ذوي تقييم عالٍ لجميع احتياجات منزلك في ثوانٍ.' : 'Book top-rated professionals for all your home needs in seconds.';
  String get onboardingTitle2 => isAr ? 'مدفوعات آمنة' : 'Secure Payments';
  String get onboardingDesc2 => isAr ? 'طرق دفع آمنة ومضمونة لراحة بالك.' : 'Safe and secure payment methods for your peace of mind.';
  String get onboardingTitle3 => isAr ? 'حجز فوري' : 'Instant Booking';
  String get onboardingDesc3 => isAr ? 'جدولة المواعيد حسب راحتك مع توفر الوقت الحقيقي.' : 'Schedule appointments at your convenience with real-time availability.';
  String get getStarted => isAr ? 'ابدأ الآن' : 'Get Started';
  
  // Home
  String get searchPlaceholder => isAr ? 'ابحث عن الخدمات...' : 'Search for services...';
  String get categories => isAr ? 'الفئات' : 'Categories';
  String get topRatedPros => isAr ? 'المحترفون الأعلى تقييمًا' : 'Top Rated Pros';
  String get seeAll => isAr ? 'عرض الكل' : 'See All';
  String get findYourService => isAr ? 'ابحث عن خدمتك' : 'Find your service';
  
  // Service Details
  String get bio => isAr ? 'حول المحترف' : 'About the Pro';
  String get gallery => isAr ? 'الأعمال السابقة' : 'Past Work';
  String get bookNow => isAr ? 'احجز الآن' : 'Book Now';
  String get pricePerHour => isAr ? 'السعر في الساعة' : 'Price per hour';
  String get confirmBooking => isAr ? 'تأكيد الحجز' : 'Confirm Booking';
  String get bookingConfirmed => isAr ? 'تم تأكيد الحجز!' : 'Booking Confirmed!';
  String get selectDateTime => isAr ? 'اختر التاريخ والوقت' : 'Select Date & Time';
  
  // Bookings
  String get myBookings => isAr ? 'حجوزاتي' : 'My Bookings';
  String get noBookings => isAr ? 'لا توجد حجوزات' : 'No bookings found';
  String get pending => isAr ? 'قيد الانتظار' : 'Pending';
  String get completed => isAr ? 'مكتمل' : 'Completed';
  String get canceled => isAr ? 'ملغي' : 'Canceled';
  
  // Profile
  String get profile => isAr ? 'الملف الشخصي' : 'Profile';
  String get changeLanguage => isAr ? 'تغيير اللغة' : 'Change Language';
  String get logout => isAr ? 'تسجيل الخروج' : 'Logout';
  String get helpSupport => isAr ? 'المساعدة والدعم' : 'Help & Support';
  String get privacyPolicy => isAr ? 'سياسة الخصوصية' : 'Privacy Policy';
  String get editProfile => isAr ? 'تعديل الملف الشخصي' : 'Edit Profile';
  String get saveChanges => isAr ? 'حفظ التغييرات' : 'Save Changes';
  String get selectLanguage => isAr ? 'اختر اللغة' : 'Select Language';

  // Navigation
  String get home => isAr ? 'الرئيسية' : 'Home';

  // Stats
  String get totalBookings => isAr ? 'إجمالي الحجوزات' : 'Total Bookings';
  String get memberSince => isAr ? 'عضو منذ' : 'Member Since';

  // Category Names
  String get electrician => isAr ? 'كهربائي' : 'Electrician';
  String get plumbing => isAr ? 'سباكة' : 'Plumbing';
  String get cleaning => isAr ? 'تنظيف' : 'Cleaning';
  String get painting => isAr ? 'دهان' : 'Painting';
  String get gardening => isAr ? 'بستنة' : 'Gardening';

  String noProsFound(String query) => isAr ? 'لم يتم العثور على محترفين لـ "$query"' : 'No pros found for "$query"';
}


final stringsProvider = Provider<AppStrings>((ref) {
  final locale = ref.watch(localeProvider);
  return AppStrings(locale);
});
