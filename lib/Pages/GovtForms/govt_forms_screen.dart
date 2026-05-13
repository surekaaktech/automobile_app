import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Widget/Footer/footer.dart';

class GovtFormsScreen extends StatefulWidget {
  const GovtFormsScreen({super.key});

  @override
  State<GovtFormsScreen> createState() => _GovtFormsScreenState();
}

class _GovtFormsScreenState extends State<GovtFormsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Map<String, dynamic>> _forms = [
    {
      "title": "Driving License Application",
      "description": "Apply for a new permanent driving license or renew existing one.",
      "category": "Vehicle Forms List",
      "icon": Icons.badge,
      "url": "https://sarathi.parivahan.gov.in/",
      "color": Color(0xFF4CAF50),
    },
    {
      "title": "Learner License Form",
      "description": "Application for Learner's License for new drivers.",
      "category": "Vehicle Forms List",
      "icon": Icons.school,
      "url": "https://sarathi.parivahan.gov.in/",
      "color": Color(0xFF2196F3),
    },
    {
      "title": "RC Transfer Form",
      "description": "Application for transfer of vehicle ownership (Form 29 & 30).",
      "category": "Vehicle Forms List",
      "icon": Icons.swap_horiz,
      "url": "https://vahan.parivahan.gov.in/",
      "color": Color(0xFF955BFF),
    },
    {
      "title": "Vehicle Registration Form",
      "description": "Application for registration of a new motor vehicle.",
      "category": "Vehicle Forms List",
      "icon": Icons.app_registration,
      "url": "https://vahan.parivahan.gov.in/",
      "color": Color(0xFFFF9800),
    },
    {
      "title": "Duplicate RC Form",
      "description": "Application for issue of duplicate Registration Certificate.",
      "category": "Vehicle Forms List",
      "icon": Icons.copy,
      "url": "https://vahan.parivahan.gov.in/",
      "color": Color(0xFFE91E63),
    },
    {
      "title": "Address Change Form",
      "description": "Intimation of change of address in Registration Certificate.",
      "category": "Vehicle Forms List",
      "icon": Icons.home,
      "url": "https://vahan.parivahan.gov.in/",
      "color": Color(0xFF00BCD4),
    },
    {
      "title": "Vehicle Ownership Transfer",
      "description": "Complete process for transferring vehicle ownership.",
      "category": "Vehicle Forms List",
      "icon": Icons.person_add,
      "url": "https://vahan.parivahan.gov.in/",
      "color": Color(0xFF673AB7),
    },
    {
      "title": "PUC Certificate Info",
      "description": "Pollution Under Control certificate status and renewal.",
      "category": "Vehicle Forms List",
      "icon": Icons.eco,
      "url": "https://pucportal.gov.in/",
      "color": Color(0xFF8BC34A),
    },
    {
      "title": "Insurance Claim Form",
      "description": "Guidelines and forms for motor insurance claims.",
      "category": "Vehicle Forms List",
      "icon": Icons.security,
      "url": "https://www.irdai.gov.in/",
      "color": Color(0xFFF44336),
    },
    {
      "title": "Permit Application",
      "description": "Apply for various vehicle permits (National, State, Goods).",
      "category": "Vehicle Forms List",
      "icon": Icons.description,
      "url": "https://vahan.parivahan.gov.in/",
      "color": Color(0xFF795548),
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  List<Map<String, dynamic>> _getFilteredForms(String category) {
    return _forms.where((f) {
      final matchesCategory = f["category"] == category;
      final matchesSearch = _searchQuery.isEmpty ||
          f["title"].toString().toLowerCase().contains(_searchQuery) ||
          f["description"].toString().toLowerCase().contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ["Vehicle Forms List"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3EDFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back, color: Color(0xFF4A5578), size: 24),
          ),
        ),
        title: const Text(
          'Govt Forms',
          style: TextStyle(
            color: Color(0xFF0C1427),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
        ),
      ),
      bottomNavigationBar: const CustomFooter(currentIndex: -1),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search forms...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
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
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category sections
                    ...categories.map((category) {
                      final forms = _getFilteredForms(category);
                      if (forms.isEmpty) return const SizedBox.shrink();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(category),
                          ...forms.map((form) => _buildFormCard(form)),
                          const SizedBox(height: 20),
                        ],
                      );
                    }),

                    const SizedBox(height: 12),

                    // Official Portals Section
                    _buildSectionTitle("Official Parivahan / RTO Websites"),
                    const SizedBox(height: 8),
                    _buildPortalChips(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C1427),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: const Color(0xFF222845),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(Map<String, dynamic> form) {
    final Color color = form["color"] as Color;
    return GestureDetector(
      onTap: () => _launchURL(form["url"]),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(form["icon"] as IconData, color: color, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    form["title"],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C1427),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    form["description"],
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.open_in_new, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildPortalChips() {
    final portals = [
      {"name": "Parivahan Sewa", "url": "https://parivahan.gov.in/"},
      {"name": "Vahan NR", "url": "https://vahan.parivahan.gov.in/"},
      {"name": "Sarathi NR", "url": "https://sarathi.parivahan.gov.in/"},
      {"name": "mParivahan", "url": "https://play.google.com/store/apps/details?id=com.nic.mparivahan"},
      {"name": "eChallan", "url": "https://echallan.gov.in/"},
      {"name": "PUC Portal", "url": "https://pucportal.gov.in/"},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: portals.map((p) {
        return InkWell(
          onTap: () => _launchURL(p["url"]!),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3EDFF),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE0D4FF)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language, size: 16, color: Color(0xFF4A5578)),
                const SizedBox(width: 6),
                Text(
                  p["name"]!,
                  style: const TextStyle(
                    color: Color(0xFF4A5578),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
