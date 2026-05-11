import 'package:flutter/material.dart';
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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subcategories = [
      {
        "icon": Icons.shopping_cart_outlined,
        "title": "Sales",
        "subtitle": "New & used",
      },
      {
        "icon": Icons.build_outlined,
        "title": "Service",
        "subtitle": "Repair",
      },
      {
        "icon": Icons.auto_awesome_outlined,
        "title": "Vehicle Care",
        "subtitle": "Wash & detail",
      },
      {
        "icon": Icons.inventory_2_outlined,
        "title": "Accessories",
        "subtitle": "Parts & add-ons",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // We will build a custom leading button
        titleSpacing: 16,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Moves back to the home screen
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EDFF), // Light purple background
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF4A5578), // Darker icon color
                  size: 20,
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.categoryName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF0C1427),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Invisible placeholder to keep text centered
            const SizedBox(width: 36), 
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
        ),
      ),
      bottomNavigationBar: CustomFooter(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoriteScreen()),
            ).then((_) => setState(() {}));
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            ).then((_) => setState(() {}));
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Powered By text container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Powered by Yellow Pages",
                  style: TextStyle(
                    color: Color(0xFF6C757D),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Subcategory List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subcategories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          // Icon Container
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9ECEF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              item["icon"] as IconData,
                              color: const Color(0xFF0C1427),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          
                          // Texts
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF0C1427),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item["subtitle"] as String,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Trailing Arrow
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade500,
                            size: 24,
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
