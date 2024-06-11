import 'package:biblia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SelectedRoutes(),
      ),
    );
  }
}


