import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaam_hai/Features/Auth/Services/auth_service.dart';
import 'package:kaam_hai/Features/Auth/presentation/email_field.dart';
import 'package:kaam_hai/Features/Auth/presentation/password_field.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showToast("Email and Password cannot be empty");
      return;
    }
    if (password.length < 6) {
      showToast("Password must be at least 6 characters");
      return;
    }

    setState(() => isLoading = true);

    try {
      User? user = await AuthService().signUp(email, password);
      if (user != null) {
        Fluttertoast.showToast(
          msg: "Sign up successful!",
          backgroundColor: Colors.green,
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showToast("Sign up failed. Try again.");
      }
    } on FirebaseAuthException catch (e) {
      showToast(e.message ?? "Sign up error");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo placeholder
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: AssetImage('assets/KaamHai_Logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Icon(Icons.person, size: 60, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              // TextField(
              //   controller: emailController,
              //   decoration: InputDecoration(
              //     labelText: "Email",
              //     border: OutlineInputBorder(),
              //     prefixIcon: Icon(Icons.email),
              //   ),
              // ),
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              SizedBox(height: 16),
              // TextField(
              //   controller: passwordController,
              //   decoration: InputDecoration(
              //     labelText: "Password",
              //     border: OutlineInputBorder(),
              //     prefixIcon: Icon(Icons.lock),
              //   ),
              //   obscureText: true,
              // ),
              PasswordField(
                controller: passwordController,
                hintText: "Password",
              ),
              SizedBox(height: 24),
              isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: signUp,
                      child: Text("Sign Up"),
                    ),
                  ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text("Already have an account? Log In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
