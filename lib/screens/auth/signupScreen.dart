import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_nodejs/auth/auth_bloc.dart';
import 'package:todo_nodejs/auth/auth_event.dart';
import 'package:todo_nodejs/auth/auth_state.dart';
import 'package:todo_nodejs/screens/auth/verifyotpscreen.dart';
import 'package:todo_nodejs/screens/homescreen.dart';
import 'package:todo_nodejs/utils/authtextfield.dart';
import 'package:todo_nodejs/utils/button.dart';
import 'package:todo_nodejs/utils/customAppbar.dart';
import 'package:todo_nodejs/utils/pick_image.dart' show PickImage;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  String? filename;
  String? filepath;
  PickImage imagepick = PickImage();
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile Image",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),

                      GestureDetector(
                        onTap: () async {
                          final file = await imagepick
                              .pickImage(); // async work first

                          setState(() {
                            // sync state update

                            filepath = file[0];
                            filename = file[1];
                          });
                        },

                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                filename ?? "Choose Image",
                                style: TextStyle(
                                  color: filename == null
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              Icon(Icons.upload_file, color: Colors.blueAccent),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

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
                          MaterialPageRoute(builder: (context) => VerifyOtpScreen()),
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
                                path: filepath
                              ),
                            );
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyOtpScreen()));
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
