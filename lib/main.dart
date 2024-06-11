import 'package:biblia/share_preferences/preferences.dart';
import 'package:biblia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BooksNamesProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ScreenRoute()),
        ChangeNotifierProvider(create: (context) => LetterSize()),
        ChangeNotifierProvider(
            create: (context) =>
                ThemeProvider(isDarkMode: Preferences.isDarkMode)),
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
