import 'package:flutter/material.dart';
import '../../Widget/Footer/footer.dart';
import 'company_compare_screen.dart';
import 'business_details_screen.dart';
import '../../State/favorites_state.dart';
import '../../Theme/app_colors.dart';

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
  int _currentIndex = -1;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = ["All", "Nearby", "Top rated", "Open now"];
  String _selectedFilter = "All";

  // State to track selected companies for comparison
  final Set<int> _selectedCompanies = {};
  List<Map<String, dynamic>> _filteredCompanies = [];

  @override
  void initState() {
    super.initState();
    _filteredCompanies = _companies;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _filteredCompanies = _companies.where((company) {
        final name = company["name"].toString().toLowerCase();
        final query = _searchController.text.toLowerCase();
        final matchesSearch = name.contains(query);

        if (_selectedFilter == "All") return matchesSearch;
        if (_selectedFilter == "Top rated") {
          return matchesSearch && double.parse(company["rating"]) >= 4.5;
        }
        if (_selectedFilter == "Open now") {
          return matchesSearch && company["isOpen"] == true;
        }
        if (_selectedFilter == "Nearby") {
          final dist = double.parse(company["distance"].split(' ')[0]);
          return matchesSearch && dist < 3.0;
        }
        return matchesSearch;
      }).toList();
    });
  }

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

  Widget _buildCompanyCard(Map<String, dynamic> company) {
    final bool isSelected = _selectedCompanies.contains(company["id"]);
    final bool isFav = FavoritesState.isFavorite(company["id"]);

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
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.97)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary.withOpacity(0.5) : AppColors.border,
            width: isSelected ? 2.0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.05 : 0.02),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏍️ Modern Rounded Icon Wrapper
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withOpacity(0.12), AppColors.primary.withOpacity(0.04)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.primary.withOpacity(0.08), width: 1.5),
              ),
              child: const Icon(Icons.directions_bike_outlined, color: AppColors.primary, size: 32),
            ),
            const SizedBox(width: 18),

            // 📝 Text Fields & Subcategories
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company["name"],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company["category"],
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 15, color: AppColors.secondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          company["location"],
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // 🏷️ Trendy Glass Capsules Row
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      // Gold Rating Capsule
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.accent.withOpacity(0.25), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, size: 13, color: AppColors.accent),
                            const SizedBox(width: 4),
                            Text(
                              company["rating"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Distance Capsule
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.secondary.withOpacity(0.15), width: 1),
                        ),
                        child: Text(
                          company["distance"],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),

                      // Open Badge Capsule
                      if (company["isOpen"])
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.green.withOpacity(0.2), width: 1),
                          ),
                          child: const Text(
                            "Open Now",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // 🛎️ Interactive Right Action Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      FavoritesState.toggleFavorite(company);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isFav ? AppColors.accentRed.withOpacity(0.08) : AppColors.background,
                      shape: BoxShape.circle,
                      border: Border.all(color: isFav ? AppColors.accentRed.withOpacity(0.2) : AppColors.border),
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? AppColors.accentRed : AppColors.secondary,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                
                // Circular Glowing Selector Checkbox for Compare
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryLight],
                            )
                          : null,
                      color: isSelected ? null : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.secondary.withOpacity(0.4),
                        width: 2.0,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 15, color: Colors.white)
                        : null,
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
                  border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
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
                '${widget.categoryName} • ${widget.subcategoryName}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 18,
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedCompanies.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedCompanies.length < 2) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: const Text("Compare Companies", style: TextStyle(fontWeight: FontWeight.bold)),
                          content: const Text("Please select at least 2 companies to compare."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
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
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Compare (${_selectedCompanies.length} selected)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          CustomFooter(
            currentIndex: _currentIndex,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Stylized Gradient Search Bar
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: 'Search auto services...',
                    hintStyle: const TextStyle(color: AppColors.textSecondary),
                    prefixIcon: const Icon(Icons.search, color: AppColors.primary, size: 22),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🏷️ Trendy filter chips row
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _filters.map((filter) {
                          final isSelected = _selectedFilter == filter;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedFilter = filter;
                                  _applyFilters();
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? const LinearGradient(
                                          colors: [AppColors.primary, AppColors.primaryLight],
                                        )
                                      : null,
                                  color: isSelected ? null : Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: isSelected ? AppColors.primary : AppColors.border,
                                    width: 1.5,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.primary.withOpacity(0.2),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          )
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  filter,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Filter Icon Button
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border, width: 1.5),
                    ),
                    child: const Icon(Icons.filter_alt_outlined, size: 20, color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Decorative Scrollbar / Line
              Row(
                children: [
                  const Icon(Icons.arrow_left, color: AppColors.secondary, size: 16),
                  Expanded(
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_right, color: AppColors.secondary, size: 16),
                ],
              ),
              const SizedBox(height: 18),

              // Results Count
              Text(
                '${_filteredCompanies.length} results near Chennai',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),

              // Render Companies
              if (_filteredCompanies.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text("No results found", style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                  ),
                )
              else
                ..._filteredCompanies.map((company) => _buildCompanyCard(company)),
            ],
          ),
        ),
      ),
    );
  }
}
