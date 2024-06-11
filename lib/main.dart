import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'screens/screens.dart';

void main() {
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
        ChangeNotifierProvider(
          create: (context) => ScreenRoute(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<BooksNamesProvider>(context).getChapterList();
    final index = Provider.of<ScreenRoute>(context).currentIndex;

    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const GlobalSearchScreen();
      case 2:
        return const SettingsScreen();
      default:
        return const HomeScreen();
    }
  }
}
