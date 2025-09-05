// import 'dart:async';
// import 'package:audioplayers/audioplayers.dart';
//
// class SoundUtils {
//   static final AudioPlayer _audioPlayer = AudioPlayer();
//   static Timer? _stopTimer;
//
//   static Future<void> playRingtone() async {
//     await _audioPlayer.setReleaseMode(ReleaseMode.loop);
//     await _audioPlayer.play(AssetSource('sounds/sound1.wav'));
//
//     // 🕒 1 minute baad automatic stop
//     _stopTimer?.cancel(); // agar pehle se koi timer ho to cancel karo
//     _stopTimer = Timer(const Duration(seconds: 30), () {
//       stopRingtone();
//     });
//   }
//
//   static void stopRingtone() {
//     _audioPlayer.stop();
//     _stopTimer?.cancel(); // timer bhi band karo agar user ne "OK" dabaya
//     _stopTimer = null;
//   }
// }