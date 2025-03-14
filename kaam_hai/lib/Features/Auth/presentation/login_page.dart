import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaam_hai/Features/Auth/bloc/auth_bloc.dart';
import 'package:kaam_hai/Features/Auth/bloc/auth_event.dart';
import 'package:kaam_hai/Features/Auth/bloc/auth_state.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/logo.png', height: 80),
                        const SizedBox(height: 20),
                        Card(
                          color: Colors.white,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    fillColor: Color(0xFFF5F5F5),
                                    filled: true,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                TextField(
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    fillColor: Color(0xFFF5F5F5),
                                    filled: true,
                                  ),
                                  obscureText: true,
                                ),
                                const SizedBox(height: 20.0),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed:
                                                state is AuthLoading
                                                    ? null
                                                    : () {
                                                      final email =
                                                          emailController.text
                                                              .trim();
                                                      final password =
                                                          passwordController
                                                              .text;
                                                      if (email.isEmpty ||
                                                          password.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                            context,
                                                          )
                                                          ..hideCurrentSnackBar()
                                                          ..showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                'Please fill in all fields',
                                                              ),
                                                              backgroundColor:
                                                                  Colors.orange,
                                                            ),
                                                          );
                                                        return;
                                                      }
                                                      context
                                                          .read<AuthBloc>()
                                                          .add(
                                                            LoginEvent(
                                                              email: email,
                                                              password:
                                                                  password,
                                                            ),
                                                          );
                                                    },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                    255,
                                                    160,
                                                    88,
                                                    1,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                            ),
                                            child:
                                                state is AuthLoading
                                                    ? const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            color: Colors.white,
                                                          ),
                                                    )
                                                    : const Text('Login'),
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              context.read<AuthBloc>().add(
                                                GoogleSignInEvent(),
                                              );
                                            },
                                            icon: const FaIcon(
                                              FontAwesomeIcons.google,
                                              color: Colors.red,
                                            ),
                                            label: const Text(
                                              'Sign in with Google',
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.black,
                                              backgroundColor: Colors.white,
                                              side: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => SignUpPage(),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "Don't have an account? Sign Up",
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
