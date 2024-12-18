import 'package:admob_flutter/admob_flutter.dart';
import 'package:biblia/share_preferences/preferences.dart';
import 'package:biblia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Admob.initialize();
  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookProviders(),
        ),
        ChangeNotifierProvider(create: (context) => ScreenRoute()),
        ChangeNotifierProvider(create: (context) => FavoriteSongsProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(
            create: (context) => LetterSize(
                  size: Preferences.getSize,
                )),
        ChangeNotifierProvider(
            create: (context) =>
                ThemeProvider(isDarkMode: Preferences.darkMode)),
      ],
      child: SelectedThemeScreen(),
    );
  }
}

class SelectedThemeScreen extends StatelessWidget {
  const SelectedThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectedRoutes(),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
