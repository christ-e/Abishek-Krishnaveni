import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/wedding_data.dart';

class ShlokaSection extends StatelessWidget {
  const ShlokaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 16,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 36,
        vertical: 28,
      ),
      decoration: BoxDecoration(
        color: WeddingColors.creamWarm.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: WeddingColors.goldBorder.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 1,
                color: WeddingColors.goldPrimary.withOpacity(0.5),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.local_florist_rounded,
                  color: WeddingColors.goldMedium,
                  size: 16,
                ),
              ),
              Container(
                width: 30,
                height: 1,
                color: WeddingColors.goldPrimary.withOpacity(0.5),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            WeddingData.mangalyamShloka,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansDevanagari(
              fontSize: isMobile ? 15 : 18,
              height: 1.7,
              fontWeight: FontWeight.w600,
              color: WeddingColors.emeraldPrimary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            WeddingData.mangalyamTranslation,
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: isMobile ? 14 : 16,
              height: 1.5,
              fontStyle: FontStyle.italic,
              color: WeddingColors.textBody,
            ),
          ),
        ],
      ),
    );
  }
}
