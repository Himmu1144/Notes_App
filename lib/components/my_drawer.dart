import 'package:flutter/material.dart';
import 'package:notes/components/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
              child: Icon(
            Icons.book_rounded,
            color: Theme.of(context).colorScheme.inversePrimary,
          )),

          // Notes tile
          DrawerTile(
              title: 'Notes',
              leading: Icon(
                Icons.book_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          // Notes tile
          DrawerTile(
              title: 'Settings',
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              })

          // Settings Tile
        ],
      ),
    );
  }
}
