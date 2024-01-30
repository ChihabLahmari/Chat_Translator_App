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
    switch (imageNum) {
      case '0':
        return ImageAsset.boySticker;
      case '1':
        return ImageAsset.girlSticker;
      case '2':
        return ImageAsset.belliSticker;
      case '3':
        return ImageAsset.boy2Sticker;
      default:
        return ImageAsset.belliSticker;
    }
  }

  static Color getImageColor(String imageNum) {
    switch (imageNum) {
      case '0':
        return ColorManager.yellow;
      case '1':
        return ColorManager.purple;
      case '2':
        return ColorManager.blue;
      case '3':
        return ColorManager.greenLight;
      default:
        return ColorManager.blue;
    }
  }
}
