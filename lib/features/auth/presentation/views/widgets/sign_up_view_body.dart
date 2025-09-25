import 'package:flutter/material.dart';

import '../sign_in_view.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      children: [
        Image.asset(''),
        Text(
          'Sing Up',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),

        TextField(decoration: const InputDecoration(label: Text('Name'))),
        SizedBox(height: 16),
        TextField(decoration: const InputDecoration(label: Text('Email'))),
        SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: ElevatedButton(onPressed: () {}, child: const Text('Sing Up')),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Do you have an account?',
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignInView.routename);
              },
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
