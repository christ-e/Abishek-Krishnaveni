import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/wedding_data.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final photoWidth = isMobile ? screenWidth * 0.84 : 400.0;
    final photoHeight = photoWidth * 1.25;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 36,
        vertical: isMobile ? 32 : 48,
      ),
      child: Column(
        children: [
          // 1. Auspicious Hindu Blessing Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: WeddingColors.goldLight.withOpacity(0.35),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: WeddingColors.goldBorder.withOpacity(0.6),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.spa_rounded,
                  size: 14,
                  color: WeddingColors.goldMedium,
                ),
                const SizedBox(width: 8),
                Text(
                  WeddingData.shlokaInvocation,
                  style: GoogleFonts.notoSansDevanagari(
                    fontSize: isMobile ? 13 : 15,
                    fontWeight: FontWeight.w600,
                    color: WeddingColors.goldDark,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.spa_rounded,
                  size: 14,
                  color: WeddingColors.goldMedium,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 2. Invitation wording
          Text(
            WeddingData.invitationSubtitle.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: isMobile ? 11 : 12,
              letterSpacing: 3,
              fontWeight: FontWeight.w500,
              color: WeddingColors.textMuted,
            ),
          ),

          const SizedBox(height: 14),

          // 3. Couple Names in Calligraphy
          Text(
            "${WeddingData.groomName}\n&\n${WeddingData.brideName}",
            textAlign: TextAlign.center,
            style: GoogleFonts.greatVibes(
              fontSize: isMobile ? 48 : 64,
              height: 1.15,
              fontWeight: FontWeight.w400,
              color: WeddingColors.emeraldPrimary,
              shadows: [
                Shadow(
                  color: WeddingColors.goldPrimary.withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Decorative Golden Line
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 1,
                color: WeddingColors.goldPrimary.withOpacity(0.5),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.favorite_rounded,
                  size: 14,
                  color: WeddingColors.goldPrimary,
                ),
              ),
              Container(
                width: 48,
                height: 1,
                color: WeddingColors.goldPrimary.withOpacity(0.5),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // 4. Main Couple Photo (Beach Photo - first photo requested by user)
          Container(
            width: photoWidth,
            height: photoHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(220),
              border: Border.all(
                color: WeddingColors.goldBorder,
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: WeddingColors.emeraldDark.withOpacity(0.12),
                  blurRadius: 28,
                  spreadRadius: 2,
                  offset: const Offset(0, 14),
                ),
                BoxShadow(
                  color: WeddingColors.goldPrimary.withOpacity(0.15),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(215),
                child: Image.asset(
                  WeddingData.mainCoupleImage,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),

          const SizedBox(height: 26),

          // 5. Date & Muhurtham Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            decoration: BoxDecoration(
              color: WeddingColors.emeraldPrimary,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: WeddingColors.emeraldPrimary.withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 15,
                  color: WeddingColors.goldLight,
                ),
                const SizedBox(width: 10),
                Text(
                  WeddingData.formattedDate.toUpperCase(),
                  style: GoogleFonts.cinzel(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: WeddingColors.goldLight,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "Muhurtham 10:30 AM – 11:00 AM",
            style: GoogleFonts.montserrat(
              fontSize: isMobile ? 12 : 13,
              fontWeight: FontWeight.w600,
              color: WeddingColors.textBody,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
