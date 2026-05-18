import 'package:flutter/material.dart';
import '../../Theme/app_colors.dart';
import '../../Widget/Footer/footer.dart';
import '../Company/company_listing_screen.dart';
import '../Profile/profile_screen.dart';
import '../Favorite/favorite_screen.dart';

class SubcategoryScreen extends StatefulWidget {
  final String categoryName;

  const SubcategoryScreen({super.key, required this.categoryName});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subcategories = [
      {
        "icon": Icons.shopping_cart_outlined,
        "title": "Sales",
        "subtitle": "New & used vehicles",
      },
      {
        "icon": Icons.build_outlined,
        "title": "Service",
        "subtitle": "Repair & diagnostic care",
      },
      {
        "icon": Icons.auto_awesome_outlined,
        "title": "Vehicle Care",
        "subtitle": "Detailing & washing services",
      },
      {
        "icon": Icons.inventory_2_outlined,
        "title": "Accessories",
        "subtitle": "Parts, add-ons & gear",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textLight,
                  size: 24,
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.categoryName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Outfit',
                ),
              ),
            ),
            const SizedBox(width: 46), 
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      bottomNavigationBar: const CustomFooter(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Trendy Header Typo
              const Padding(
                padding: EdgeInsets.only(left: 4.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Subcategory",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Explore high-fidelity listings tailored for you",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Subcategory List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subcategories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final item = subcategories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyListingScreen(
                            categoryName: widget.categoryName,
                            subcategoryName: item["title"] as String,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.white, Color(0xFFFAFBFB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.015),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Icon Container
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.primary.withOpacity(0.12), AppColors.primary.withOpacity(0.04)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary.withOpacity(0.08), width: 1.5),
                            ),
                            child: Icon(
                              item["icon"] as IconData,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 18),
                          
                          // Texts
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                    color: AppColors.textPrimary,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item["subtitle"] as String,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Circular Trailing Arrow Wrapper
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(0.08),
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.secondary.withOpacity(0.15)),
                            ),
                            child: const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.primary,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
