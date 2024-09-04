import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: Image.asset('assets/icon/icon.png',
                    width: 100, height: 100),
              )),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            title: const Text('Inicio'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.book, color: Colors.white),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            title: const Text('Himnos'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.music_note, color: Colors.white),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            title: const Text('Coros'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            title: const Text('Ajustes'),
            onTap: () {},
          ),
          Divider(),
        ],
      ),
    );
  }
}
