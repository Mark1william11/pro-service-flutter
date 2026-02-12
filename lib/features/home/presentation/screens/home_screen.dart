import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/category_card.dart';
import '../widgets/pro_card.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _allPros = [
    {
      'id': 'pro_0',
      'name': 'John Doe',
      'service': 'Electrician',
      'rating': 4.9,
      'price': 25.0,
      'imageUrl': 'https://images.unsplash.com/photo-1541888946425-d81bb19480c5?q=80&w=250&auto=format&fit=crop', // Electrician
    },
    {
      'id': 'pro_1',
      'name': 'Jane Smith',
      'service': 'Plumbing',
      'rating': 4.8,
      'price': 30.0,
      'imageUrl': 'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?q=80&w=250&auto=format&fit=crop', // Plumber
    },
    {
      'id': 'pro_2',
      'name': 'Mike Ross',
      'service': 'Cleaning',
      'rating': 4.7,
      'price': 20.0,
      'imageUrl': 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?q=80&w=250&auto=format&fit=crop', // Cleaning
    },
    {
      'id': 'pro_3',
      'name': 'Harvey Specter',
      'service': 'Gardening',
      'rating': 4.9,
      'price': 35.0,
      'imageUrl': 'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?q=80&w=250&auto=format&fit=crop', // Gardener
    },
    {
      'id': 'pro_4',
      'name': 'Rachel Zane',
      'service': 'Painting',
      'rating': 4.6,
      'price': 28.0,
      'imageUrl': 'https://images.unsplash.com/photo-1589939705384-5185138a04b9?q=80&w=250&auto=format&fit=crop', // Painting
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final strings = ref.watch(stringsProvider);
    final userName = authState.user?.name ?? 'Guest';

    final filteredPros = _allPros.where((pro) {
      final nameMatch = pro['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final serviceMatch = pro['service'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      return nameMatch || serviceMatch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with Search
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${strings.hello} $userName',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              strings.findYourService,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => context.go('/profile'),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                            child: const Icon(Icons.person, color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: strings.searchPlaceholder,
                        prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.tune, color: Colors.white, size: 20),
                              ),
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.1, end: 0),
                  ],
                ),
              ),
            ),

            // Categories (Only show if not searching)
            if (_searchQuery.isEmpty)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            strings.categories,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () => context.push('/category/All Services'),
                            child: Text(strings.seeAll),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        children: [
                          CategoryCard(icon: Icons.flash_on, label: strings.electrician),
                          CategoryCard(icon: Icons.plumbing, label: strings.plumbing),
                          CategoryCard(icon: Icons.cleaning_services, label: strings.cleaning),
                          CategoryCard(icon: Icons.format_paint, label: strings.painting),
                          CategoryCard(icon: Icons.grass, label: strings.gardening),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Top Rated Pros Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _searchQuery.isEmpty ? strings.topRatedPros : '${strings.topRatedPros} (${filteredPros.length})',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    if (_searchQuery.isEmpty)
                      TextButton(
                        onPressed: () => context.push('/category/Top Pros'),
                        child: Text(strings.seeAll),
                      ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: filteredPros.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
                              const SizedBox(height: 16),
                              Text(
                                strings.noProsFound(_searchQuery),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final pro = filteredPros[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ProCard(
                              id: pro['id'],
                              name: pro['name'],
                              service: pro['service'],
                              rating: pro['rating'],
                              price: pro['price'],
                              imageUrl: pro['imageUrl'],
                            ),
                          );
                        },
                        childCount: filteredPros.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
