import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/wedding_data.dart';

class FamilySection extends StatelessWidget {
  const FamilySection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 650;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 20,
      ),
      child: Column(
        children: [
          // Section Title
          Text(
            "WITH BLESSINGS OF FAMILIES",
            style: GoogleFonts.cinzel(
              fontSize: isMobile ? 12 : 14,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
              color: WeddingColors.goldDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Warm Regards",
            style: GoogleFonts.cormorantGaramond(
              fontSize: isMobile ? 22 : 26,
              fontStyle: FontStyle.italic,
              color: WeddingColors.emeraldPrimary,
            ),
          ),
          const SizedBox(height: 24),

          // Cards
          if (isMobile) ...[
            _buildFamilyCard(WeddingData.groomFamily, isGroom: true),
            const SizedBox(height: 16),
            _buildFamilyCard(WeddingData.brideFamily, isGroom: false),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildFamilyCard(WeddingData.groomFamily, isGroom: true),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFamilyCard(WeddingData.brideFamily, isGroom: false),
                ),
              ],
            ),
          ],

          const SizedBox(height: 20),

          // Warm Regards from Siblings Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: WeddingColors.creamWarm,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: WeddingColors.goldBorder.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "WITH WARM REGARDS",
                  style: GoogleFonts.cinzel(
                    fontSize: 11,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    color: WeddingColors.goldDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  WeddingData.siblingsWarmRegards,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: WeddingColors.emeraldPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "(Groom's & Bride's Siblings)",
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: WeddingColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyCard(FamilyInfo info, {required bool isGroom}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: WeddingColors.creamLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: WeddingColors.goldBorder.withOpacity(0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: WeddingColors.emeraldDark.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: WeddingColors.emeraldSoft,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: WeddingColors.emeraldMedium.withOpacity(0.2),
              ),
            ),
            child: Text(
              info.title.toUpperCase(),
              style: GoogleFonts.montserrat(
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                color: WeddingColors.emeraldPrimary,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Couple Member Name
          Text(
            info.coupleMember,
            style: GoogleFonts.greatVibes(
              fontSize: 32,
              color: WeddingColors.emeraldPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // Parents
          Text(
            "Parents",
            style: GoogleFonts.montserrat(
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              color: WeddingColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            info.parents,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: WeddingColors.textDark,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),

          // Sibling
          Text(
            "Sibling",
            style: GoogleFonts.montserrat(
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              color: WeddingColors.textMuted,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            info.siblings,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: WeddingColors.textDark,
            ),
          ),

          const SizedBox(height: 14),
          const Divider(color: WeddingColors.creamBorder, thickness: 1),
          const SizedBox(height: 10),

          // Address
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.home_outlined,
                size: 16,
                color: WeddingColors.goldDark,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  info.address,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: WeddingColors.textBody,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
