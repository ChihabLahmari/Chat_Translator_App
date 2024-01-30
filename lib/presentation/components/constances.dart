import 'dart:ui';

import 'package:chat_translator/presentation/components/assets_manager.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';

class PresentationConstances {
  static bool isEmailValid(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

    return emailRegex.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    if (password.length < 7) return false;
    if (password.length > 20) return false;
    if (password.startsWith(' ')) return false;
    if (password.endsWith(' ')) return false;
    if (password.contains('  ')) {
      return false;
    } else {
      return true;
    }
  }

  static bool isNameValid(String password) {
    if (password.length < 5) return false;
    if (password.length > 15) return false;
    if (password.startsWith(' ')) return false;
    if (password.endsWith(' ')) return false;
    if (password.contains('  ')) {
      return false;
    } else {
      return true;
    }
  }

  static String getImage(String imageNum) {
    if (imageNum == '0') return ImageAsset.boySticker;
    if (imageNum == '1') return ImageAsset.girlSticker;
    if (imageNum == '2') return ImageAsset.belliSticker;
    return ImageAsset.belliSticker;
  }

  static Color getImageColor(String imageNum) {
    if (imageNum == '0') return ColorManager.yellow;
    if (imageNum == '1') return ColorManager.purple;
    if (imageNum == '2') return ColorManager.blue;
    return ColorManager.blue;
  }
}
