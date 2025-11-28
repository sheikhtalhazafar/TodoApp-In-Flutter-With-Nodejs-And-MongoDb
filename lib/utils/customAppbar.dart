import 'package:flutter/material.dart';

class Customappbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool? iscenter;
  const Customappbar({
    super.key,
    required this.title,
    this.actions,
    this.iscenter = false,
  });

  @override
  State<Customappbar> createState() => _CustomappbarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomappbarState extends State<Customappbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
      centerTitle: widget.iscenter,
      actions: widget.actions,
    );
  }
}
