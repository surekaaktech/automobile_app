import 'package:flutter/material.dart';
import '../../Theme/app_colors.dart';
import '../../Widget/Footer/footer.dart';
import 'dart:html' as html;

class VehicleDocumentsScreen extends StatefulWidget {
  const VehicleDocumentsScreen({super.key});

  @override
  State<VehicleDocumentsScreen> createState() => _VehicleDocumentsScreenState();
}

class _VehicleDocumentsScreenState extends State<VehicleDocumentsScreen> {
  // Track uploaded file for each document type
  final Map<String, html.File?> _uploadedFiles = {
    'RC Book': null,
    'Insurance': null,
    'Driving License': null,
  };

  final Map<String, String> _uploadedFileNames = {
    'RC Book': '',
    'Insurance': '',
    'Driving License': '',
  };

  final Map<String, IconData> _docIcons = {
    'RC Book': Icons.directions_car_outlined,
    'Insurance': Icons.security_outlined,
    'Driving License': Icons.badge_outlined,
  };

  final Map<String, String> _docDescriptions = {
    'RC Book': 'Vehicle Registration Certificate',
    'Insurance': 'Vehicle Insurance Policy',
    'Driving License': 'Government Issued License',
  };

  Future<void> _openDocumentPicker(String docType) async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.pdf,.jpg,.jpeg,.png';
    uploadInput.click();

    await uploadInput.onChange.first;
    if (uploadInput.files != null && uploadInput.files!.isNotEmpty) {
      final file = uploadInput.files!.first;
      setState(() {
        _uploadedFiles[docType] = file;
        _uploadedFileNames[docType] = file.name;
      });

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _DocumentViewPage(
              fileName: file.name,
              file: file,
              docType: docType,
            ),
          ),
        );
      }
    }
  }

  void _viewDocument(String docType) {
    final file = _uploadedFiles[docType];
    final fileName = _uploadedFileNames[docType] ?? '';
    if (file != null && fileName.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _DocumentViewPage(
            fileName: fileName,
            file: file,
            docType: docType,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Vehicle Documents",
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
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
            const Text(
              "UPLOAD DOCUMENTS",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            _buildDocumentCard('RC Book'),
            const SizedBox(height: 16),
            _buildDocumentCard('Insurance'),
            const SizedBox(height: 16),
            _buildDocumentCard('Driving License'),
            const SizedBox(height: 24),
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
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.directions_car, color: AppColors.surface, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Porsche 911 GT3",
                  style: TextStyle(color: AppColors.surface, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "MH-12-AB-1234",
                  style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(String docType) {
    final bool isUploaded = _uploadedFiles[docType] != null;
    final String fileName = _uploadedFileNames[docType] ?? '';
    final IconData icon = _docIcons[docType] ?? Icons.description_outlined;
    final String description = _docDescriptions[docType] ?? '';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUploaded ? AppColors.success.withOpacity(0.4) : AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
               Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      docType,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      description,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isUploaded
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isUploaded ? "Uploaded" : "Pending",
                  style: TextStyle(
                    color: isUploaded ? AppColors.success : AppColors.warning,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // Uploaded file info
          if (isUploaded) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.insert_drive_file_outlined, color: AppColors.primary, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      fileName,
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.check_circle, color: AppColors.primary, size: 18),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _openDocumentPicker(docType),
                  icon: Icon(
                    isUploaded ? Icons.refresh : Icons.upload_file,
                    size: 18,
                  ),
                  label: Text(isUploaded ? "Replace" : "Upload PDF"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              if (isUploaded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _viewDocument(docType),
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text("View"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Document Viewer Page ──────────────────────────────────────────────────────

class _DocumentViewPage extends StatefulWidget {
  final String fileName;
  final html.File file;
  final String docType;
  const _DocumentViewPage({required this.fileName, required this.file, required this.docType});

  @override
  State<_DocumentViewPage> createState() => _DocumentViewPageState();
}

class _DocumentViewPageState extends State<_DocumentViewPage> {
  String? _blobUrl;

  @override
  void initState() {
    super.initState();
    _blobUrl = html.Url.createObjectUrl(widget.file);
  }

  @override
  void dispose() {
    if (_blobUrl != null) html.Url.revokeObjectUrl(_blobUrl!);
    super.dispose();
  }

  void _openInNewTab() {
    if (_blobUrl != null) {
      html.window.open(_blobUrl!, '_blank');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPdf = widget.fileName.toLowerCase().endsWith('.pdf');
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.docType,
          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new, color: AppColors.primary),
            tooltip: "Open in new tab",
            onPressed: _openInNewTab,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Document icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPdf ? Icons.picture_as_pdf : Icons.image,
                color: AppColors.primary,
                size: 56,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.fileName,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Verified badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.success.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.verified, color: AppColors.primary, size: 16),
                  SizedBox(width: 6),
                  Text(
                    "Verified & Uploaded",
                    style: TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Document info card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _infoRow("Document Type", widget.docType),
                  const Divider(height: 24),
                  _infoRow("File Format", isPdf ? "PDF Document" : "Image"),
                  const Divider(height: 24),
                  _infoRow("Status", "Active"),
                  const Divider(height: 24),
                  _infoRow("Uploaded On", _todayDate()),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Open Document button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _openInNewTab,
                icon: const Icon(Icons.open_in_new, size: 20),
                label: const Text(
                  "OPEN DOCUMENT",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: const CustomFooter(currentIndex: 3),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  String _todayDate() {
    final now = DateTime.now();
    return "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
  }
}
