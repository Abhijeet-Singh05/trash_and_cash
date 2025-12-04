import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: AppColors.secondary,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textLight,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildAnalyticsPage();
      case 2:
        return _buildAlertsPage();
      case 3:
        return _buildSettingsPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text(
            'Admin Dashboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Welcome back! Here\'s what\'s happening today.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 24),

          // Quick Stats
          _buildQuickStatsBar(),
          const SizedBox(height: 24),

          // Users & Partners
          _buildSectionGroup(
            title: 'Users & Partners',
            sections: [
              _buildSectionTile(
                title: 'Users',
                subtitle: 'View and manage users',
                icon: Icons.people,
                onTap: () => _showSection('Users'),
              ),
              _buildSectionTile(
                title: 'Companies',
                subtitle: 'Manage company partners',
                icon: Icons.business,
                onTap: () => _showSection('Companies'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Pickups & Operations
          _buildSectionGroup(
            title: 'Pickups & Operations',
            sections: [
              _buildSectionTile(
                title: 'Pickups',
                subtitle: 'View pickup requests',
                icon: Icons.local_activity,
                onTap: () => _showSection('Pickups'),
              ),
              _buildSectionTile(
                title: 'Reports',
                subtitle: 'Operational reports',
                icon: Icons.assessment,
                onTap: () => _showSection('Reports'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Rewards & Redemptions
          _buildSectionGroup(
            title: 'Rewards & Redemptions',
            sections: [
              _buildSectionTile(
                title: 'Reward History',
                subtitle: 'View redemptions',
                icon: Icons.card_giftcard,
                onTap: () => _showSection('Reward History'),
              ),
              _buildSectionTile(
                title: 'Approve Claims',
                subtitle: 'Review reward claims',
                icon: Icons.check_circle,
                onTap: () => _showSection('Approve Claims'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Monitoring & Insights
          _buildSectionGroup(
            title: 'Monitoring & Insights',
            sections: [
              _buildSectionTile(
                title: 'Leaderboard',
                subtitle: 'Monitor rankings',
                icon: Icons.emoji_events,
                onTap: () => _showSection('Leaderboard'),
              ),
              _buildSectionTile(
                title: 'Analytics',
                subtitle: 'View dashboard',
                icon: Icons.trending_up,
                onTap: () => _showSection('Analytics'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Content & Communication
          _buildSectionGroup(
            title: 'Content & Communication',
            sections: [
              _buildSectionTile(
                title: 'Announcements',
                subtitle: 'Send messages',
                icon: Icons.campaign,
                onTap: () => _showSection('Announcements'),
              ),
              _buildSectionTile(
                title: 'Content (CMS)',
                subtitle: 'Update app content',
                icon: Icons.edit,
                onTap: () => _showSection('Content'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Support & Compliance
          _buildSectionGroup(
            title: 'Support & Compliance',
            sections: [
              _buildSectionTile(
                title: 'Complaints',
                subtitle: 'Handle support tickets',
                icon: Icons.error_outline,
                onTap: () => _showSection('Complaints'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsBar() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickStatCard('Open Pickups', '24', AppColors.accent),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickStatCard('Pending Claims', '8', AppColors.warning),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickStatCard('New Complaints', '3', AppColors.success),
        ),
      ],
    );
  }

  Widget _buildQuickStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textLight,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionGroup({
    required String title,
    required List<Widget> sections,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        ...sections,
      ],
    );
  }

  Widget _buildSectionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.accent, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Analytics Dashboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 20),
          _buildAnalyticsCard('Total Users', '2,845', '+12%', AppColors.accent),
          const SizedBox(height: 12),
          _buildAnalyticsCard('Total Pickups', '15,234', '+23%', AppColors.success),
          const SizedBox(height: 12),
          _buildAnalyticsCard('Active Collectors', '456', '+8%', AppColors.warning),
          const SizedBox(height: 12),
          _buildAnalyticsCard('Rewards Issued', '₹5,42,100', '+15%', AppColors.accent),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, String change, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              change,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alerts & Notifications',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 20),
          _buildAlertItem(
            title: 'High pickup request volume',
            description: '234 pending requests',
            type: 'warning',
          ),
          const SizedBox(height: 12),
          _buildAlertItem(
            title: 'New complaint filed',
            description: 'User reported issue with collector',
            type: 'error',
          ),
          const SizedBox(height: 12),
          _buildAlertItem(
            title: 'Reward claim pending approval',
            description: '5 claims awaiting review',
            type: 'info',
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem({
    required String title,
    required String description,
    required String type,
  }) {
    final color = type == 'warning'
        ? AppColors.warning
        : type == 'error'
            ? Colors.red
            : AppColors.accent;
    final icon = type == 'warning'
        ? Icons.warning_amber
        : type == 'error'
            ? Icons.error
            : Icons.info;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Admin Settings',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 20),
          _buildSettingItem(
            title: 'System Configuration',
            icon: Icons.settings,
            onTap: () => _showSection('System Settings'),
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            title: 'Admin Roles & Permissions',
            icon: Icons.security,
            onTap: () => _showSection('Permissions'),
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            title: 'Backup & Restore',
            icon: Icons.cloud_download,
            onTap: () => _showSection('Backup'),
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            title: 'Audit Logs',
            icon: Icons.history,
            onTap: () => _showSection('Logs'),
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            title: 'Help & Support',
            icon: Icons.help,
            onTap: () => _showSection('Help'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  void _showSection(String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening: $section')),
    );
  }
}