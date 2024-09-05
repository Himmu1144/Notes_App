import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? ondeleteTap;
  const NoteSettings(
      {super.key, required this.onEditTap, required this.ondeleteTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onEditTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: const Center(child: Text('Edit')),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            ondeleteTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: const Center(child: Text('Delete')),
          ),
        )
      ],
    );
  }
}
