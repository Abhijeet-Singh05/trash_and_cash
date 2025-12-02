import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leaderboardData = [
      {'rank': 1, 'name': 'John Doe', 'points': 5200, 'emoji': '👑'},
      {'rank': 2, 'name': 'Jane Smith', 'points': 4800, 'emoji': '🥈'},
      {'rank': 3, 'name': 'Mike Johnson', 'points': 4500, 'emoji': '🥉'},
      {'rank': 4, 'name': 'Sarah Williams', 'points': 4200, 'emoji': '4️⃣'},
      {'rank': 5, 'name': 'You', 'points': 2450, 'emoji': '👤'},
      {'rank': 6, 'name': 'Tom Brown', 'points': 2100, 'emoji': '6️⃣'},
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 24),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: leaderboardData.length,
              itemBuilder: (context, index) {
                final item = leaderboardData[index];
                final isCurrentUser = item['name'] == 'You';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isCurrentUser
                        ? AppColors.accent.withOpacity(0.1)
                        : AppColors.secondary,
                    border: Border.all(
                      color: isCurrentUser ? AppColors.accent : AppColors.border,
                      width: isCurrentUser ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${item['emoji']}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item['name']}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isCurrentUser
                                    ? AppColors.accent
                                    : AppColors.text,
                              ),
                            ),
                            Text(
                              '#${item['rank']}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${item['points']} pts',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
