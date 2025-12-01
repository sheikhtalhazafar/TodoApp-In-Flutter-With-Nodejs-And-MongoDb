import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_nodejs/bloc/notes_bloc.dart';
import 'package:todo_nodejs/bloc/notes_event.dart';
import 'package:todo_nodejs/bloc/notes_state.dart';
import 'package:todo_nodejs/model/usermodel.dart';
import 'package:todo_nodejs/screens/addnotescreen.dart';
import 'package:todo_nodejs/screens/auth/loginScreen.dart';
import 'package:todo_nodejs/screens/updateScreen.dart';
import 'package:todo_nodejs/utils/customAppbar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final storage = const FlutterSecureStorage();
  User? user;
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(FetchallNOtes());
    loadUser();
  }

  Future<void> loadUser() async {
    final userData = await storage.read(key: 'UserData');
    if (userData != null) {
      final userJson = json.decode(userData);
      setState(() {
        user = User.fromJson(userJson);
      });
      print(user?.username);
    }
  }

  Future<void> _logout() async {
    await storage.deleteAll();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Loginscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build homeScreen');
    return Scaffold(
      appBar: Customappbar(
        title: 'All notes',
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == "Add") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Addnotescreen()),
                );
              }
              if (value == "Logout") {
                _logout();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Add',
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // outline color
                      width: 1.5, // outline thickness
                    ),
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // optional rounded corners
                  ),
                  child: Icon(Icons.add),
                ),
              ),
              PopupMenuItem(value: 'Logout', child: Icon(Icons.logout)),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user?.profileImage ?? 'https://assets.bucketlistly.blog/sites/5adf778b6eabcc00190b75b1/content_entry5adf77af6eabcc00190b75b6/6075185986d092000b192d0a/files/best-free-travel-images-main-image-op.webp'),
                  ),
                  Text(
                    user?.username ?? "Guest",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
        
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                _logout(); // your logout function
              },
            ),
          ],
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NotesBloc>().add(FetchallNOtes());
        },
        child: BlocConsumer<NotesBloc, NotesState>(
          listener: (context, state) {
            if (state.message == 'deleted') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Note deleted successfully!')),
              );
            }
          },
          builder: (context, state) {
            print('build bloc consumer');
            if (state.message == 'loading') {
              return Center(child: CircularProgressIndicator());
            }
            if (state.allNotes.isEmpty) {
              return Center(child: Center(child: Text('No Notes Found')));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: state.allNotes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateScreen(
                          text: state.allNotes[index].notes.toString(),
                          id: state.allNotes[index].id.toString(),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MenuButton(
                                  id: state.allNotes[index].id.toString(),
                                  updateText: state.allNotes[index].notes
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            state.allNotes[index].notes.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String id;
  final String updateText;

  const MenuButton({super.key, required this.id, required this.updateText});

  @override
  Widget build(BuildContext context) {
    print('id in menu : $id');
    return PopupMenuButton(
      onSelected: (value) {
        if (value == "delete") {
          print("Deleting: $id");
          context.read<NotesBloc>().add(DeleteNOtes(id: id));
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'delete', child: Icon(Icons.delete)),
      ],
    );
  }
}
