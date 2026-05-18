import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Theme/app_colors.dart';
import '../../Widget/Footer/footer.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
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
          'Vehicle Loan',
          style: TextStyle(
            color: AppColors.textLight,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const CustomFooter(currentIndex: -1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Loan Categories
              _buildSectionTitle("Loan Categories"),
              const SizedBox(height: 12),
              _buildLoanCard(
                icon: Icons.two_wheeler,
                title: "Two-Wheeler Loan",
                description: "Bike & scooter loans at competitive interest rates.",
                color: AppColors.primary,
                bankName: "HDFC Bank",
                url: "https://www.hdfcbank.com/personal/borrow/popular-loans/two-wheeler-loan",
              ),
              _buildLoanCard(
                icon: Icons.directions_car,
                title: "Car Loan",
                description: "New & used car financing with easy EMI options.",
                color: AppColors.primaryLight,
                bankName: "SBI",
                url: "https://sbi.co.in/web/personal-banking/loans/auto-loans/car-loan",
              ),
              _buildLoanCard(
                icon: Icons.local_shipping,
                title: "Commercial Vehicle Loan",
                description: "Trucks, buses & fleet financing for your business.",
                color: AppColors.secondary,
                bankName: "ICICI Bank",
                url: "https://www.icicibank.com/business-banking/loans/commercial-vehicle-loan",
              ),
              _buildLoanCard(
                icon: Icons.electric_car,
                title: "Electric Vehicle Loan",
                description: "Special rates for EV purchases with govt subsidy benefits.",
                color: AppColors.accent,
                bankName: "SBI Green Car Loan",
                url: "https://sbi.co.in/web/personal-banking/loans/auto-loans/green-car-loan",
              ),
              _buildLoanCard(
                icon: Icons.agriculture,
                title: "Tractor / Farm Vehicle Loan",
                description: "Agricultural vehicle financing with flexible tenure.",
                color: AppColors.primaryDark,
                bankName: "Bank of Baroda",
                url: "https://www.bankofbaroda.in/personal-banking/loans/tractor-loan",
              ),
              _buildLoanCard(
                icon: Icons.build,
                title: "Used Vehicle Loan",
                description: "Pre-owned vehicle loans with quick approval.",
                color: AppColors.textSecondary,
                bankName: "Bajaj Finance",
                url: "https://www.bajajfinserv.in/used-car-loan",
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        const Icon(Icons.account_balance_wallet, color: AppColors.primary, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildLoanCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required String bankName,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.02),
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
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      bankName,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.open_in_new, size: 18, color: AppColors.secondary),
          ],
        ),
      ),
    );
  }
}
