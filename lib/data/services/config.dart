import 'dart:math';

class Config {
  static const String baseUrl = 'https://8955-103-72-2-89.ngrok-free.app';

  static String generateRandomId() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
      15,
      (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
    ));
  }
}
