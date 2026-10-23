import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/wedding_data.dart';
import '../../../../data/wedding_utils.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
            "CELEBRATION SCHEDULE",
            style: GoogleFonts.cinzel(
              fontSize: isMobile ? 13 : 15,
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
              color: WeddingColors.goldDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Events & Auspicious Timings",
            style: GoogleFonts.cormorantGaramond(
              fontSize: isMobile ? 22 : 26,
              fontStyle: FontStyle.italic,
              color: WeddingColors.emeraldPrimary,
            ),
          ),
          const SizedBox(height: 24),

          // Event 1: Thalikettu
          _buildEventCard(
            context,
            event: WeddingData.events[0],
            isMobile: isMobile,
            isTemple: true,
          ),

          const SizedBox(height: 24),

          // Event 2: Reception
          _buildEventCard(
            context,
            event: WeddingData.events[1],
            isMobile: isMobile,
            isTemple: false,
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required EventItem event,
    required bool isMobile,
    required bool isTemple,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: WeddingColors.creamLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: WeddingColors.goldBorder.withOpacity(0.55),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: WeddingColors.emeraldDark.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge & Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: WeddingColors.emeraldPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: WeddingColors.goldPrimary,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  event.icon,
                  color: WeddingColors.goldLight,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: GoogleFonts.cinzel(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: WeddingColors.emeraldPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      event.subtitle,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 14 : 16,
                        fontStyle: FontStyle.italic,
                        color: WeddingColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),
          const Divider(color: WeddingColors.creamBorder, thickness: 1),
          const SizedBox(height: 14),

          // Date & Time
          _buildInfoRow(
            icon: Icons.calendar_month_outlined,
            label: "Date",
            value: event.dateDisplay,
            isMobile: isMobile,
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            icon: Icons.access_time_rounded,
            label: "Time",
            value: event.timeDisplay,
            isMobile: isMobile,
            isHighlighted: true,
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: "Venue",
            value: "${event.venueName}\n${event.venueAddress}",
            isMobile: isMobile,
          ),

          // Extra Note (e.g. Sadhya and remaining functions in SNDP Auditorium)
          if (event.note.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: WeddingColors.emeraldSoft.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: WeddingColors.emeraldMedium.withOpacity(0.15),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: WeddingColors.emeraldMedium,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      event.note,
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile ? 11 : 12,
                        color: WeddingColors.emeraldDark,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Action Buttons: Get Directions & Add to Calendar
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              _buildActionButton(
                label: isTemple ? "Temple Location" : "Get Directions",
                icon: Icons.directions_outlined,
                onTap: () => WeddingUtils.openUrl(event.googleMapsUrl),
                isPrimary: true,
              ),
              if (isTemple)
                _buildActionButton(
                  label: "Auditorium Location",
                  icon: Icons.place_outlined,
                  onTap: () => WeddingUtils.openUrl(WeddingData.auditoriumMapsUrl),
                  isPrimary: false,
                ),
              _buildActionButton(
                label: "Add to Calendar",
                icon: Icons.event_available_outlined,
                onTap: () => WeddingUtils.addToGoogleCalendar(event),
                isPrimary: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isMobile,
    bool isHighlighted = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: isHighlighted ? WeddingColors.goldDark : WeddingColors.textMuted,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                  color: WeddingColors.textMuted,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.montserrat(
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                  color: isHighlighted ? WeddingColors.goldDark : WeddingColors.textDark,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? WeddingColors.emeraldPrimary : Colors.white,
        foregroundColor: isPrimary ? WeddingColors.goldLight : WeddingColors.emeraldPrimary,
        elevation: isPrimary ? 2 : 0,
        side: BorderSide(
          color: isPrimary ? WeddingColors.emeraldPrimary : WeddingColors.goldBorder,
          width: 1.2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
