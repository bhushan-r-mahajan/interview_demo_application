import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_demo_application/components/button.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.emptyMessageError;
                      }
                      return null;
                    },
                    onSaved: (value) => message = value!,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.message,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.emptyKeyError;
                      } else if (value.length < 32 || value.length > 32) {
                        return AppLocalizations.of(context)!.keyLengthError;
                      }
                      return null;
                    },
                    onSaved: (value) => key = value!,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.secretKey,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: CommonButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          encryptDecrypt.encryptAES(message, key);
                        },
                        buttonText: AppLocalizations.of(context)!.encrypt,
                      )),
                      const SizedBox(width: 30),
                      Expanded(
                        child: CommonButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            encryptDecrypt.decryptAES(key);
                          },
                          buttonText: AppLocalizations.of(context)!.decrypt,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onLongPress: () async {
                      if (encryptDecrypt.encrypted != null) {
                        await Clipboard.setData(
                          ClipboardData(
                              text: "${encryptDecrypt.encrypted?.base64}"),
                        );
                        if (mounted) {
                          var snackBar = SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!
                                  .encryptedCopyMessage,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text(
                      "${AppLocalizations.of(context)!.encryption} : ${encryptDecrypt.encrypted != null ? encryptDecrypt.encrypted?.base64 : ''}",
                      maxLines: 2,
                      style: TextStyles.defaultBoldTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onLongPress: () async {
                      if (encryptDecrypt.decrypted.isNotEmpty) {
                        await Clipboard.setData(
                            ClipboardData(text: encryptDecrypt.decrypted));
                        if (mounted) {
                          var snackBar = SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!
                                  .decryptedCopyMessage,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text(
                      "${AppLocalizations.of(context)!.decryption} : ${encryptDecrypt.decrypted}",
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
