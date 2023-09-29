import 'package:flutter/material.dart';

import 'login_page_controller.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({Key? key});

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login to database', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            SizedBox(
              width: 400,
              child: TextField(
                autofocus: true,
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your username:',
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 400,
              child: TextField(
                autofocus: true,
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your password:',
                ),
              ),
            ),
            const SizedBox(height: 8),
            MaterialButton(
              onPressed: () {
                submitLogin(
                    context, usernameController.text, passwordController.text);
              },
              padding: const EdgeInsetsDirectional.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.deepPurple)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Submit', style: TextStyle(fontSize: 24)),
                  Icon(Icons.lock_open_rounded, size: 32)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
