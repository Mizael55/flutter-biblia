import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../screens/screens.dart';
import '../utils/utils.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    return Drawer(
      backgroundColor:
          theme == ThemeData.dark() ? theme.primaryColor : Colors.white,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                decoration: BoxDecoration(
                  // has que el contenedor sea circular
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(50),
                  // color: Colors.white,
                ),
                child: Image.asset('assets/icon/icon.png',
                    width: 100, height: 100),
              )),
          ListTile(
            leading: Icon(Icons.menu_book_rounded,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            trailing: Icon(Icons.arrow_forward_ios,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            title: const Text('Biblia'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ScreenRoute>(context, listen: false).setIndex(1);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectedRoutes()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.music_note,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            trailing: Icon(Icons.arrow_forward_ios,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            title: const Text('Coros'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ScreenRoute>(context, listen: false).setIndex(2);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectedRoutes()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.library_books,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            trailing: Icon(Icons.arrow_forward_ios,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            title: const Text('Himnos'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ScreenRoute>(context, listen: false).setIndex(3);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectedRoutes()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            trailing: Icon(Icons.arrow_forward_ios,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            title: const Text('Favoritos'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ScreenRoute>(context, listen: false).setIndex(4);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectedRoutes()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.search,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            trailing: Icon(Icons.arrow_forward_ios,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            title: const Text('Busqueda general'),
            onTap: () {
              Navigator.pop(context);
              // Provider.of<ScreenRoute>(context, listen: false).setIndex(5);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            trailing: Icon(Icons.arrow_forward_ios,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            title: const Text('Directorio'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ScreenRoute>(context, listen: false).setIndex(0);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DirectorioScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            trailing: Icon(Icons.arrow_forward_ios,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            title: const Text('Ajustes'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ScreenRoute>(context, listen: false).setIndex(5);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            trailing: Icon(Icons.arrow_forward_ios,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ScreenRoute>(context, listen: false).setIndex(0);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectedRoutes()));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
