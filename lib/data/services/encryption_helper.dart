import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  static final _key =
      encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 32 chars
  static final _iv = encrypt.IV.fromUtf8('my16lengthiv4567'); // 16 chars
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  static String encryptPassword(String password) {
    final encrypted = _encrypter.encrypt(password, iv: _iv);
    return encrypted.base64;
  }

  static String decryptPassword(String encryptedPassword) {
    final decrypted = _encrypter.decrypt64(encryptedPassword, iv: _iv);
    return decrypted;
  }
}
