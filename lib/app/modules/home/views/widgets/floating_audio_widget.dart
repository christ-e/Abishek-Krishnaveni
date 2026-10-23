import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/wedding_data.dart';
import '../../controllers/home_controller.dart';

class FloatingAudioWidget extends StatefulWidget {
  const FloatingAudioWidget({super.key});

  @override
  State<FloatingAudioWidget> createState() => _FloatingAudioWidgetState();
}

class _FloatingAudioWidgetState extends State<FloatingAudioWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final isPlaying = controller.isMusicPlaying.value;

      return Positioned(
        bottom: 24,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.toggleMusic(),
            borderRadius: BorderRadius.circular(30),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isPlaying
                    ? WeddingColors.emeraldPrimary.withOpacity(0.95)
                    : Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: WeddingColors.goldPrimary,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: WeddingColors.emeraldDark.withOpacity(0.25),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                  if (isPlaying)
                    BoxShadow(
                      color: WeddingColors.goldPrimary.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Equalizer or Play Icon
                  if (isPlaying)
                    AnimatedBuilder(
                      animation: _animController,
                      builder: (context, _) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(4, (index) {
                            final phase = index * (math.pi / 2);
                            final height = 6.0 +
                                10.0 *
                                    (0.5 +
                                        0.5 *
                                            math.sin(
                                                _animController.value *
                                                        math.pi *
                                                        2 +
                                                    phase));
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1.5),
                              width: 3,
                              height: height,
                              decoration: BoxDecoration(
                                color: WeddingColors.goldLight,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            );
                          }),
                        );
                      },
                    )
                  else
                    const Icon(
                      Icons.music_note_rounded,
                      size: 20,
                      color: WeddingColors.emeraldPrimary,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    isPlaying ? "MUSIC ON" : "PLAY MUSIC",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: isPlaying ? WeddingColors.goldLight : WeddingColors.emeraldPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
