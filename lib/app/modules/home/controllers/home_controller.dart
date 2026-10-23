import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/wedding_data.dart';

class HomeController extends GetxController {
  // Envelope State (Default opened for instant presentation; replayable anytime)
  final isEnvelopeOpened = false.obs;
  final isOpeningAnimationRunning = false.obs;

  // Countdown State
  final days = 0.obs;
  final hours = 0.obs;
  final minutes = 0.obs;
  final seconds = 0.obs;
  Timer? _countdownTimer;

  // Music Player State
  final isMusicPlaying = false.obs;
  final isAudioInitialized = false.obs;
  final currentTrackIndex = 0.obs;
  AudioPlayer? _audioPlayer;

  AudioTrack get currentTrack =>
      WeddingData.audioTracks[currentTrackIndex.value];

  // Celebration / Confetti Shower State
  final celebrationCount = 0.obs;

  // Lightbox / Gallery Preview
  final activeGalleryIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    _startCountdown();
    _initAudio();
  }

  void _startCountdown() {
    _updateRemainingTime();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    final difference = WeddingData.weddingDateTime.difference(now);

    if (difference.isNegative) {
      days.value = 0;
      hours.value = 0;
      minutes.value = 0;
      seconds.value = 0;
    } else {
      days.value = difference.inDays;
      hours.value = difference.inHours % 24;
      minutes.value = difference.inMinutes % 60;
      seconds.value = difference.inSeconds % 60;
    }
  }

  Future<void> _initAudio() async {
    try {
      _audioPlayer = AudioPlayer();
      await _audioPlayer?.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer?.setVolume(0.75);

      _audioPlayer?.onPlayerStateChanged.listen((state) {
        isMusicPlaying.value = (state == PlayerState.playing);
      });

      isAudioInitialized.value = true;
    } catch (e) {
      debugPrint("Audio initialization notice: $e");
    }
  }

  Future<void> openEnvelope() async {
    if (isOpeningAnimationRunning.value || isEnvelopeOpened.value) return;
    isOpeningAnimationRunning.value = true;

    // Trigger audio play upon user gesture
    playMusic();

    // Give time for envelope seal breaking & flap opening animation
    await Future.delayed(const Duration(milliseconds: 1400));
    isEnvelopeOpened.value = true;
    isOpeningAnimationRunning.value = false;
  }

  void replayEnvelope() {
    isOpeningAnimationRunning.value = false;
    isEnvelopeOpened.value = false;
  }

  Future<void> toggleMusic() async {
    if (_audioPlayer == null) {
      await _initAudio();
    }
    if (isMusicPlaying.value) {
      await pauseMusic();
    } else {
      await playMusic();
    }
  }

  Future<void> changeTrack(int index) async {
    if (index < 0 || index >= WeddingData.audioTracks.length) return;
    currentTrackIndex.value = index;
    try {
      await _audioPlayer?.stop();
      await playMusic();
      Get.snackbar(
        "Now Playing 🎵",
        "${currentTrack.title} • ${currentTrack.subtitle}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: WeddingColors.emeraldPrimary.withValues(alpha: 0.95),
        colorText: WeddingColors.goldLight,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.music_note, color: WeddingColors.goldPrimary),
      );
    } catch (e) {
      debugPrint("Change track error: $e");
    }
  }

  void nextTrack() {
    final nextIndex = (currentTrackIndex.value + 1) % WeddingData.audioTracks.length;
    changeTrack(nextIndex);
  }

  Future<void> playMusic() async {
    try {
      if (_audioPlayer == null) {
        await _initAudio();
      }
      final track = currentTrack;
      try {
        await _audioPlayer?.play(AssetSource(track.assetSource));
      } catch (assetError) {
        debugPrint("Asset audio notice, trying remote fallback: $assetError");
        if (track.remoteFallbackUrl.isNotEmpty) {
          await _audioPlayer?.play(UrlSource(track.remoteFallbackUrl));
        } else {
          await _audioPlayer?.play(UrlSource(WeddingData.remoteAudioUrl));
        }
      }
      isMusicPlaying.value = true;
    } catch (e) {
      debugPrint("Music play error: $e");
    }
  }

  Future<void> pauseMusic() async {
    try {
      await _audioPlayer?.pause();
      isMusicPlaying.value = false;
    } catch (e) {
      debugPrint("Music pause error: $e");
    }
  }

  void triggerShowerBlessings() {
    celebrationCount.value++;
    Get.snackbar(
      "Blessings Showered! 💐✨",
      "Thank you for showering Abishek & Krishnaveni with love and prayers!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: WeddingColors.emeraldPrimary.withOpacity(0.92),
      colorText: WeddingColors.goldLight,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.favorite, color: Color(0xFFD4AF37)),
    );
  }

  void openGalleryLightbox(int index) {
    activeGalleryIndex.value = index;
  }

  void closeGalleryLightbox() {
    activeGalleryIndex.value = -1;
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    _audioPlayer?.dispose();
    super.onClose();
  }
}
