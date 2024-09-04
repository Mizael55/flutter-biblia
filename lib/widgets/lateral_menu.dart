import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Biblia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const Text(
                  'Versión Reina Valera 1960',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Inicio'),
            onTap: () {
            },
          ),
          ListTile(
            title: const Text('Biblia'),
            onTap: () {
            },
          ),
          ListTile(
            title: const Text('Configuración'),
            onTap: () {
            },
          ),
          ListTile(
            title: const Text('Acerca de'),
            onTap: () {
            },
          ),
          ListTile(
            title: const Text('Tamaño de letra'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Tamaño de letra'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: const Text('Pequeño'),
                          onTap: () {
                          },
                        ),
                        ListTile(
                          title: const Text('Mediano'),
                          onTap: () {
                          },
                        ),
                        ListTile(
                          title: const Text('Grande'),
                          onTap: () {
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
