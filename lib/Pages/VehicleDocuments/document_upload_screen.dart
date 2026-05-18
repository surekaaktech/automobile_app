import 'package:flutter/material.dart';
import '../../Widget/Footer/footer.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  String selectedDocType = "INSURANCE";
  bool isUploading = false;
  double uploadProgress = 0.0;
  bool isUploaded = false;

  final List<String> docTypes = [
    "RC BOOK",
    "INSURANCE",
    "DRIVING LICENSE"
  ];

  // Dark slate theme matching the image
  final Color darkBg = const Color(0xFF12151C);
  final Color cardBg = const Color(0xFF1C212D);
  final Color accentCyan = const Color(0xFF45A29E); // Teal/Cyan accent
  final Color textWhite = Colors.white;
  final Color textGrey = const Color(0xFF8B93A6);

  void _simulateUpload() {
    setState(() {
      isUploading = true;
      uploadProgress = 0.0;
      isUploaded = false;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => uploadProgress = 0.35);
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) setState(() => uploadProgress = 0.85);
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          uploadProgress = 1.0;
          isUploading = false;
          isUploaded = true;
        });
      }
    });
  }

  void _resetUpload() {
    setState(() {
      isUploading = false;
      isUploaded = false;
      uploadProgress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: darkBg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: accentCyan),
          onPressed: () => Navigator.pop(context, false), // cancel
        ),
        title: Text(
          "Upload Document",
          style: TextStyle(color: textWhite, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVehicleCard(),
            const SizedBox(height: 24),
            Text(
              "SELECT DOCUMENT TYPE",
              style: TextStyle(color: textGrey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            const SizedBox(height: 12),
            _buildDocTypeSelector(),
            const SizedBox(height: 24),
            
            // Only PDF file option is needed as requested
            if (!isUploading && !isUploaded)
              _buildUploadCard(),

            if (isUploading || isUploaded)
              _buildProgressCard(),

            const SizedBox(height: 40),
            _buildBottomButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const CustomFooter(currentIndex: 3),
    );
  }

  Widget _buildVehicleCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?auto=format&fit=crop&w=150&q=80',
              width: 80,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Porsche 911 GT3",
                  style: TextStyle(color: accentCyan, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "MH-12-AB-1234",
                  style: TextStyle(color: textWhite, fontSize: 12, letterSpacing: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocTypeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: docTypes.map((type) {
          bool isSelected = selectedDocType == type;
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() => selectedDocType = type);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? accentCyan.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? accentCyan : textGrey.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: isSelected ? accentCyan : textGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUploadCard() {
    return GestureDetector(
      onTap: _simulateUpload,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentCyan.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.picture_as_pdf, color: accentCyan, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              "Choose PDF File",
              style: TextStyle(color: textWhite, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Upload a PDF document",
              style: TextStyle(color: textGrey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2522), // Orange-ish tint background
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.description, color: Color(0xFFD98A6C)), // Orange icon
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Insurance_Policy.pdf",
                          style: TextStyle(color: textWhite, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${(uploadProgress * 100).toInt()}%",
                          style: TextStyle(color: accentCyan, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: uploadProgress,
                        backgroundColor: darkBg,
                        color: accentCyan,
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isUploading ? "Uploading..." : "Completed",
                      style: TextStyle(color: textGrey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _simulateUpload,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textWhite,
                    side: BorderSide(color: textGrey.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("REPLACE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetUpload,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD98A6C), // Error/orange color
                    side: BorderSide(color: textGrey.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("DELETE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isUploaded ? () {
              Navigator.pop(context, true); // Save document and return true
            } : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: accentCyan,
              disabledBackgroundColor: accentCyan.withOpacity(0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              "SAVE DOCUMENT",
              style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => Navigator.pop(context, false), // Cancel and return false
          child: Text(
            "CANCEL",
            style: TextStyle(color: textWhite, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
        ),
      ],
    );
  }
}
