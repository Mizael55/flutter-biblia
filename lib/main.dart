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
        ChangeNotifierProvider(create: (context) => BooksNamesProvider()),
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
    return const HomeScreen();
  }
}


class Screen extends StatelessWidget {
   
  const Screen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('Screen'),
      ),
    );
  }
}