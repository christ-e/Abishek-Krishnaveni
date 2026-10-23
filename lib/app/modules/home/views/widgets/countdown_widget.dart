import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/wedding_data.dart';
import '../../controllers/home_controller.dart';

class CountdownWidget extends StatelessWidget {
  const CountdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 16,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 28,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: WeddingColors.creamLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: WeddingColors.goldBorder.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: WeddingColors.emeraldDark.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            WeddingData.countdownHeading.toUpperCase(),
            style: GoogleFonts.cinzel(
              fontSize: isMobile ? 12 : 14,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: WeddingColors.goldDark,
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimeUnit(
                  context,
                  value: controller.days.value.toString().padLeft(2, '0'),
                  label: "DAYS",
                  isMobile: isMobile,
                ),
                _buildSeparator(isMobile),
                _buildTimeUnit(
                  context,
                  value: controller.hours.value.toString().padLeft(2, '0'),
                  label: "HOURS",
                  isMobile: isMobile,
                ),
                _buildSeparator(isMobile),
                _buildTimeUnit(
                  context,
                  value: controller.minutes.value.toString().padLeft(2, '0'),
                  label: "MINS",
                  isMobile: isMobile,
                ),
                _buildSeparator(isMobile),
                _buildTimeUnit(
                  context,
                  value: controller.seconds.value.toString().padLeft(2, '0'),
                  label: "SECS",
                  isMobile: isMobile,
                  isHighlighted: true,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(
    BuildContext context, {
    required String value,
    required String label,
    required bool isMobile,
    bool isHighlighted = false,
  }) {
    final boxWidth = isMobile ? 64.0 : 80.0;
    final boxHeight = isMobile ? 70.0 : 84.0;

    return Column(
      children: [
        Container(
          width: boxWidth,
          height: boxHeight,
          decoration: BoxDecoration(
            color: isHighlighted
                ? WeddingColors.emeraldPrimary
                : WeddingColors.creamPrimary,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isHighlighted
                  ? WeddingColors.goldPrimary
                  : WeddingColors.goldBorder.withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isHighlighted
                    ? WeddingColors.goldPrimary.withOpacity(0.2)
                    : Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: GoogleFonts.cinzel(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: isHighlighted
                  ? WeddingColors.goldLight
                  : WeddingColors.emeraldPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: isMobile ? 9 : 11,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
            color: WeddingColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 8),
      child: Text(
        ":",
        style: TextStyle(
          fontSize: isMobile ? 22 : 28,
          fontWeight: FontWeight.bold,
          color: WeddingColors.goldBorder,
        ),
      ),
    );
  }
}
