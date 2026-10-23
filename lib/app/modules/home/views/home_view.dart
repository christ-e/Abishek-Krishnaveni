import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/wedding_data.dart';
import '../controllers/home_controller.dart';
import 'widgets/blessings_section.dart';
import 'widgets/countdown_widget.dart';
import 'widgets/envelope_cover_view.dart';
import 'widgets/events_section.dart';
import 'widgets/family_section.dart';
import 'widgets/floating_audio_widget.dart';
import 'widgets/floating_particles_overlay.dart';
import 'widgets/gallery_lightbox.dart';
import 'widgets/gallery_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/shloka_section.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeddingColors.emeraldDark,
      body: Obx(() {
        final isOpened = controller.isEnvelopeOpened.value;

        return Stack(
          children: [
            // 1. Main Invitation View (always rendered and ready beneath)
            Positioned.fill(
              child: FloatingParticlesOverlay(
                child: _buildInvitationContent(context),
              ),
            ),

            // 2. Interactive Opening Envelope with 3D Wax Seal Flap
            if (!isOpened)
              const Positioned.fill(
                child: EnvelopeCoverView(),
              ),

            // 3. Floating Music Player (visible when invitation is open)
            if (isOpened)
              const FloatingAudioWidget(),

            // 4. Fullscreen Image Lightbox Modal
            const GalleryLightbox(),
          ],
        );
      }),
    );
  }

  Widget _buildInvitationContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Center(
      child: Container(
        width: isDesktop ? 680 : double.infinity,
        decoration: BoxDecoration(
          color: WeddingColors.creamPrimary,
          borderRadius: isDesktop ? BorderRadius.circular(24) : BorderRadius.zero,
          border: isDesktop
              ? Border.all(
                  color: WeddingColors.goldBorder.withOpacity(0.6),
                  width: 2,
                )
              : null,
          boxShadow: isDesktop
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 40,
                    spreadRadius: 8,
                    offset: const Offset(0, 16),
                  ),
                  BoxShadow(
                    color: WeddingColors.goldPrimary.withOpacity(0.12),
                    blurRadius: 50,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: isDesktop ? BorderRadius.circular(22) : BorderRadius.zero,
          child: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                HeroSection(),
                CountdownWidget(),
                ShlokaSection(),
                EventsSection(),
                FamilySection(),
                GallerySection(),
                BlessingsSection(),
                SizedBox(height: 60), // clearance for floating music pill
              ],
            ),
          ),
        ),
      ),
    );
  }
}
