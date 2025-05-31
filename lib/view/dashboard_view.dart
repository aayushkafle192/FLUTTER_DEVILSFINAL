import 'package:flutter/material.dart';
import '../design/custom_button.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  final List<Map<String, String>> categories = const [
    {'name': 'T-Shirts', 'image': 'assets/images/tshirt.png'},
    {'name': 'Pants', 'image': 'assets/images/pant.png'},
    {'name': 'Shirts', 'image': 'assets/images/shirt.png'},
    {'name': 'Trousers', 'image': 'assets/images/trouser.png'},
    {'name': 'Jackets', 'image': 'assets/images/jacket.png'},
  ];

  final List<Map<String, String>> newArrivals = const [
    {'name': 'Oversized Tee', 'image': 'assets/images/oversize_tshirt.png'},
    {'name': 'Ripped Jeans', 'image': 'assets/images/ripped_jeans.png'},
    {'name': 'Bomber Jacket', 'image': 'assets/images/bomer_jacket.png'},
  ];

  final List<Map<String, String>> hotFavorites = const [
    {'name': 'Sweatshirts', 'image': 'assets/images/sweatshirt.png'},
    {'name': 'Baseball T-shirt', 'image': 'assets/images/baseball_tshirt.png'},
    {'name': 'Joggers', 'image': 'assets/images/joggers.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Updated Search Bar
                Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Color.fromARGB(255, 10, 10, 10), fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Search for products",
                      hintStyle: TextStyle(color: Color.fromARGB(179, 3, 3, 3), fontSize: 14),
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Color.fromARGB(179, 231, 223, 223), size: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Categories Section
                const Text('Categories', style: AppTextStyles.heading),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(category['image']!),
                            backgroundColor: AppColors.white,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['name']!,
                            style: AppTextStyles.subheading,
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // New Arrivals Section
                const Text('New Arrivals', style: AppTextStyles.heading),
                const SizedBox(height: 12),
                SizedBox(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: newArrivals.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final item = newArrivals[index];
                      return Container(
                        width: 140,
                        decoration: BoxDecoration(
                          color: AppColors.denimBlue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: Image.asset(
                                  item['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                item['name']!,
                                style: AppTextStyles.subheading.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // Hot Favorites Section
                const Text('Hot Favorites', style: AppTextStyles.heading),
                const SizedBox(height: 12),
                SizedBox(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: hotFavorites.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final fav = hotFavorites[index];
                      return Container(
                        width: 140,
                        decoration: BoxDecoration(
                          color: AppColors.devilRed,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: Image.asset(
                                  fav['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                fav['name']!,
                                style: AppTextStyles.subheading.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.black,
  selectedItemColor: AppColors.pinkAccent,
  unselectedItemColor: const Color.fromARGB(179, 255, 255, 255),
  type: BottomNavigationBarType.fixed, // Needed for more than 3 items
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"), // 🛒 Cart Icon
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ],
),
    );
  }
}
