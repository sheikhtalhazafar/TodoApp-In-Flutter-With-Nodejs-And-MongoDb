import 'package:flutter/material.dart';
import 'package:todo_nodejs/bloc/notes_bloc.dart';
import 'package:todo_nodejs/bloc/notes_event.dart';
import 'package:todo_nodejs/bloc/notes_state.dart';
import 'package:todo_nodejs/model/notemodel.dart';
import 'package:todo_nodejs/utils/button.dart';
import 'package:todo_nodejs/utils/customAppbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addnotescreen extends StatefulWidget {
  const Addnotescreen({super.key});

  @override
  State<Addnotescreen> createState() => _AddnotescreenState();
}

class _AddnotescreenState extends State<Addnotescreen> {
  TextEditingController postcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(title: 'Add Notes'),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                controller: postcontroller,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(hintText: 'Add Your Note here....'),
              ),
            ),
          ),

          BlocConsumer<NotesBloc, NotesState>(
            listener: (context, state) {
              if (state.message == 'success') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Note added successfully!')),
                );
              } else if (state.message == 'Failed') {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Something went wrong')));
              }
            },
            builder: (context, state) {
              if (state.message == 'loading') {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  title: 'Post',
                  onPressed: () {
                    context.read<NotesBloc>().add(
                      PostNOtes(notes: postcontroller.text),
                    );
                    state.allNotes.add(NoteModel(notes: postcontroller.text));
                  },
                ),

         
              );
            },
          ),
        ],
      ),
    );
  }
}
