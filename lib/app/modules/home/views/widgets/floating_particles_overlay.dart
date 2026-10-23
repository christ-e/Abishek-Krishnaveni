import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/wedding_data.dart';
import '../../controllers/home_controller.dart';

class FloatingParticlesOverlay extends StatefulWidget {
  final Widget child;
  const FloatingParticlesOverlay({super.key, required this.child});

  @override
  State<FloatingParticlesOverlay> createState() => _FloatingParticlesOverlayState();
}

class _FloatingParticlesOverlayState extends State<FloatingParticlesOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final List<_Petal> _petals = [];
  final math.Random _random = math.Random(108);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Create 30 ambient golden spark particles
    for (int i = 0; i < 30; i++) {
      _particles.add(
        _Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: _random.nextDouble() * 3 + 1.2,
          speed: _random.nextDouble() * 0.08 + 0.03,
          phase: _random.nextDouble() * math.pi * 2,
          opacity: _random.nextDouble() * 0.5 + 0.2,
        ),
      );
    }

    // Create 16 floating soft lotus petals
    for (int i = 0; i < 16; i++) {
      _petals.add(
        _Petal(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: _random.nextDouble() * 10 + 8,
          speedY: _random.nextDouble() * 0.05 + 0.02,
          driftSpeed: _random.nextDouble() * 2 + 1,
          rotation: _random.nextDouble() * math.pi * 2,
          rotationSpeed: (_random.nextDouble() - 0.5) * 1.5,
          color: _random.nextBool()
              ? const Color(0xFFF7B5C5) // Soft pink lotus petal
              : WeddingColors.goldPrimary.withOpacity(0.4),
        ),
      );
    }

    // Listen to celebration triggers from controller
    final controller = Get.find<HomeController>();
    ever<int>(controller.celebrationCount, (count) {
      if (count > 0) {
        _spawnCelebrationBurst();
      }
    });
  }

  void _spawnCelebrationBurst() {
    // Add extra celebration petals that drift downward fast
    for (int i = 0; i < 24; i++) {
      _petals.add(
        _Petal(
          x: _random.nextDouble(),
          y: -0.1 - (_random.nextDouble() * 0.2),
          size: _random.nextDouble() * 14 + 10,
          speedY: _random.nextDouble() * 0.12 + 0.06,
          driftSpeed: _random.nextDouble() * 3 + 2,
          rotation: _random.nextDouble() * math.pi * 2,
          rotationSpeed: (_random.nextDouble() - 0.5) * 3,
          color: i % 2 == 0
              ? const Color(0xFFFF94B4) // Bright lotus petal
              : WeddingColors.goldPrimary.withOpacity(0.8),
        ),
      );
    }
    // Clean up excessive petals
    if (_petals.length > 60) {
      _petals.removeRange(0, 20);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        // Particle overlay (pointer events pass through so user can click anything beneath)
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ParticlePainter(
                    particles: _particles,
                    petals: _petals,
                    progress: _controller.value,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final double phase;
  final double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.phase,
    required this.opacity,
  });
}

class _Petal {
  double x;
  double y;
  final double size;
  final double speedY;
  final double driftSpeed;
  double rotation;
  final double rotationSpeed;
  final Color color;

  _Petal({
    required this.x,
    required this.y,
    required this.size,
    required this.speedY,
    required this.driftSpeed,
    required this.rotation,
    required this.rotationSpeed,
    required this.color,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final List<_Petal> petals;
  final double progress;

  _ParticlePainter({
    required this.particles,
    required this.petals,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final goldPaint = Paint()..style = PaintingStyle.fill;

    // Draw Golden Ambient Sparkles
    for (var p in particles) {
      final y = (p.y + progress * p.speed * 2) % 1.0;
      final x = (p.x + math.sin(progress * math.pi * 2 + p.phase) * 0.02) % 1.0;
      final alpha = (math.sin(progress * math.pi * 4 + p.phase) * 0.3 + 0.7) * p.opacity;

      goldPaint.color = WeddingColors.goldPrimary.withOpacity(alpha.clamp(0.0, 1.0));
      canvas.drawCircle(Offset(x * size.width, y * size.height), p.size, goldPaint);
    }

    // Draw Lotus Petals
    final petalPaint = Paint()..style = PaintingStyle.fill;
    for (var petal in petals) {
      final y = (petal.y + progress * petal.speedY * 3) % 1.1;
      final x = (petal.x + math.sin(progress * math.pi * petal.driftSpeed) * 0.04) % 1.0;
      final rot = petal.rotation + progress * petal.rotationSpeed * math.pi;

      canvas.save();
      canvas.translate(x * size.width, y * size.height);
      canvas.rotate(rot);

      petalPaint.color = petal.color.withOpacity(0.55);

      // Draw oval-curved petal path
      final path = Path()
        ..moveTo(0, -petal.size)
        ..quadraticBezierTo(petal.size * 0.5, 0, 0, petal.size)
        ..quadraticBezierTo(-petal.size * 0.5, 0, 0, -petal.size);

      canvas.drawPath(path, petalPaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
