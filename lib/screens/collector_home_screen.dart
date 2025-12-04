import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'pickup_detail_screen.dart';
import 'leaderboard_screen.dart';
import '../theme/app_colors.dart';

class CollectorHomeScreen extends StatefulWidget {
  const CollectorHomeScreen({super.key});

  @override
  State<CollectorHomeScreen> createState() => _CollectorHomeScreenState();
}

class _CollectorHomeScreenState extends State<CollectorHomeScreen> {
  int _selectedIndex = 0;
  // State-managed pickup lists so collectors can accept/move items between lists
  List<Map<String, dynamic>> _openPickups = [
    {
      'id': '001',
      'giver': 'John Doe',
      'items': 'Plastic Bottle',
      'address': '123 Main St',
      'status': 'open',
      'points': 50
    },
    {
      'id': '002',
      'giver': 'Jane Smith',
      'items': 'Aluminum Can',
      'address': '456 Oak Ave',
      'status': 'open',
      'points': 30
    },
    {
      'id': '003',
      'giver': 'Mike Johnson',
      'items': 'Glass Jar',
      'address': '789 Pine Rd',
      'status': 'open',
      'points': 40
    },
  ];

  List<Map<String, dynamic>> _yourPickups = [
    {
      'id': '101',
      'giver': 'Alice Brown',
      'items': 'Paper Waste',
      'address': '321 Elm St',
      'status': 'pending',
      'points': 35,
      'date': 'Dec 2, 2025'
    },
    {
      'id': '102',
      'giver': 'Bob Wilson',
      'items': 'Mixed Plastics',
      'address': '654 Maple Ave',
      'status': 'completed',
      'points': 60,
      'date': 'Dec 1, 2025'
    },
  ];

  // Track hovered pickup ids for hover effect
  final Set<String> _hoveredPickups = {};

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
          BottomNavigationBarItem(icon: Icon(Icons.local_activity), label: 'Pickups'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Leaderboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        _buildHomePage(),
        _buildPickupsPage(),
        const LeaderboardScreen(),
        _buildProfilePage(),
      ],
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Container
          _buildWelcomeContainer(),
          
          const SizedBox(height: 20),
          
          // Missions Container
          _buildMissionsContainer(),
          
          const SizedBox(height: 20),
          
          // Collected Waste Stats Container
          _buildCollectedWasteContainer(),
          
          const SizedBox(height: 20),
          
