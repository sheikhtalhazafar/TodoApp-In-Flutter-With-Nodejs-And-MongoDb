// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_nodejs/auth/auth_bloc.dart';
import 'package:todo_nodejs/auth/auth_event.dart';
import 'package:todo_nodejs/auth/auth_state.dart';
import 'package:todo_nodejs/screens/auth/signupScreen.dart';
import 'package:todo_nodejs/screens/homescreen.dart' show Homescreen;
import 'package:todo_nodejs/utils/authtextfield.dart';
import 'package:todo_nodejs/utils/button.dart';
import 'package:todo_nodejs/utils/customAppbar.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(title: 'Login', iscenter: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 25,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset("assets/notebook.png", fit: BoxFit.contain),
              ),
          
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 15,
                children: [
                  AuthTextField(
                    label: 'Email',
                    controller: emailC,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 12),
                  AuthTextField(
                    label: 'Password',
                    controller: passC,
                    obscure: true,
                  ),
                  SizedBox(height: 12),
          
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state.status == 'success') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homescreen()),
                        );
                      }
          
                      if (state.status == 'Login Failed') {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Login Failed')));
                      }
                    },
                    builder: (context, state) {
                      if (state.status == 'loading') {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CustomButton(
                        title: 'Login',
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            LoginEvent(
                              email: emailC.text.toString(),
                              password: passC.text.toString(),
                            ),
                          );
                        },
                      );
                    },
                  ),
          
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignupScreen()),
                    ),
                    child: Text('Create account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
