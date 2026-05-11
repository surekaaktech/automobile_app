import 'package:flutter/material.dart';
import '../../Widget/Footer/footer.dart';
import 'company_compare_screen.dart';
import 'business_details_screen.dart';
import '../../State/favorites_state.dart';
import '../Favorite/favorite_screen.dart';
import '../Profile/profile_screen.dart';

class CompanyListingScreen extends StatefulWidget {
  final String categoryName;
  final String subcategoryName;

  const CompanyListingScreen({
    super.key,
    required this.categoryName,
    required this.subcategoryName,
  });

  @override
  State<CompanyListingScreen> createState() => _CompanyListingScreenState();
}

class _CompanyListingScreenState extends State<CompanyListingScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = ["All", "Nearby", "Top rated", "Open now"];
  String _selectedFilter = "All";

  // State to track selected companies for comparison
  final Set<int> _selectedCompanies = {};

  final List<Map<String, dynamic>> _companies = [
    {
      "id": 1,
      "name": "Quick Bike Fix",
      "category": "Service",
      "location": "78 Tambaram, Chennai",
      "rating": "4.5",
      "distance": "2.5 km",
      "isOpen": true,
    },
    {
      "id": 2,
      "name": "Speedy Auto Repair",
      "category": "Service",
      "location": "12 Velachery, Chennai",
      "rating": "4.2",
      "distance": "4.1 km",
      "isOpen": true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildCompanyCard(Map<String, dynamic> company) {
    final bool isSelected = _selectedCompanies.contains(company["id"]);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessDetailsScreen(company: company),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company["name"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C1427),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company["category"],
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          company["location"],
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Color(0xFF222845)),
                      const SizedBox(width: 4),
                      Text(
                        company["rating"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF0C1427),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        company["distance"],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (company["isOpen"])
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF222845),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Open",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Trailing Icons
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      FavoritesState.toggleFavorite(company);
                    });
                  },
                  icon: Icon(
                    FavoritesState.isFavorite(company["id"]) ? Icons.favorite : Icons.favorite_border,
                    color: const Color(0xFF0C1427),
                    size: 20,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedCompanies.remove(company["id"]);
                      } else {
                        _selectedCompanies.add(company["id"]);
                      }
                    });
                  },
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF0066CC) : Colors.white,
                      border: Border.all(color: isSelected ? const Color(0xFF0066CC) : Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Go back to subcategory screen
              },
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF0C1427),
                size: 24,
              ),
            ),
            Expanded(
              child: Text(
                '${widget.categoryName} • ${widget.subcategoryName}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF0C1427),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 24), // Invisible placeholder to balance the back arrow
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedCompanies.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedCompanies.length < 2) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Compare Companies"),
                        content: const Text("Please select at least 2 companies to compare."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  final selected = _companies
                      .where((c) => _selectedCompanies.contains(c["id"]))
                      .toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompanyCompareScreen(
                        companies: selected,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF222845),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Compare (${_selectedCompanies.length})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          // Show the CustomFooter below the compare button
          CustomFooter(
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
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search auto services...',
                  hintStyle: const TextStyle(color: Colors.black38),
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF222845)),
                  ),
                ),
                onSubmitted: (value) {
                  // Perform search logic here
                },
              ),
              const SizedBox(height: 16),

              // Filter Chips Row
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _filters.map((filter) {
                          final isSelected = _selectedFilter == filter;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedFilter = filter;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF222845) : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF222845) : Colors.grey.shade300,
                                  ),
                                ),
                                child: Text(
                                  filter,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : const Color(0xFF0C1427),
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Filter Icon Button
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(Icons.filter_alt_outlined, size: 20, color: Color(0xFF0C1427)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Decorative Scrollbar / Line
              Row(
                children: [
                  const Icon(Icons.arrow_left, color: Colors.grey, size: 16),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_right, color: Colors.grey, size: 16),
                ],
              ),
              const SizedBox(height: 16),

              // Results Count
              Text(
                '${_companies.length} results near Chennai',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),

              // Render Companies
              ..._companies.map((company) => _buildCompanyCard(company)),
            ],
          ),
        ),
      ),
    );
  }
}
