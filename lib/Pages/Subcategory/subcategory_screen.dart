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
  int _currentIndex = -1;

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
        toolbarHeight: 80,
        backgroundColor: Colors.white,
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
                  color: const Color(0xFFF3EDFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF4A5578),
                  size: 24,
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.categoryName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF0C1427),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 44), 
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
      bottomNavigationBar: const CustomFooter(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Icon Container
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Color(0xFF7C4DFF),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item["icon"] as IconData,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 20),
                          
                          // Texts
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFF0C1427),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item["subtitle"] as String,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Trailing Arrow
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade500,
                            size: 28,
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
