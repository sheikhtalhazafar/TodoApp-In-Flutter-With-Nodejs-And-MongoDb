import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_nodejs/bloc/notes_bloc.dart';
import 'package:todo_nodejs/bloc/notes_event.dart';
import 'package:todo_nodejs/bloc/notes_state.dart';
import 'package:todo_nodejs/screens/addnotescreen.dart';
import 'package:todo_nodejs/screens/updateScreen.dart';
import 'package:todo_nodejs/utils/customAppbar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotesBloc>().add(FetchallNOtes());
  }

  @override
  Widget build(BuildContext context) {
    print('build homeScreen');
    return Scaffold(
      appBar: Customappbar(
        title: 'All notes',
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Addnotescreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
          ),
        ],
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
                                menubutton(
                                  state.allNotes[index].id.toString(),
                                  state.allNotes[index].notes.toString(),
                                  context,
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

Widget menubutton(String id, String updateText, BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (value) {
      // if (value == 'edit') {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => UpdateScreen(text: updateText, id: id),
      //     ),
      //   );
      // }
      if (value == 'delete') {
        context.read<NotesBloc>().add(DeleteNOtes(id: id));
      }
    },
    itemBuilder: (context) => [
      // PopupMenuItem(value: 'edit', child: Icon(Icons.edit)),
      PopupMenuItem(value: 'delete', child: Icon(Icons.delete)),
    ],
  );
}
