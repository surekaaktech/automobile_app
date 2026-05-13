import 'package:flutter/material.dart';
import '../../Widget/Footer/footer.dart';
import '../Profile/profile_screen.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  int _currentIndex = 1; // 1 is for Emergency

  final List<Map<String, dynamic>> emergencyCategories = [
    {
      "title": "Ambulance",
      "icon": Icons.local_hospital_outlined,
      "iconColor": Colors.red,
      "contacts": [
        {"name": "Apollo Emergency Services", "location": "Greams Road, Chennai"},
        {"name": "Fortis Ambulance", "location": "Vadapalani, Chennai"},
      ]
    },
    {
      "title": "Police Station",
      "icon": Icons.local_police_outlined,
      "iconColor": Colors.blue,
      "contacts": [
        {"name": "Anna Salai Police Station", "location": "Anna Salai, Chennai"},
        {"name": "T. Nagar Police Station", "location": "T. Nagar, Chennai"},
      ]
    },
    {
      "title": "Puncher Shop",
      "icon": Icons.build_circle_outlined,
      "iconColor": Colors.orange,
      "contacts": [
        {"name": "Sri Ram Tyres", "location": "Velachery, Chennai"},
        {"name": "Quick Fix Auto", "location": "Adyar, Chennai"},
      ]
    }
  ];

  List<Map<String, dynamic>> _filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCategories = emergencyCategories;
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
      _filteredCategories = emergencyCategories.where((category) {
        final title = category["title"].toString().toLowerCase();
        final query = _searchController.text.toLowerCase();
        
        // Also search in contacts
        final hasContactMatch = (category["contacts"] as List).any((contact) {
          final name = contact["name"].toString().toLowerCase();
          final loc = contact["location"].toString().toLowerCase();
          return name.contains(query) || loc.contains(query);
        });

        return title.contains(query) || hasContactMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
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
          'Emergency Services',
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search emergency services...",
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
                  children: _filteredCategories.isEmpty
                      ? [const Padding(padding: EdgeInsets.only(top: 40), child: Center(child: Text("No emergency services found")))]
                      : _filteredCategories.map((category) => _buildEmergencyCard(category)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyCard(Map<String, dynamic> category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFEBEBEB), // Light grey header
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    category["icon"],
                    color: category["iconColor"],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  category["title"],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C1427),
                  ),
                ),
              ],
            ),
          ),
          
          // Content Section
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: (category["contacts"] as List).map((contact) => _buildContactItem(contact)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C1427),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        contact["location"],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone_outlined, size: 16),
            label: const Text(
              "Call",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF222845),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
