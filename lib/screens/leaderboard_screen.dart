import 'package:flutter/material.dart';
import 'dart:async';
import '../theme/app_colors.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int _selectedTab = 0; // 0 = Giver, 1 = Collector
  late Timer _countdownTimer;
  int _daysLeft = 6;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          // Countdown logic (simulated)
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  final Map<String, List<Map<String, dynamic>>> leaderboardData = {
    'giver': [
      {'rank': 1, 'name': 'John Doe', 'points': 5200, 'emoji': '👑', 'waste': '45.2 kg'},
      {'rank': 2, 'name': 'Jane Smith', 'points': 4800, 'emoji': '🥈', 'waste': '42.1 kg'},
      {'rank': 3, 'name': 'Mike Johnson', 'points': 4500, 'emoji': '🥉', 'waste': '40.5 kg'},
      {'rank': 4, 'name': 'Sarah Williams', 'points': 4200, 'emoji': '4️⃣', 'waste': '38.3 kg'},
      {'rank': 5, 'name': 'You', 'points': 2450, 'emoji': '👤', 'waste': '22.1 kg'},
      {'rank': 6, 'name': 'Tom Brown', 'points': 2100, 'emoji': '6️⃣', 'waste': '19.8 kg'},
      {'rank': 7, 'name': 'Alice Green', 'points': 1850, 'emoji': '7️⃣', 'waste': '17.2 kg'},
    ],
    'collector': [
      {'rank': 1, 'name': 'Robert Cole', 'points': 6500, 'emoji': '👑', 'pickups': '156'},
      {'rank': 2, 'name': 'Emma Davis', 'points': 6100, 'emoji': '🥈', 'pickups': '149'},
      {'rank': 3, 'name': 'David Lee', 'points': 5800, 'emoji': '🥉', 'pickups': '143'},
      {'rank': 4, 'name': 'Lisa White', 'points': 5400, 'emoji': '4️⃣', 'pickups': '138'},
      {'rank': 5, 'name': 'You', 'points': 3200, 'emoji': '👤', 'pickups': '89'},
      {'rank': 6, 'name': 'James Black', 'points': 2900, 'emoji': '6️⃣', 'pickups': '81'},
      {'rank': 7, 'name': 'Mary Wilson', 'points': 2650, 'emoji': '7️⃣', 'pickups': '75'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            
            // Header
            const Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 20),
            
            // Current League Badge
            _buildLeagueBadge(),
            const SizedBox(height: 20),
            
            // Tab Buttons
            _buildTabButtons(),
            const SizedBox(height: 20),
            
            // Leaderboard List
            _buildLeaderboardList(),
            const SizedBox(height: 20),
            
            // Promotion Info
            _buildPromotionInfo(),
            const SizedBox(height: 20),
            
            // Countdown Timer
            _buildCountdownSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueBadge() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.accent),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Current League',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textLight,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '🏆',
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gold League',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      'Your Rank: #5',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButtons() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              label: 'Giver',
              icon: Icons.person_add,
              isSelected: _selectedTab == 0,
              onTap: () {
                setState(() {
                  _selectedTab = 0;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTabButton(
              label: 'Collector',
              icon: Icons.local_shipping,
              isSelected: _selectedTab == 1,
              onTap: () {
                setState(() {
                  _selectedTab = 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.textLight,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardList() {
    final data = _selectedTab == 0 ? leaderboardData['giver']! : leaderboardData['collector']!;
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        final isCurrentUser = item['name'] == 'You';
        final isTopThree = item['rank'] <= 3;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isCurrentUser
                ? AppColors.accent.withOpacity(0.1)
                : isTopThree
                    ? AppColors.primary.withOpacity(0.5)
                    : AppColors.secondary,
            border: Border.all(
              color: isCurrentUser
                  ? AppColors.accent
                  : isTopThree
                      ? AppColors.accent.withOpacity(0.3)
                      : AppColors.border.withOpacity(0.3),
              width: isCurrentUser ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isCurrentUser
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Rank badge + Emoji
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: isTopThree ? AppColors.accent : AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border.withOpacity(0.6)),
                    ),
                    child: Text(
                      '#${item['rank']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['emoji'],
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item['name'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isCurrentUser
                                ? AppColors.accent
                                : AppColors.text,
                          ),
                        ),
                        if (isTopThree) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Promotion',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedTab == 0
                          ? '${item['waste']} waste collected'
                          : '${item['pickups']} pickups completed',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Points
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${item['points']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isCurrentUser ? AppColors.accent : AppColors.text,
                    ),
                  ),
                  Text(
                    'points',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPromotionInfo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.arrow_upward, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Top 3 Get Promoted',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '🥇 Gold League  🥈 Silver League  🥉 Bronze League',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.text,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Top 3 performers from Bronze & Silver will be promoted to the next league.',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textLight,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const Text(
            'Next Season In',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCountdownCard('$_daysLeft', 'Days'),
              const SizedBox(width: 12),
              _buildCountdownCard('23', 'Hours'),
              const SizedBox(width: 12),
              _buildCountdownCard('45', 'Minutes'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Leaderboard refreshes weekly on Monday',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textLight,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownCard(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.accent.withOpacity(0.3)),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }
}
