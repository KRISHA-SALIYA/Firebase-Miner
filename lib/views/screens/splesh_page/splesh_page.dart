import 'package:flutter/material.dart';
import 'package:my_chat_app/service/auth_service.dart';
import 'package:my_chat_app/utils/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://i.pinimg.com/564x/6b/50/d5/6b50d511307f0870a1693afc22cace47.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 50),
          // Align(
          //   alignment: Alignment.center,
          //   child: ElevatedButton.icon(
          //     style: ElevatedButton.styleFrom(
          //       foregroundColor: Colors.black,
          //       backgroundColor: Colors.white,
          //       minimumSize: const Size(250, 50),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //     ),
          //     onPressed: () {
          //       Navigator.pushNamed(context, Routes.creataccount);
          //     },
          //     icon: const Icon(Icons.login, color: Colors.red),
          //     label: const Text('Continue with phone'),
          //   ),
          // ),
          const SizedBox(height: 70),
          Align(
            alignment: const Alignment(0, 0.2),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.signup);
              },
              child: const Text('Sign Up'),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: const Alignment(0, 0.4),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.signin);
              },
              child: const Text(
                'Already have an account? Log In',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: const Alignment(0, 0.8),
          //   child: ElevatedButton.icon(
          //     style: ElevatedButton.styleFrom(
          //       foregroundColor: Colors.black,
          //       backgroundColor: Colors.white,
          //       minimumSize: const Size(250, 50),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //     ),
          //     onPressed: () {
          //       AuthService.instnce.signInWithGoogle().then(
          //         (value) {
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             const SnackBar(
          //               backgroundColor: Colors.green,
          //               content: Text("Login succesfull"),
          //             ),
          //           );
          //         },
          //       );
          //       Navigator.pushNamed(context, Routes.homepage);
          //     },
          //     icon: const Icon(Icons.login, color: Colors.red),
          //     label: const Text('Continue with Google'),
          //   ),
          // ),
          // Align(
          //   alignment: const Alignment(0, 0.6),
          //   child: ElevatedButton.icon(
          //     style: ElevatedButton.styleFrom(
          //       foregroundColor: Colors.black,
          //       backgroundColor: Colors.white,
          //       minimumSize: const Size(250, 50),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //     ),
          //     onPressed: () {
          //       AuthService.instnce.signInWithFacebook().then(
          //         (value) {
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             const SnackBar(
          //               backgroundColor: Colors.green,
          //               content: Text("Login succesfull"),
          //             ),
          //           );
          //           Navigator.pushNamed(context, Routes.homepage);
          //         },
          //       );
          //     },
          //     icon: const Icon(Icons.login, color: Colors.red),
          //     label: const Text('Continue with FB'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
