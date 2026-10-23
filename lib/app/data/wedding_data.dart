import 'package:flutter/material.dart';

class WeddingColors {
  // Primary Emerald Palette - Clean & Royal
  static const Color emeraldDark = Color(0xFF09241A);
  static const Color emeraldPrimary = Color(0xFF0F382A);
  static const Color emeraldMedium = Color(0xFF184D3C);
  static const Color emeraldLight = Color(0xFF2B6753);
  static const Color emeraldSoft = Color(0xFFE8F2ED);

  // Antique Gold Palette - Clean & Elegant
  static const Color goldLight = Color(0xFFFBF1D5);
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldMedium = Color(0xFFC49A2B);
  static const Color goldDark = Color(0xFF8C6B13);
  static const Color goldBorder = Color(0xFFE2C876);

  // Clean Ivory & Cream Canvas
  static const Color creamLight = Color(0xFFFFFFFF);
  static const Color creamPrimary = Color(0xFFFDFBF7);
  static const Color creamWarm = Color(0xFFFAF6EE);
  static const Color creamBorder = Color(0xFFEFE8DB);

  // Clean Typography Colors
  static const Color textDark = Color(0xFF14241C);
  static const Color textBody = Color(0xFF384A41);
  static const Color textMuted = Color(0xFF6B7F76);
  static const Color textGold = Color(0xFF997517);
  static const Color textLight = Color(0xFFFAF7F2);

  // Subtle Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF7E5B5), Color(0xFFD4AF37), Color(0xFFB88E1B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [Color(0xFF09241A), Color(0xFF0F382A), Color(0xFF184D3C)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFFDFCF9)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class EventItem {
  final String id;
  final String title;
  final String subtitle;
  final String dateDisplay;
  final String timeDisplay;
  final String venueName;
  final String venueAddress;
  final String note;
  final String googleMapsUrl;
  final DateTime dateTime;
  final String calendarTitle;
  final String calendarDescription;
  final IconData icon;

  const EventItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.dateDisplay,
    required this.timeDisplay,
    required this.venueName,
    required this.venueAddress,
    this.note = "",
    required this.googleMapsUrl,
    required this.dateTime,
    required this.calendarTitle,
    required this.calendarDescription,
    required this.icon,
  });
}

class FamilyInfo {
  final String title;
  final String coupleMember;
  final String parents;
  final String address;
  final String siblings;
  final String phone;

  const FamilyInfo({
    required this.title,
    required this.coupleMember,
    required this.parents,
    required this.address,
    required this.siblings,
    required this.phone,
  });
}

class GalleryItem {
  final String imagePath;
  final String title;
  final String caption;

  const GalleryItem({
    required this.imagePath,
    required this.title,
    required this.caption,
  });
}

class AudioTrack {
  final String id;
  final String title;
  final String subtitle;
  final String assetSource;
  final String remoteFallbackUrl;

  const AudioTrack({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.assetSource,
    this.remoteFallbackUrl = "",
  });
}

class WeddingData {
  // Couple Names
  static const String groomName = "Abishek";
  static const String brideName = "KrishnaVeni";
  static const String monogram = "AK";

  // Auspicious Hindu Blessing Mantras
  static const String shlokaInvocation = "|| ॐ श्री गणेशाय नमः ||";
  static const String mangalyamShloka =
      "मांगल्यं तन्तुनानेन मम जीवनहेतुना ।\nकंठे बध्नामि सुभगे त्वं जीव शरदः शतम् ॥";
  static const String mangalyamTranslation =
      "\"This sacred thread, the pledge of my life, I tie around your neck, O auspicious one; may you live happily for a hundred autumns with me.\"";

  // Invitation Headers
  static const String invitationSubtitle = "Together with our families, we joyfully invite you to celebrate the wedding ceremony of";
  static const String formattedDate = "Thursday, 24 December 2026";
  static const String countdownHeading = "Auspicious Muhurtham In";

  // Wedding Date & Countdown Target (Dec 24, 2026 at 10:30 AM)
  static final DateTime weddingDateTime = DateTime(2026, 12, 24, 10, 30);

  // Audio Track - Acoustic Love Strings
  static const List<AudioTrack> audioTracks = [
    AudioTrack(
      id: "romantic_guitar",
      title: "Acoustic Love Strings",
      subtitle: "Emotional Romantic Acoustic Guitar",
      assetSource: "audio/romantic_acoustic_guitar.mp3",
      remoteFallbackUrl: "https://assets.mixkit.co/music/854/854.mp3",
    ),
  ];

  // Default audio backwards compatibility
  static const String localAudioPath = "assets/audio/romantic_acoustic_guitar.mp3";
  static const String remoteAudioUrl = "https://assets.mixkit.co/music/854/854.mp3";

