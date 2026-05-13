import 'package:flutter/material.dart';
import '../../Widget/Footer/footer.dart';
import '../Profile/profile_screen.dart';
import '../Emergency/Emergency_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LawsScreen extends StatefulWidget {
  const LawsScreen({super.key});

  @override
  State<LawsScreen> createState() => _LawsScreenState();
}

class _LawsScreenState extends State<LawsScreen> {
  int _currentIndex = 2; // Index for Laws

  // Updated list of laws with categories and official URLs
  final List<Map<String, String>> _laws = [
    // 2 Wheeler Laws
    {
      "title": "Helmet Mandatory",
      "description": "Both rider and pillion must wear BIS‑standard helmets.",
      "category": "2 Wheeler",
      "url": "https://parivahan.gov.in/",
    },
    {
      "title": "Triple Riding Prohibited",
      "description": "Carrying more than one passenger is illegal.",
      "category": "2 Wheeler",
      "url": "https://morth.nic.in/",
    },
    {
      "title": "No Mobile While Riding",
      "description": "Using mobile phones while riding is prohibited.",
      "category": "2 Wheeler",
      "url": "https://echallan.gov.in/",
    },
    // 4 Wheeler Laws
    {
      "title": "Seat Belt Mandatory",
      "description": "All occupants must wear seat belts.",
      "category": "4 Wheeler",
      "url": "https://parivahan.gov.in/",
    },
    {
      "title": "Insurance Required",
      "description": "Valid third‑party insurance is compulsory.",
      "category": "4 Wheeler",
      "url": "https://morth.nic.in/",
    },
    {
      "title": "PUC Mandatory",
      "description": "Pollution Under Control certificate must be valid.",
      "category": "4 Wheeler",
      "url": "https://pucportal.gov.in/",
    },
  ];

  // Helper to launch URLs
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }


  List<Map<String, String>> _filteredLaws = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredLaws = _laws;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredLaws = _laws.where((law) {
        final title = law["title"]!.toLowerCase();
        final desc = law["description"]!.toLowerCase();
        final query = _searchController.text.toLowerCase();
        return title.contains(query) || desc.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
          'Traffic Laws',
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
      bottomNavigationBar: CustomFooter(
        currentIndex: _currentIndex,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search laws...",
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
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2 Wheeler Laws Section
                    _buildSectionTitle("2 Wheeler Laws"),
                    ..._laws
                        .where((l) => l["category"] == "2 Wheeler" && 
                            (l["title"]!.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                             l["description"]!.toLowerCase().contains(_searchController.text.toLowerCase())))
                        .map((law) => _buildLawCard(law)),
                    
                    const SizedBox(height: 24),
                    
                    // 4 Wheeler Laws Section
                    _buildSectionTitle("4 Wheeler Laws"),
                    ..._laws
                        .where((l) => l["category"] == "4 Wheeler" && 
                            (l["title"]!.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                             l["description"]!.toLowerCase().contains(_searchController.text.toLowerCase())))
                        .map((law) => _buildLawCard(law)),
                    
                    const SizedBox(height: 32),
                    
                    // Recommended Official URLs Section
                    _buildSectionTitle("Recommended Official URLs"),
                    _buildUrlSection(),
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

  Widget _buildLawCard(Map<String, String> law) {
    return GestureDetector(
      onTap: () => _launchURL(law["url"]!),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    law["title"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C1427),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    law["description"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
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

  Widget _buildUrlSection() {
    final urls = [
      {"name": "Parivahan", "url": "https://parivahan.gov.in/"},
      {"name": "MoRTH", "url": "https://morth.nic.in/"},
      {"name": "eChallan", "url": "https://echallan.gov.in/"},
      {"name": "PUC Portal", "url": "https://pucportal.gov.in/"},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: urls.map((u) {
        return InkWell(
          onTap: () => _launchURL(u["url"]!),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3EDFF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE0D4FF)),
            ),
            child: Text(
              u["name"]!,
              style: const TextStyle(
                color: Color(0xFF4A5578),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
