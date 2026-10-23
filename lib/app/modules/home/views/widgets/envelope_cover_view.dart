import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/wedding_data.dart';
import '../../controllers/home_controller.dart';

class EnvelopeCoverView extends StatefulWidget {
  const EnvelopeCoverView({super.key});

  @override
  State<EnvelopeCoverView> createState() => _EnvelopeCoverViewState();
}

class _EnvelopeCoverViewState extends State<EnvelopeCoverView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _flapAnimation;
  late Animation<double> _cardSlideAnimation;
  late Animation<double> _sealScaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Flap opens from 0 to 180 degrees (0 to pi)
    _flapAnimation = Tween<double>(begin: 0.0, end: math.pi).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.1, 0.6, curve: Curves.easeInOutBack),
      ),
    );

    // Card slides upwards out of envelope
    _cardSlideAnimation = Tween<double>(begin: 0.0, end: -120.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    // Wax seal expands & fades
    _sealScaleAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _triggerOpen() {
    final controller = Get.find<HomeController>();
    if (_animController.isAnimating || controller.isEnvelopeOpened.value) return;
    _animController.forward().then((_) {
      controller.openEnvelope();
    });
    controller.playMusic();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final envelopeWidth = math.min(size.width * 0.88, 380.0);
    final envelopeHeight = envelopeWidth * 0.64;

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value.clamp(0.0, 1.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xFF1B4D3E),
                  Color(0xFF0F382A),
                  Color(0xFF071B14),
                ],
                center: Alignment.center,
                radius: 1.2,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 1. Top Header: Auspicious Invocation & Couple Names
                    Column(
                      children: [
                        Text(
                          WeddingData.shlokaInvocation,
                          style: GoogleFonts.notoSansDevanagari(
                            color: WeddingColors.goldBorder,
                            fontSize: isMobile ? 12 : 14,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "THE WEDDING INVITATION",
                          style: GoogleFonts.cinzel(
                            color: WeddingColors.goldLight,
                            fontSize: isMobile ? 11 : 13,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${WeddingData.groomName} & ${WeddingData.brideName}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.greatVibes(
                            color: WeddingColors.goldPrimary,
                            fontSize: isMobile ? 36 : 46,
                            shadows: [
                              Shadow(
                                color: WeddingColors.goldDark.withOpacity(0.6),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          WeddingData.formattedDate.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            color: WeddingColors.goldLight.withOpacity(0.85),
                            fontSize: isMobile ? 10 : 11,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    // 2. Center: The 3D Envelope with AK Wax Seal
                    GestureDetector(
                      onTap: _triggerOpen,
                      child: SizedBox(
                        width: envelopeWidth,
                        height: envelopeHeight + 100,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // Card sliding upwards
                            Transform.translate(
                              offset: Offset(0, _cardSlideAnimation.value),
                              child: Container(
                                width: envelopeWidth * 0.88,
                                height: envelopeHeight * 0.9,
                                decoration: BoxDecoration(
                                  color: WeddingColors.creamLight,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: WeddingColors.goldPrimary,
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 16,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "A & K",
                                      style: GoogleFonts.cinzel(
                                        color: WeddingColors.goldDark,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 4,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      width: 40,
                                      height: 1.5,
                                      color: WeddingColors.goldPrimary,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "24 DECEMBER 2026",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 9,
                                        letterSpacing: 2,
                                        color: WeddingColors.emeraldPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Envelope Body / Pocket
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: envelopeWidth,
                                height: envelopeHeight,
                                decoration: BoxDecoration(
                                  color: WeddingColors.emeraldMedium,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: WeddingColors.goldPrimary.withOpacity(0.6),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                    BoxShadow(
                                      color: WeddingColors.goldPrimary.withOpacity(0.12),
                                      blurRadius: 24,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: CustomPaint(
                                  size: Size(envelopeWidth, envelopeHeight),
                                  painter: _EnvelopePocketPainter(),
                                ),
                              ),
                            ),

                            // Envelope 3D Folding Top Flap
                            Positioned(
                              top: 100 - (envelopeHeight / 2),
                              child: Transform(
                                alignment: Alignment.bottomCenter,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.002)
                                  ..rotateX(-_flapAnimation.value),
                                child: CustomPaint(
                                  size: Size(envelopeWidth, envelopeHeight / 2),
                                  painter: _EnvelopeFlapPainter(),
                                ),
                              ),
                            ),

                            // Wax Seal with AK Monogram
                            if (_flapAnimation.value < math.pi / 2)
                              Positioned(
                                top: 100 - 36,
                                child: Transform.scale(
                                  scale: _sealScaleAnimation.value,
                                  child: Container(
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: WeddingColors.goldDark.withOpacity(0.5),
                                          blurRadius: 16,
                                          spreadRadius: 2,
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.4),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        WeddingData.waxSealImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // 3. Bottom CTA: "TAP TO OPEN INVITATION"
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _triggerOpen,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              gradient: WeddingColors.goldGradient,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: WeddingColors.goldPrimary.withOpacity(0.4),
                                  blurRadius: 18,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: WeddingColors.goldLight,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.mail_outline_rounded,
                                  color: WeddingColors.emeraldDark,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "TAP TO OPEN INVITATION",
                                  style: GoogleFonts.cinzel(
                                    color: WeddingColors.emeraldDark,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.volume_up_outlined,
                              size: 14,
                              color: WeddingColors.goldLight.withOpacity(0.7),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Music plays upon opening",
                              style: GoogleFonts.montserrat(
                                color: WeddingColors.goldLight.withOpacity(0.7),
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EnvelopePocketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final paintBottom = Paint()
      ..color = const Color(0xFF133F31)
      ..style = PaintingStyle.fill;

    final paintSide = Paint()
      ..color = const Color(0xFF164838)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = WeddingColors.goldPrimary.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Left triangle
    final pathLeft = Path()
      ..moveTo(0, 0)
      ..lineTo(w * 0.45, h * 0.55)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(pathLeft, paintSide);
    canvas.drawPath(pathLeft, borderPaint);

    // Right triangle
    final pathRight = Path()
      ..moveTo(w, 0)
      ..lineTo(w * 0.55, h * 0.55)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(pathRight, paintSide);
    canvas.drawPath(pathRight, borderPaint);

    // Bottom triangle
    final pathBottom = Path()
      ..moveTo(0, h)
      ..lineTo(w * 0.5, h * 0.45)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(pathBottom, paintBottom);
    canvas.drawPath(pathBottom, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EnvelopeFlapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final paint = Paint()
      ..color = const Color(0xFF1B523F)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = WeddingColors.goldPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(0, h)
      ..lineTo(w * 0.5, 0)
      ..lineTo(w, h)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
