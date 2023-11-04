import 'package:firebase_app/core/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NovaConta extends StatefulWidget {
  const NovaConta({super.key});

  @override
  State<NovaConta> createState() => _NovaContaState();
}

class _NovaContaState extends State<NovaConta> {
  final txtEmail = TextEditingController();
  final txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova conta '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: txtEmail,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
            ),
            TextField(
              controller: txtSenha,
              decoration: const InputDecoration(
                label: Text('Senha'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final usuario = await AuthService()
                        .novaConta(txtEmail.text, txtSenha.text);

                    if (usuario != null) {
                      Navigator.of(context).pop(
                          {'email': txtEmail.text, 'senha': txtSenha.text});
                    }
                  } on FirebaseAuthException catch (ex) {
                    var message = '';
                    if (ex.code == 'email-already-in-use') {
                      message = 'O endereço de email já esta em uso';
                    } else if (ex.code == 'invalid-email') {
                      message = 'O endereço de email está num formato inválido';
                    } else if (ex.code == 'weak-password' ||
                        ex.code == 'missing-password') {
                      message = 'A senha precisa ter pelo menos 6 caracteres';
                    }

                    final snackBar = SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    print(ex.code);
                  }
                },
                child: Text('Gravar'))
          ],
        ),
      ),
    );
  }
}
