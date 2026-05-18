import 'package:flutter/material.dart';
import '../../Theme/app_colors.dart';
import '../../Widget/Footer/footer.dart';
import 'map_screen.dart';

class MaintenanceReminderScreen extends StatefulWidget {
  static int globalCondition = 1;
  const MaintenanceReminderScreen({super.key});

  @override
  State<MaintenanceReminderScreen> createState() => _MaintenanceReminderScreenState();
}

class _MaintenanceReminderScreenState extends State<MaintenanceReminderScreen> {
  bool pushNotifications = true;
  bool smsReminders = true;
  bool emailUpdates = false;

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
          "Next Service Reminder",
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarCard(),
            const SizedBox(height: 20),
            _buildNextServiceCard(),
            const SizedBox(height: 20),
            _buildConditionMonitor(),
            const SizedBox(height: 20),
            _buildServiceChecklist(),
            const SizedBox(height: 20),
            _buildEstimatedCost(),
            const SizedBox(height: 20),
            _buildReminderChannels(),
            const SizedBox(height: 20),
            _buildServiceCenterInfo(),
            const SizedBox(height: 20), 
            _buildBottomActions(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomFooter(currentIndex: 3),
    );
  }

  Widget _buildCarCard() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1494976388531-d1058494cdd8?auto=format&fit=crop&w=2000&q=80'), // Placeholder car
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Porsche 911 Carrera", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("AX-772-GT", style: TextStyle(color: AppColors.silver, fontSize: 12, fontWeight: FontWeight.bold)),
                Text("34,250 KM", style: TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextServiceCard() {
    Color getSeverityColor() {
      if (MaintenanceReminderScreen.globalCondition == 0) return AppColors.success;
      if (MaintenanceReminderScreen.globalCondition == 1) return AppColors.warning;
      return AppColors.error;
    }
    
    String getSeverityText() {
      if (MaintenanceReminderScreen.globalCondition == 0) return "Good";
      if (MaintenanceReminderScreen.globalCondition == 1) return "Moderate";
      return "Immediate";
    }

    String getDaysLeft() {
      if (MaintenanceReminderScreen.globalCondition == 0) return "45 Days Left";
      if (MaintenanceReminderScreen.globalCondition == 1) return "12 Days Left";
      return "0 Days Left";
    }

    String getDistance() {
      if (MaintenanceReminderScreen.globalCondition == 0) return "8,500";
      if (MaintenanceReminderScreen.globalCondition == 1) return "2,300";
      return "Overdue";
    }

    Color activeColor = getSeverityColor();
    String severityText = getSeverityText();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: activeColor.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(color: activeColor.withOpacity(0.05), blurRadius: 15, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: activeColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  MaintenanceReminderScreen.globalCondition == 0 ? Icons.check_circle_outline : Icons.notifications_active, 
                  color: activeColor
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(getDaysLeft(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text("NEXT SERVICE", style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          const SizedBox(height: 4),
          Text("15 Aug 2026", style: TextStyle(color: activeColor, fontSize: 26, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Remaining\nDistance", style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(getDistance(), style: const TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
                        if (MaintenanceReminderScreen.globalCondition != 2) ...[
                          const SizedBox(width: 4),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 3.0),
                            child: Text("KM", style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 40, color: AppColors.border),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Severity", style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(severityText, style: TextStyle(color: activeColor, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConditionMonitor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Condition Monitor", style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(child: _buildSegment("Good", 0)),
              Expanded(child: _buildSegment("Moderate", 1)),
              Expanded(child: _buildSegment("Immediate", 2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSegment(String text, int index) {
    bool isSelected = MaintenanceReminderScreen.globalCondition == index;
    Color getSelectedColor() {
      if (index == 0) return AppColors.success;
      if (index == 1) return AppColors.warning;
      return AppColors.error;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          MaintenanceReminderScreen.globalCondition = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? getSelectedColor() : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text, 
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondary, 
              fontWeight: FontWeight.bold, 
              fontSize: 13
            )
          ),
        ),
      ),
    );
  }

  Widget _buildServiceChecklist() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Service Checklist", style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildChecklistItem("Engine oil check", true),
          _buildChecklistItem("Brake inspection", false),
          _buildChecklistItem("Battery health", true),
          _buildChecklistItem("Tire pressure", false, isLast: true),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String title, bool isOk, {bool isLast = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isOk ? Colors.transparent : AppColors.warning.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(
            isOk ? Icons.settings_outlined : Icons.warning_amber_rounded, 
            color: isOk ? AppColors.textSecondary : AppColors.warning, 
            size: 20
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14))),
          Icon(
            isOk ? Icons.check_circle : Icons.error, 
            color: isOk ? AppColors.success : AppColors.warning, 
            size: 20
          ),
        ],
      ),
    );
  }

  Widget _buildEstimatedCost() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Estimated Service Cost", style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("₹15,000", style: TextStyle(color: AppColors.primary, fontSize: 28, fontWeight: FontWeight.bold)),
                  Text("Total Estimate", style: TextStyle(color: AppColors.textSecondary.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("₹5,000", style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Parts Estimate", style: TextStyle(color: AppColors.textSecondary.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReminderChannels() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Reminder Channels", style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildSwitchItem("Push Notifications", pushNotifications, (val) => setState(() => pushNotifications = val)),
          _buildSwitchItem("SMS Reminders", smsReminders, (val) => setState(() => smsReminders = val)),
          _buildSwitchItem("Email Updates", emailUpdates, (val) => setState(() => emailUpdates = val), isLast: true),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String title, bool value, ValueChanged<bool> onChanged, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.primaryLight,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.border,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCenterInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Nexus Auto Care", style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1), 
                  borderRadius: BorderRadius.circular(8)
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: AppColors.primary, size: 14),
                    SizedBox(width: 4),
                    Text("4.9", style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text("4.8 km away • Premium Service", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapScreen(
                      locationName: "Nexus Auto Care",
                      address: "4.8 km away • Premium Service",
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.background,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.border),
                ),
              ),
              child: const Text("View on Map", style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.background,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.call, color: Colors.white),
              label: const Text("Call Now", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("Remind Me Later", style: TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