          // Recent Activity Container
          _buildRecentActivityContainer(),
        ],
      ),
    );
  }

  Widget _buildWelcomeContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Message
          Row(
            children: [
              const Icon(Icons.waving_hand, color: AppColors.accent, size: 28),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back,',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    'Sarah Wilson',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWelcomeStatItem('Waste Collected', '32.5 kg', Icons.delete_sweep),
              const SizedBox(width: 10),
              _buildWelcomeStatItem('Rank', '#8', Icons.emoji_events),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.accent.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.accent, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionsContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Missions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          
          // Monthly Mission
          _buildMissionCard(
            'Monthly Challenge',
            'Pickups Required',
            20,
            15,
            AppColors.accent,
          ),
          const SizedBox(height: 10),
          
          // Weekly Mission
          _buildMissionCard(
            'Weekly Challenge',
            'Pickups Required',
            8,
            5,
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildMissionCard(String title, String subtitle, int total, int current, Color color) {
    double progress = current / total;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$current/$total',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectedWasteContainer() {
    final wasteData = [
      {'type': 'Plastic Bottles', 'amount': '12.3 kg', 'icon': Icons.local_drink},
      {'type': 'Glass Jars', 'amount': '8.5 kg', 'icon': Icons.wine_bar},
      {'type': 'Aluminum Cans', 'amount': '7.2 kg', 'icon': Icons.recycling},
      {'type': 'Paper & Cardboard', 'amount': '4.5 kg', 'icon': Icons.description},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Waste Collected by Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          
          Column(
            children: wasteData.map((waste) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        waste['icon'] as IconData,
                        color: AppColors.accent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        waste['type'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.text,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      waste['amount'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildActivityItem('Picked up 2.3 kg of plastic', 'Dec 3, 2025', Icons.done_all),
          _buildActivityItem('Completed weekly mission', 'Dec 2, 2025', Icons.emoji_events),
          
          _buildActivityItem('Picked up 1.8 kg of glass', 'Nov 30, 2025', Icons.done_all),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String activity, String date, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.success, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
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

  Widget _buildPickupsPage() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Pickups',
            style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.accent,
            labelColor: AppColors.accent,
            unselectedLabelColor: AppColors.textLight,
            tabs: const [
              Tab(
                icon: Icon(Icons.shopping_bag),
                text: 'Open Pickups',
              ),
              Tab(
                icon: Icon(Icons.check_circle),
                text: 'Your Pickups',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOpenPickupsList(),
            _buildYourPickupsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildOpenPickupsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: _openPickups.map((pickup) {
          return _buildPickupCard(pickup);
        }).toList(),
      ),
    );
  }

  Widget _buildYourPickupsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: _yourPickups.map((pickup) {
          return _buildPickupCard(pickup);
        }).toList(),
      ),
    );
  }

  Widget _buildPickupCard(Map<String, dynamic> pickup) {
    final id = pickup['id'] as String;
    final isOpen = (pickup['status'] as String) == 'open';
    final hovered = _hoveredPickups.contains(id);

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredPickups.add(id)),
      onExit: (_) => setState(() => _hoveredPickups.remove(id)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (isOpen) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Open Pickup #$id'),
                content: Text('Accept this pickup from ${pickup['giver']}?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _acceptPickup(id);
                    },
                    child: const Text('Accept'),
                  ),
                ],
              ),
            );
          } else {
            // your pickups: show options
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Pickup #$id'),
                content: Text('Status: ${pickup['status']}\nFrom: ${pickup['giver']}'),
                actions: [
                  if ((pickup['status'] as String) == 'pending')
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _markPickupCompleted(id);
                      },
                      child: const Text('Mark Completed'),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: hovered ? AppColors.primary.withOpacity(0.6) : AppColors.secondary,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
            boxShadow: hovered
                ? [BoxShadow(color: AppColors.accent.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2))]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Request #$id',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (pickup['status'] as String) == 'open'
                          ? AppColors.accent
                          : (pickup['status'] as String) == 'pending'
                              ? AppColors.warning
                              : AppColors.success,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      (pickup['status'] as String).toUpperCase(),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('From: ${pickup['giver']}', style: const TextStyle(fontSize: 14, color: AppColors.textLight)),
              const SizedBox(height: 4),
              Text(pickup['items'] as String, style: const TextStyle(fontSize: 14, color: AppColors.accent, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: AppColors.textLight),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      pickup['address'] as String,
                      style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Accept an open pickup: move it to your pickups with 'pending' status
  void _acceptPickup(String id) {
    setState(() {
      final index = _openPickups.indexWhere((p) => p['id'] == id);
      if (index != -1) {
        final pickup = Map<String, dynamic>.from(_openPickups.removeAt(index));
        pickup['status'] = 'pending';
        _yourPickups.insert(0, pickup);
      }
    });
  }

  // Mark a pickup in your list as completed
  void _markPickupCompleted(String id) {
    setState(() {
      final index = _yourPickups.indexWhere((p) => p['id'] == id);
      if (index != -1) {
        _yourPickups[index]['status'] = 'completed';
      }
    });
  }

  // Optional: move a pickup back to open (not currently exposed in UI)
  void _unassignPickup(String id) {
    setState(() {
      final index = _yourPickups.indexWhere((p) => p['id'] == id);
      if (index != -1) {
        final pickup = Map<String, dynamic>.from(_yourPickups.removeAt(index));
        pickup['status'] = 'open';
        _openPickups.insert(0, pickup);
      }
    });
  }

  Widget _buildProfilePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          
          // Profile Header
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Sarah Wilson',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const Text(
                  'sarah.wilson@email.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // User Information Section
          const Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildUserInfoItem('Full Name', 'Sarah Wilson', Icons.person),
          _buildUserInfoItem('Mobile Number', '+1 (555) 987-6543', Icons.phone),
          _buildUserInfoItem('Email Address', 'sarah.wilson@email.com', Icons.email),
          _buildUserInfoItem('Address', '456 Eco Avenue, Green City, GC 54321', Icons.location_on),
          
          const SizedBox(height: 30),
          
          // Stats Section
          const Text(
            'Your Statistics',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildProfileStatItem('Total Pickups Completed', '45'),
          _buildProfileStatItem('Total Waste Collected', '32.5 kg'),
          _buildProfileStatItem('Leaderboard Rank', '#8'),
          _buildProfileStatItem('Current League', 'Silver League'),
          _buildProfileStatItem('Member Since', 'Mar 10, 2025'),
          
          const SizedBox(height: 30),
          
          // Grievance Section
          const Text(
            'Report Issues',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildSettingItem('Pickup Issue', Icons.local_shipping, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pickup Issue Report Form Opened')),
            );
          }),
          _buildSettingItem('Eco Points Issue', Icons.trending_up, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Eco Points Issue Report Form Opened')),
            );
          }),
          _buildSettingItem('Application Issue', Icons.bug_report, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Application Issue Report Form Opened')),
            );
          }),
          
          const SizedBox(height: 30),
          
          // Settings Section
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildSettingItem('Notifications', Icons.notifications, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notification Settings Opened')),
            );
          }),
          _buildSettingItem('Privacy & Security', Icons.lock, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Privacy & Security Settings Opened')),
            );
          }),
          _buildSettingItem('Help & Support', Icons.help, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Help & Support Page Opened')),
            );
          }),
          _buildSettingItem('About', Icons.info, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('About Page Opened')),
            );
          }),
          
          const SizedBox(height: 20),
          
          // Logout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                          },
                          child: const Text('Logout', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.1),
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Logout', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildUserInfoItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
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
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.text,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.accent),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}