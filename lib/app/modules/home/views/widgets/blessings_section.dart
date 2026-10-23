import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/wedding_data.dart';
import '../../../../data/wedding_utils.dart';
import '../../controllers/home_controller.dart';

class BlessingsSection extends StatelessWidget {
  const BlessingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 24,
      ),
      child: Column(
        children: [
          // Section Title
          Text(
            "BLESS THE COUPLE",
            style: GoogleFonts.cinzel(
              fontSize: isMobile ? 12 : 14,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
              color: WeddingColors.goldDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Share Your Prayers & Love",
            style: GoogleFonts.cormorantGaramond(
              fontSize: isMobile ? 22 : 26,
              fontStyle: FontStyle.italic,
              color: WeddingColors.emeraldPrimary,
            ),
          ),
          const SizedBox(height: 20),

          // Interactive Pushpavrishti (Shower Petals) Button
          GestureDetector(
            onTap: () => controller.triggerShowerBlessings(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              decoration: BoxDecoration(
                gradient: WeddingColors.goldGradient,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: WeddingColors.goldPrimary.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.8),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("🌸", style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Text(
                    "SHOWER BLESSINGS (पुष्पवृष्टि)",
                    style: GoogleFonts.cinzel(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: WeddingColors.emeraldDark,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Obx(() {
                    if (controller.celebrationCount.value == 0) {
                      return const SizedBox.shrink();
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: WeddingColors.emeraldPrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${controller.celebrationCount.value}",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: WeddingColors.goldLight,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // WhatsApp Wishes Button
          OutlinedButton.icon(
            onPressed: () {
              WeddingUtils.openWhatsApp(
                WeddingData.groomFamily.phone,
                WeddingData.blessingsWhatsAppMessage,
              );
            },
            icon: const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 18,
              color: Color(0xFF25D366),
            ),
            label: Text(
              "Send Wishes via WhatsApp",
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: WeddingColors.emeraldPrimary,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: WeddingColors.goldBorder.withOpacity(0.7),
                width: 1.2,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Replay Envelope button
          TextButton.icon(
            onPressed: () => controller.replayEnvelope(),
            icon: const Icon(
              Icons.mail_outline_rounded,
              size: 16,
              color: WeddingColors.goldDark,
            ),
            label: Text(
              "View Envelope Again",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: WeddingColors.goldDark,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ),

          const SizedBox(height: 36),

          // Elegant Minimal Footer
          Container(
            padding: const EdgeInsets.only(top: 24, bottom: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 1,
                      color: WeddingColors.goldBorder.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "|| शुभ विवाह ||",
                        style: GoogleFonts.notoSansDevanagari(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: WeddingColors.goldMedium,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 1,
                      color: WeddingColors.goldBorder.withOpacity(0.5),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "With Best Compliments from Family & Friends",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    letterSpacing: 2,
                    color: WeddingColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Abishek & KrishnaVeni • 24.12.2026",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: WeddingColors.emeraldPrimary,
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
