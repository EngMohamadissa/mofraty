// import 'package:eghypt_c/constant.dart';

// validateFunction(String val, int max, int min) {
//   (val) {
//     if (val!.isEmpty) {
//       return 'field is required';
//     }
//     return null;
//   };
//   if (val.length > max) {
//     return "$messageValidMax $max";
//   }
//   if (val.length < min) {
//     return "$messageValidMin $min";
//   }
// }

import 'package:audioplayers/audioplayers.dart';

String? checkValidate(data) {
  if (data!.isEmpty) {
    return 'لا يمكن ترك هذا الحقل فارغ';
  }
  return null;
}

String? checkValidateDrowp(value) {
  if (value == null || value.isEmpty) {
    return 'لا يمكن ترك هذا الحقل فارغ';
  }
  return null;
}

void playSound(String sound) {
  AudioPlayer player = AudioPlayer();
  player.play(AssetSource(sound)); // Correctly using AssetSource
}
