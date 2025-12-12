import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MusicPlayer {
  static final MusicPlayer _instance = MusicPlayer._internal();
  factory MusicPlayer() => _instance;
  MusicPlayer._internal();

  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      await _player.setSource(AssetSource('audio/wedding_music.mp3'));
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.setVolume(0.7); // Громкость 70%
      _isInitialized = true;
      print('✅ Музыка инициализирована');
    } catch (e) {
      print('❌ Ошибка инициализации музыки: $e');
    }
  }

  Future<void> play() async {
    if (!_isInitialized) {
      await initialize();
    }
    
    try {
      await _player.resume();
      _isPlaying = true;
      print('▶️ Музыка начала играть');
    } catch (e) {
      print('❌ Ошибка воспроизведения: $e');
    }
  }

  Future<void> playWithDelay() async {
    // Для Android/iOS - небольшая задержка перед запуском
    await Future.delayed(const Duration(milliseconds: 800));
    await play();
  }

  Future<void> pause() async {
    try {
      await _player.pause();
      _isPlaying = false;
      print('⏸️ Музыка на паузе');
    } catch (e) {
      print('❌ Ошибка паузы: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
      _isPlaying = false;
      print('⏹️ Музыка остановлена');
    } catch (e) {
      print('❌ Ошибка остановки: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      await _player.setVolume(volume);
    } catch (e) {
      print('❌ Ошибка настройки громкости: $e');
    }
  }

  bool get isPlaying => _isPlaying;
  
  // Проверяем, можем ли автозапускать музыку
  bool get canAutoPlay => !kIsWeb; // Только для Android/iOS, не для web
}