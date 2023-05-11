import 'package:flutter/material.dart';

class EncryptDecryptScreen extends StatefulWidget {
  const EncryptDecryptScreen({super.key});

  @override
  State<EncryptDecryptScreen> createState() => _EncryptDecryptScreenState();
}

class _EncryptDecryptScreenState extends State<EncryptDecryptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Encrypt/Decrypt"),
      ),
    );
  }
}
