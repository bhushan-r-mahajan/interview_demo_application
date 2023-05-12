import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:provider/provider.dart';

import '../controllers/encrypt_decrypt.dart';

class EncryptDecryptScreen extends StatefulWidget {
  const EncryptDecryptScreen({super.key});

  @override
  State<EncryptDecryptScreen> createState() => _EncryptDecryptScreenState();
}

class _EncryptDecryptScreenState extends State<EncryptDecryptScreen> {
  final _formKey = GlobalKey<FormState>();
  String message = "";
  String key = "";
  
  @override
  Widget build(BuildContext context) {
    var encryptDecrypt = Provider.of<EncryptDecryptController>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Message can't be empty";
                      }
                      return null;
                    },
                    onSaved: (value) => message = value!,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Key can't be empty";
                      } else if (value.length < 32 || value.length > 32) {
                        return "Key must be 32 chars";
                      }
                      return null;
                    },
                    onSaved: (value) => key = value!,
                    decoration: const InputDecoration(
                      hintText: "Secret Key",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            encryptDecrypt.encryptAES(message, key);
                          },
                          child: const Text(
                            "Encrypt",
                            style: TextStyles.defaultTextStyle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            encryptDecrypt.decryptAES(key);
                          },
                          child: const Text(
                            "Decrypt",
                            style: TextStyles.defaultTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onLongPress: () async {
                      if (encryptDecrypt.encrypted != null) {
                        await Clipboard.setData(
                          ClipboardData(
                              text: "${encryptDecrypt.encrypted?.base64}"),
                        );
                      }
                    },
                    child: Text(
                      "EncryptText : ${encryptDecrypt.encrypted != null ? encryptDecrypt.encrypted?.base64 : ''}",
                      maxLines: 2,
                      style: TextStyles.defaultBoldTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onLongPress: () async {
                      if (encryptDecrypt.decrypted.isNotEmpty) {
                        await Clipboard.setData(
                            ClipboardData(text: encryptDecrypt.decrypted));
                      }
                    },
                    child: Text(
                      "DecryptText : ${encryptDecrypt.decrypted}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.defaultBoldTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
