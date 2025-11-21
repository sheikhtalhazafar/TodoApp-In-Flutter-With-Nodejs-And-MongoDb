import 'package:flutter/material.dart';

class Customappbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const Customappbar({super.key, required this.title, this.actions});

  @override
  State<Customappbar> createState() => _CustomappbarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomappbarState extends State<Customappbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(widget.title), actions: widget.actions);
  }
}
