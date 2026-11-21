import 'package:flutter/material.dart';
import 'package:pertemuan6_firebase/providers/auth_notifier.dart';
import 'package:pertemuan6_firebase/screens/sign_in_screen.dart';
import 'package:pertemuan6_firebase/utils/snackbar_helper.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {
   final emailController = TextEditingController();
   final passwordController = TextEditingController();

   @override
   void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
   }
  

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final authNotifier = context.watch<AuthNotifier>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: authNotifier.isLoading
                      ? null
                      : () async {
                          final success =
                              await context
                                  .read<AuthNotifier>()
                                  .signUp(
                                    emailController.text.trim(),
                                    passwordController.text,
                                  );

                          if (!context.mounted) return;

                          if (!success) {
                            SnackBarHelper.show(
                              context,
                              'Registerasi gagal. Periksa email dan password kembali',
                            );
                          }
                        },
                  child: authNotifier.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SignInScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sudah punya akun? Sign In',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}