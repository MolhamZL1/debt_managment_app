import 'package:debt_managment_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:flutter/material.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Image.asset(''),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Sing Ip',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        const Text(
          'Please enter your details',
          style: TextStyle(fontSize: 12, color: Colors.blue),
        ),
        TextField(decoration: const InputDecoration(label: Text('Name'))),
        TextField(decoration: const InputDecoration(label: Text('Email'))),
        SizedBox(
          width: 200,
          child: ElevatedButton(onPressed: () {}, child: const Text('Sing In')),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dont have an account?',
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpView.routename);
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
