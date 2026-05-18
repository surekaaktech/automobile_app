import 'package:flutter/material.dart';
import '../../Widget/Footer/footer.dart';
import '../../Theme/app_colors.dart';

class CompanyCompareScreen extends StatefulWidget {
  final List<Map<String, dynamic>> companies;

  const CompanyCompareScreen({super.key, required this.companies});

  @override
  State<CompanyCompareScreen> createState() => _CompanyCompareScreenState();
}

class _CompanyCompareScreenState extends State<CompanyCompareScreen> {
  int _currentIndex = -1;

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back, color: AppColors.textLight, size: 24),
          ),
        ),
        title: const Text(
          'Compare Services',
          style: TextStyle(
            color: AppColors.textLight,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: CustomFooter(
        currentIndex: _currentIndex,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: widget.companies.isEmpty
              ? const Center(child: Text("No companies selected for comparison.", style: TextStyle(color: AppColors.textSecondary)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _buildComparisonTable(bestCompanyId),
                    ),
                  ),
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
        color: AppColors.border,
        width: 1.5,
        borderRadius: BorderRadius.circular(12),
      ),
      children: [
        // Table Header
        TableRow(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
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
              color: feature == "Recommendation" ? AppColors.primary.withOpacity(0.08) : AppColors.surface,
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
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isHeader || isFeatureCol ? FontWeight.bold : FontWeight.normal,
            fontSize: isHeader ? 16 : 14,
            color: isFeatureCol ? AppColors.textSecondary : AppColors.textPrimary,
          ),
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
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.business, size: 30, color: AppColors.primary),
        );
        break;
      case "Recommendation":
        if (isBest) {
          content = Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: AppColors.primary, size: 14),
                SizedBox(width: 4),
                Text(
                  "Best Choice",
                  style: TextStyle(color: AppColors.textLight, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        } else {
          content = const Text("-", style: TextStyle(color: AppColors.textSecondary));
        }
        break;
      case "Name":
        content = Text(company["name"] ?? "Unknown", style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary));
        break;
      case "Category":
        content = Text(company["category"] ?? "N/A", style: const TextStyle(color: AppColors.textSecondary));
        break;
      case "Rating":
        content = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(company["rating"] ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          ],
        );
        break;
      case "Distance":
        content = Text(company["distance"] ?? "N/A", style: const TextStyle(color: AppColors.textPrimary));
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
        content = Text(company["location"] ?? "N/A", maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13));
        break;
      case "Action":
        content = ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.phone, size: 16),
          label: const Text("Call Now"),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textLight,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        break;
      default:
        content = const Text("-", style: TextStyle(color: AppColors.textSecondary));
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: content,
      ),
    );
  }
}
