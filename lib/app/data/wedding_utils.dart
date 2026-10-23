import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'wedding_data.dart';

class WeddingUtils {
  static Future<void> openUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint("Could not launch URL: $urlString, error: $e");
    }
  }

  static Future<void> openPhone(String phoneNumber) async {
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse("tel:$cleanPhone");
    await openUrl(uri.toString());
  }

  static Future<void> openWhatsApp(String phoneNumber, String message) async {
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final encodedMessage = Uri.encodeComponent(message);
    final url = "https://wa.me/$cleanPhone?text=$encodedMessage";
    await openUrl(url);
  }

  static Future<void> addToGoogleCalendar(EventItem event) async {
    // Format: YYYYMMDDTHHMMSSZ
    final startTime = event.dateTime.toUtc();
    final endTime = startTime.add(const Duration(hours: 3));

    String formatUtc(DateTime dt) {
      return dt.toIso8601String().replaceAll(RegExp(r'[-:]'), '').split('.').first + "Z";
    }

    final startStr = formatUtc(startTime);
    final endStr = formatUtc(endTime);

    final title = Uri.encodeComponent(event.calendarTitle);
    final details = Uri.encodeComponent(
        "${event.calendarDescription}\n\nVenue: ${event.venueName}, ${event.venueAddress}");
    final location = Uri.encodeComponent("${event.venueName}, ${event.venueAddress}");

    final calendarUrl =
        "https://calendar.google.com/calendar/render?action=TEMPLATE&text=$title&dates=$startStr/$endStr&details=$details&location=$location";

    await openUrl(calendarUrl);
  }
}
