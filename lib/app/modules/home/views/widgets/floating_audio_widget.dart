import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/wedding_data.dart';
import '../../controllers/home_controller.dart';

class FloatingAudioWidget extends StatelessWidget {
  const FloatingAudioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final isPlaying = controller.isMusicPlaying.value;

      return GestureDetector(
        onTap: () => controller.toggleMusic(),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPlaying
                ? WeddingColors.emeraldPrimary
                : Colors.white,
            border: Border.all(
              color: WeddingColors.goldPrimary,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: WeddingColors.emeraldDark.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              if (isPlaying)
                BoxShadow(
                  color: WeddingColors.goldPrimary.withValues(alpha: 0.4),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: 22,
            color: isPlaying ? WeddingColors.goldLight : WeddingColors.emeraldPrimary,
          ),
        ),
      );
    });
  }
}
