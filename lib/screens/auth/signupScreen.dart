import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_nodejs/auth/auth_bloc.dart';
import 'package:todo_nodejs/auth/auth_event.dart';
import 'package:todo_nodejs/auth/auth_state.dart';
import 'package:todo_nodejs/screens/homescreen.dart';
import 'package:todo_nodejs/utils/authtextfield.dart';
import 'package:todo_nodejs/utils/button.dart';
import 'package:todo_nodejs/utils/customAppbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(title: 'Signup', iscenter: true),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset("assets/notebook.png", fit: BoxFit.contain),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  AuthTextField(label: 'Name', controller: nameC),
                  SizedBox(height: 12),
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

                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state.status == 'success') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homescreen()),
                        );
                      }

                      if (state.status == 'Signup Failed') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Failed')),
                        );
                      }
                    },
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state.status == 'loading') {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CustomButton(
                          title: 'SignUp',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              RegisterEvent(
                                name: nameC.text.toString(),
                                email: emailC.text.toString(),
                                password: passC.text.toString(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
