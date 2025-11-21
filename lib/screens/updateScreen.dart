import 'package:flutter/material.dart';
import 'package:todo_nodejs/bloc/notes_bloc.dart';
import 'package:todo_nodejs/bloc/notes_event.dart';
import 'package:todo_nodejs/bloc/notes_state.dart';
import 'package:todo_nodejs/utils/button.dart';
import 'package:todo_nodejs/utils/customAppbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateScreen extends StatefulWidget {
  final String? text;
  final String? id;
  const UpdateScreen({super.key, this.text, this.id});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController updatecontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatecontroller.text = widget.text.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(title: 'Update Note'),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                controller: updatecontroller,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Update Your Note here....',
                ),
              ),
            ),
          ),

          BlocConsumer<NotesBloc, NotesState>(
            listener: (context, state) {
              if (state.message == 'success') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Note Updated successfully!')),
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
                  title: 'Update',
                  onPressed: () {
                    context.read<NotesBloc>().add(
                      UpdateNOtes(
                        notes: updatecontroller.text,
                        id: widget.id.toString(),
                      ),
                    );
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
