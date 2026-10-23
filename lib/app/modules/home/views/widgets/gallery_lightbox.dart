import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/wedding_data.dart';
import '../../controllers/home_controller.dart';

class GalleryLightbox extends StatelessWidget {
  const GalleryLightbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final index = controller.activeGalleryIndex.value;
      if (index < 0 || index >= WeddingData.galleryItems.length) {
        return const SizedBox.shrink();
      }

      final item = WeddingData.galleryItems[index];

      return Container(
        color: Colors.black.withOpacity(0.92),
        child: SafeArea(
          child: Stack(
            children: [
              // Zoomable Image
              Center(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 3.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(item.imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),

              // Top Bar with Close Button & Counter
              Positioned(
                top: 16,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${index + 1} / ${WeddingData.galleryItems.length}",
                      style: GoogleFonts.montserrat(color: WeddingColors.goldLight, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      onPressed: controller.closeGalleryLightbox,
                      icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                      tooltip: "Close",
                    ),
                  ],
                ),
              ),

              // Navigation: Previous
              if (index > 0)
                Positioned(
                  left: 12,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      onPressed: () => controller.openGalleryLightbox(index - 1),
                      icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 32),
                    ),
                  ),
                ),

              // Navigation: Next
              if (index < WeddingData.galleryItems.length - 1)
                Positioned(
                  right: 12,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      onPressed: () => controller.openGalleryLightbox(index + 1),
                      icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 32),
                    ),
                  ),
                ),

              // Bottom Title & Caption
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: Column(
                  children: [
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(color: WeddingColors.goldLight, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.caption,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
