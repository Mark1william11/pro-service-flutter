import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/pro_card.dart';
import '../widgets/category_card.dart';

class CategoryResultsScreen extends StatelessWidget {
  final String categoryName;
  const CategoryResultsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final isAllServices = categoryName == 'All Services';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(categoryName),
        centerTitle: false,
      ),
      body: isAllServices ? _buildCategoriesGrid() : _buildProsList(),
    );
  }

  Widget _buildCategoriesGrid() {
    final categories = [
      {'label': 'Electrician', 'icon': Icons.flash_on},
      {'label': 'Plumbing', 'icon': Icons.plumbing},
      {'label': 'Cleaning', 'icon': Icons.cleaning_services},
      {'label': 'Painting', 'icon': Icons.format_paint},
      {'label': 'Gardening', 'icon': Icons.grass},
      {'label': 'Carpentry', 'icon': Icons.handyman},
      {'label': 'AC Repair', 'icon': Icons.ac_unit},
      {'label': 'Laundry', 'icon': Icons.local_laundry_service},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        return InkWell(
          onTap: () => context.push('/category/${cat['label']}'),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(cat['icon'] as IconData, color: AppColors.primary, size: 32),
                ),
                const SizedBox(height: 12),
                Text(
                  cat['label'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: 8,
      itemBuilder: (context, index) {
        final isEven = index % 2 == 0;
        final serviceType = categoryName == 'Top Pros' 
            ? (isEven ? 'Electrician' : 'Plumber')
            : categoryName.replaceAll('Services', '').trim();
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ProCard(
            id: 'pro_$index',
            name: isEven ? 'John Doe' : 'Jane Smith',
            service: 'Expert $serviceType',
            rating: 4.5 + (index * 0.05 > 0.4 ? 0.4 : index * 0.05),
            price: 40.0 + (index * 5),
            imageUrl: 'https://i.pravatar.cc/150?u=pro_$index',
          ),
        );
      },
    );
  }
}