  // Images
  static const String mainCoupleImage = "assets/images/couple_main.jpg";
  static const String story1Image = "assets/images/couple_story_1.jpg";
  static const String story2Image = "assets/images/couple_story_2.jpg";
  static const String cardPosterImage = "assets/images/card_poster.jpg";
  static const String waxSealImage = "assets/images/wax_seal.jpg";

  // Events - Exact Hindu Wedding Program
  static final List<EventItem> events = [
    EventItem(
      id: "thalikettu",
      title: "Thalikettu (Muhurtham)",
      subtitle: "The Sacred Hindu Marriage Vows",
      dateDisplay: "Thursday, 24 December 2026",
      timeDisplay: "10:30 AM – 11:00 AM",
      venueName: "Thirumoozhikkulam Sri Lakshmana Perumal Temple",
      venueAddress: "Thirumoozhikkulam, Moozhikkulam, Kerala",
      note: "After Thalikettu, the rest of the auspicious rituals & traditional Sadhya feast will be held at S.N.D.P Auditorium Kurumassery.",
      googleMapsUrl: "https://maps.app.goo.gl/WJ9UotwKSvnDSZoh9?g_st=aw",
      dateTime: DateTime(2026, 12, 24, 10, 30),
      calendarTitle: "Thalikettu Ceremony: Abishek & KrishnaVeni",
      calendarDescription: "Sacred Thalikettu (Muhurtham) of Abishek & KrishnaVeni at Thirumoozhikkulam Sri Lakshmana Perumal Temple, followed by rituals & feast at S.N.D.P Auditorium Kurumassery.",
      icon: Icons.favorite_rounded,
    ),
    EventItem(
      id: "reception",
      title: "The Wedding Reception",
      subtitle: "An Evening of Celebration & Warm Wishes",
      dateDisplay: "Thursday, 24 December 2026",
      timeDisplay: "05:00 PM – 09:00 PM",
      venueName: "S.N.D.P. Auditorium",
      venueAddress: "Kurumassery, Kerala",
      note: "Join us for an enchanting evening of music, felicitations, and a grand celebratory dinner.",
      googleMapsUrl: "https://maps.app.goo.gl/Ae6UogFhQtB94D5A7?g_st=aw",
      dateTime: DateTime(2026, 12, 24, 17, 0),
      calendarTitle: "Wedding Reception: Abishek & KrishnaVeni",
      calendarDescription: "Wedding reception and celebratory dinner honoring the newlyweds Abishek & KrishnaVeni at S.N.D.P Auditorium Kurumassery.",
      icon: Icons.celebration_rounded,
    ),
  ];

  // Secondary Feast Location link
  static const String auditoriumMapsUrl = "https://maps.app.goo.gl/Ae6UogFhQtB94D5A7?g_st=aw";

  // Family Info
  static const FamilyInfo groomFamily = FamilyInfo(
    title: "Groom's Family",
    coupleMember: "Abishek",
    parents: "Baburaj M. S. & Sangeetha Baburaj",
    address: "Mekkonath House, Kurumassery P.O, Kurumassery",
    siblings: "Adwaitha M. B.",
    phone: "+919846000001",
  );

  static const FamilyInfo brideFamily = FamilyInfo(
    title: "Bride's Family",
    coupleMember: "KrishnaVeni",
    parents: "Unnikrishnan T. S. & Viji Unnikrishnan",
    address: "Thekkumkattil (H), Chettikulam, Vattapparambu P.O",
    siblings: "Krishnavaiga",
    phone: "+919846000002",
  );

  static const String siblingsWarmRegards = "Adwaitha M. B. & Krishnavaiga";

  // Gallery
  static final List<GalleryItem> galleryItems = [
    GalleryItem(
      imagePath: mainCoupleImage,
      title: "Soulmates by the Ocean",
      caption: "Two hearts beating as one under the endless horizon",
    ),
    GalleryItem(
      imagePath: story1Image,
      title: "Golden Smiles",
      caption: "Moments of shared joy and tender whispers",
    ),
    GalleryItem(
      imagePath: story2Image,
      title: "Together in Love",
      caption: "Walking side by side into a beautiful new dawn",
    ),
    GalleryItem(
      imagePath: cardPosterImage,
      title: "Sacred Lotus & Peacock Feather",
      caption: "Divinely blessed union — Abishek & KrishnaVeni",
    ),
  ];

  static const String blessingsWhatsAppMessage =
      "Dear Abishek & KrishnaVeni, Heartiest congratulations on your wedding! Wishing you both a divine, blissful, and happy married life filled with love, prosperity, and joy!";
}
