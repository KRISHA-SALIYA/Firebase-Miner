import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/service/auth_service.dart';
import 'package:my_chat_app/service/fire_service.dart';
import 'package:my_chat_app/utils/app_routes.dart';

class Sihnin extends StatefulWidget {
  const Sihnin({super.key});

  @override
  State<Sihnin> createState() => _SihninState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SihninState extends State<Sihnin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade400,
        title: Center(child: Text(" SignIN")),
        // centerTitle: true,
      ),
      backgroundColor: Colors.yellow.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.network(
              'https://i.pinimg.com/564x/cf/9f/9e/cf9f9ea04cc2d9b9f2275b3aed11dae0.jpg', // Replace with your logo URL
              height: 100,
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Enter Mail ID ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(
                      text: "LeLet's start, Your agreed to the ",
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ' & '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      UserCredential userCredential = (await AuthService
                          .instnce.auth
                          .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      ));

                      User? user = userCredential.user;

                      if (user != null) {
                        FireStoreService.instance
                            .addUser(user: user)
                            .then((value) {
                          Navigator.pushReplacementNamed(
                              context, Routes.homepage);
                        });
                      }
                      ;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade400,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Disclaimer: This app is not affiliaffiliated with any government entity and does not facilitate government services. For edueducation purposes only.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
