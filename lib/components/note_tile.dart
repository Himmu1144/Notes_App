import 'package:flutter/material.dart';
import 'package:notes/components/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? ondeletePressed;
  const NoteTile(
      {super.key,
      required this.text,
      required this.onEditPressed,
      required this.ondeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 8, left: 25, right: 25),
      child: ListTile(
          title: Text(text),
          trailing: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showPopover(
                  height: 100,
                  width: 100,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  context: context,
                  bodyBuilder: (context) => NoteSettings(
                        onEditTap: onEditPressed,
                        ondeleteTap: ondeletePressed,
                      )),
            );
          })),
    );
  }
}
