import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'onboarding_screen.dart';
import '../widgets/tree_growing_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _treeController;
  late AnimationController _particleController;
  late AnimationController _textController;
  int _quoteIndex = 0;

  final List<String> _quotes = [
    'Growing a cleaner planet…',
    'Sorting your waste…',
    'Planting seeds for a greener future…',
  ];

  @override
  void initState() {
    super.initState();
    
    _treeController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _textController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _treeController.forward();
    _textController.forward();

    // Rotate quotes every 2.5 seconds
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 2500));
      if (mounted) {
        setState(() {
          _quoteIndex = (_quoteIndex + 1) % _quotes.length;
        });
        _textController.forward(from: 0.0);
      }
      return mounted;
    });

    // Navigate after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _treeController.dispose();
    _particleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FF),
      body: Stack(
        children: [
          // Background with leaf illustrations
          Positioned.fill(
            child: Opacity(
              opacity: 0.02,
              child: CustomPaint(
                painter: LeafPatternPainter(),
              ),
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tree animation
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular progress ring
                      SizedBox.expand(
                        child: AnimatedBuilder(
                          animation: _treeController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: CircularProgressPainter(
                                progress: _treeController.value,
                              ),
                            );
                          },
                        ),
                      ),

                      // Premium tree animation
                      TreeGrowingAnimation(
                        duration: const Duration(seconds: 3),
                        size: 120,
                        onComplete: () {
                          // Animation complete
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // App title
                const Text(
                  'Trash & Cash',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),

                const SizedBox(height: 30),

                // Rotating quotes
                SizedBox(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _textController,
                        child: Text(
                          _quotes[_quoteIndex],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A4A4A),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Micro text
                const Text(
                  'Please wait while we prepare your experience.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw droplet-shaped progress ring
    final paint = Paint()
      ..color = const Color(0xFF8BC34A)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 5),
      -Math.pi / 2,
      Math.pi * 2 * progress,
      false,
      paint,
    );

    // Draw droplets along the progress
    final dropletCount = 12;
    for (int i = 0; i < dropletCount; i++) {
      final angle = -Math.pi / 2 + (Math.pi * 2 * progress * (i / dropletCount));
      if (i / dropletCount <= progress) {
        final dropletX = center.dx + (radius - 5) * Math.cos(angle);
        final dropletY = center.dy + (radius - 5) * Math.sin(angle);

        final dropletPaint = Paint()
          ..color = const Color(0xFF8BC34A)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(Offset(dropletX, dropletY), 3, dropletPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class LeafPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Draw simple leaf shapes in corners
    _drawLeaf(canvas, Offset(20, 30), paint);
    _drawLeaf(canvas, Offset(size.width - 40, size.height - 50), paint);
  }

  void _drawLeaf(Canvas canvas, Offset offset, Paint paint) {
    final path = Path()
      ..moveTo(offset.dx, offset.dy)
      ..quadraticBezierTo(offset.dx + 15, offset.dy - 10, offset.dx + 20, offset.dy)
      ..quadraticBezierTo(offset.dx + 15, offset.dy + 10, offset.dx, offset.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LeafPatternPainter oldDelegate) => false;
}