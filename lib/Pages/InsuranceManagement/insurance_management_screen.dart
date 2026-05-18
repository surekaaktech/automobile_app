import 'package:flutter/material.dart';
import '../../Theme/app_colors.dart';
import '../../Widget/Footer/footer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class InsuranceManagementScreen extends StatefulWidget {
  const InsuranceManagementScreen({super.key});

  @override
  State<InsuranceManagementScreen> createState() => _InsuranceManagementScreenState();
}

class _InsuranceManagementScreenState extends State<InsuranceManagementScreen> {
  bool _isDocumentUploaded = false;
  String _uploadedFileName = "";
  html.File? _uploadedFile;

  Future<void> _launchGovtPage() async {
    final Uri url = Uri.parse('https://parivahan.gov.in/');
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  Future<void> _openDocumentPicker() async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.pdf,.jpg,.jpeg,.png';
    uploadInput.click();

    await uploadInput.onChange.first;
    if (uploadInput.files != null && uploadInput.files!.isNotEmpty) {
      final file = uploadInput.files!.first;
      setState(() {
        _uploadedFileName = file.name;
        _uploadedFile = file;
        _isDocumentUploaded = true;
      });

      // Navigate directly to the document viewer page
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _DocumentViewPage(fileName: file.name, file: file),
          ),
        );
      }
    }
  }

  void _viewDocument() {
    if (_uploadedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _DocumentViewPage(fileName: _uploadedFileName, file: _uploadedFile!),
        ),
      );
    }
  }

  void _reportAccident() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Accident reported successfully. Insurance provider notified."),
        backgroundColor: AppColors.warning,
      ),
    );
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
          "Insurance Management",
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPolicyCard(),
            const SizedBox(height: 24),
            _buildReminderCard(),
            const SizedBox(height: 24),
            const Text(
              "QUICK ACTIONS",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            _buildActionGrid(),
            const SizedBox(height: 24),
            const Text(
              "POLICY DOCUMENT",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            _buildDocumentTile(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomFooter(currentIndex: 3),
    );
  }

  Widget _buildPolicyCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Comprehensive Policy",
                style: TextStyle(color: AppColors.surface, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text("Active", style: TextStyle(color: AppColors.surface, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text("POLICY NUMBER", style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1)),
          const SizedBox(height: 4),
          const Text("POL-9876543210-AB", style: TextStyle(color: AppColors.surface, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("PROVIDER", style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1)),
                  SizedBox(height: 4),
                  Text("Reliance General", style: TextStyle(color: AppColors.surface, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text("VEHICLE", style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1)),
                  SizedBox(height: 4),
                  Text("Porsche 911 GT3", style: TextStyle(color: AppColors.surface, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard() {
    return GestureDetector(
      onTap: _launchGovtPage,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.warning.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.timer_outlined, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "INSURANCE EXPIRING SOON",
                    style: TextStyle(color: AppColors.warning, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                      children: [
                        TextSpan(text: "Expires in "),
                        TextSpan(text: "15 Days", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildActionGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: Icons.autorenew,
            title: "Renew\nInsurance",
            color: AppColors.primaryLight,
            onTap: _launchGovtPage,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionCard(
            icon: Icons.car_crash_outlined,
            title: "Report\nAccident",
            color: AppColors.error,
            onTap: _reportAccident,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionCard(
            icon: Icons.track_changes_outlined,
            title: "Track\nClaim",
            color: AppColors.accent,
            onTap: _launchGovtPage,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({required IconData icon, required String title, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.picture_as_pdf_outlined,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isDocumentUploaded ? _uploadedFileName : "No Document Found",
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _isDocumentUploaded ? "Uploaded • Tap View to open" : "Please upload your policy",
                  style: TextStyle(
                    color: _isDocumentUploaded ? AppColors.success : AppColors.warning,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: _isDocumentUploaded ? _viewDocument : _openDocumentPicker,
            style: OutlinedButton.styleFrom(
              foregroundColor: _isDocumentUploaded ? AppColors.success : AppColors.primary,
              side: BorderSide(color: _isDocumentUploaded ? AppColors.success : AppColors.primary),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              _isDocumentUploaded ? "View" : "Upload",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Inline Document Viewer Page ──────────────────────────────────────────────

class _DocumentViewPage extends StatefulWidget {
  final String fileName;
  final html.File file;
  const _DocumentViewPage({required this.fileName, required this.file});

  @override
  State<_DocumentViewPage> createState() => _DocumentViewPageState();
}

class _DocumentViewPageState extends State<_DocumentViewPage> {
  String? _blobUrl;

  @override
  void initState() {
    super.initState();
    // Create a blob URL so we can open the actual file
    _blobUrl = html.Url.createObjectUrl(widget.file);
  }

  @override
  void dispose() {
    // Revoke blob URL to free memory
    if (_blobUrl != null) {
      html.Url.revokeObjectUrl(_blobUrl!);
    }
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
          widget.fileName,
          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              const SizedBox(height: 24),
              Text(
                widget.fileName,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    Text("Verified & Uploaded", style: TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Document detail card
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
                    _infoRow("Document Type", isPdf ? "PDF Document" : "Image"),
                    const Divider(height: 24),
                    _infoRow("Category", "Insurance Policy"),
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
