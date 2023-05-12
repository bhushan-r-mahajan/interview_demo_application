import 'package:encrypt/encrypt.dart' as en;
import 'package:flutter/material.dart';

class EncryptDecryptData extends ChangeNotifier {

  en.Encrypted? encrypted;
  String decrypted = "";

  void encryptAES(String plainText, String encryptionKey) {
    final key = en.Key.fromUtf8(encryptionKey);
    final iv = en.IV.fromLength(16);
    final encrypter = en.Encrypter(en.AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    notifyListeners();
  }

  void decryptAES(String encryptionKey) {
    final key = en.Key.fromUtf8(encryptionKey);
    final iv = en.IV.fromLength(16);
    final encrypter = en.Encrypter(en.AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);
    notifyListeners();
  }
}
