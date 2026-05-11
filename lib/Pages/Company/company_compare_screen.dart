import 'package:flutter/material.dart';
import '../../Widget/Footer/footer.dart';

class CompanyCompareScreen extends StatefulWidget {
  final List<Map<String, dynamic>> companies;

  const CompanyCompareScreen({super.key, required this.companies});

  @override
  State<CompanyCompareScreen> createState() => _CompanyCompareScreenState();
}

class _CompanyCompareScreenState extends State<CompanyCompareScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    int bestCompanyId = -1;
    if (widget.companies.isNotEmpty) {
      double maxRating = 0.0;
      for (var company in widget.companies) {
        double rating = double.tryParse(company["rating"] ?? "0") ?? 0.0;
        if (rating > maxRating) {
          maxRating = rating;
          bestCompanyId = company["id"];
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Color(0xFF0C1427)),
        ),
        title: const Text(
          'Compare Services',
          style: TextStyle(
            color: Color(0xFF0C1427),
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
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
      body: SafeArea(
        child: widget.companies.isEmpty
            ? const Center(child: Text("No companies selected for comparison."))
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildComparisonTable(bestCompanyId),
                ),
              ),
      ),
    );
  }

  Widget _buildComparisonTable(int bestCompanyId) {
    // Define the rows we want to show
    final features = [
      "Image",
      "Recommendation",
      "Name",
      "Category",
      "Rating",
      "Distance",
      "Status",
      "Address",
      "Action"
    ];

    return Table(
      defaultColumnWidth: const FixedColumnWidth(160.0),
      border: TableBorder.all(
        color: Colors.grey.shade300,
        width: 1,
        borderRadius: BorderRadius.circular(8),
      ),
      children: [
        // Table Header
        TableRow(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          children: [
            _buildTableCell("Feature", isHeader: true),
            ...widget.companies.map((c) => _buildTableCell("Company", isHeader: true)),
          ],
        ),
        
        // Dynamic Rows based on features
        ...features.map((feature) {
          return TableRow(
            decoration: BoxDecoration(
              color: feature == "Recommendation" ? const Color(0xFFF0F7FF) : Colors.white,
            ),
            children: [
              _buildTableCell(feature, isFeatureCol: true),
              ...widget.companies.map((c) {
                return _buildCellForFeature(c, feature, c["id"] == bestCompanyId);
              }),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, bool isFeatureCol = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader || isFeatureCol ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 16 : 14,
          color: isFeatureCol ? Colors.grey.shade700 : const Color(0xFF0C1427),
        ),
      ),
    );
  }

  Widget _buildCellForFeature(Map<String, dynamic> company, String feature, bool isBest) {
    Widget content;

    switch (feature) {
      case "Image":
        content = Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.business, size: 30, color: Colors.grey),
        );
        break;
      case "Recommendation":
        if (isBest) {
          content = Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF0066CC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text(
                  "Best Choice",
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        } else {
          content = const Text("-");
        }
        break;
      case "Name":
        content = Text(company["name"] ?? "Unknown", style: const TextStyle(fontWeight: FontWeight.bold));
        break;
      case "Category":
        content = Text(company["category"] ?? "N/A");
        break;
      case "Rating":
        content = Row(
          children: [
            const Icon(Icons.star, size: 16, color: Color(0xFF222845)),
            const SizedBox(width: 4),
            Text(company["rating"] ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        );
        break;
      case "Distance":
        content = Text(company["distance"] ?? "N/A");
        break;
      case "Status":
        final isOpen = company["isOpen"] == true;
        content = Text(
          isOpen ? "Open" : "Closed",
          style: TextStyle(
            color: isOpen ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
        break;
      case "Address":
        content = Text(company["location"] ?? "N/A", maxLines: 3, overflow: TextOverflow.ellipsis);
        break;
      case "Action":
        content = ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF222845),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Book Now"),
        );
        break;
      default:
        content = const Text("-");
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: content,
      ),
    );
  }
}
