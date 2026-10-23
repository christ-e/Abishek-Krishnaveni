import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/wedding_data.dart';
import '../../controllers/home_controller.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

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
            "MOMENTS OF LOVE",
            style: GoogleFonts.cinzel(
              fontSize: isMobile ? 12 : 14,
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
              color: WeddingColors.goldDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Pre-Wedding Gallery",
            style: GoogleFonts.cormorantGaramond(
              fontSize: isMobile ? 22 : 26,
              fontStyle: FontStyle.italic,
              color: WeddingColors.emeraldPrimary,
            ),
          ),
          const SizedBox(height: 20),

          // 2-Column Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: WeddingData.galleryItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) {
              final item = WeddingData.galleryItems[index];
              return _buildGalleryCard(
                item: item,
                index: index,
                onTap: () => controller.openGalleryLightbox(index),
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            "Tap any photo to view full size",
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: WeddingColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryCard({
    required GalleryItem item,
    required int index,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: WeddingColors.goldBorder.withOpacity(0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: WeddingColors.emeraldDark.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
              ),
              // Bottom gradient & title overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        WeddingColors.emeraldDark.withOpacity(0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.zoom_in_rounded,
                        color: WeddingColors.goldLight,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item.title,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: WeddingColors.goldLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
