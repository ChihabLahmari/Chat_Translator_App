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
    if (imageNum == '0') return 'assets/images/boySticker.png';
    if (imageNum == '1') return 'assets/images/girlSticker.png';
    if (imageNum == '2') return 'assets/images/belliSticker.png';
    return 'assets/images/boySticker.png';
  }
}
