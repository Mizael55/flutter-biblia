import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // this is the leading icon to open the drawer menu
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                //TODO: this is a bad practice to call the provider here
                // this maybe should be call in the initState method
                Provider.of<BooksNamesProvider>(context, listen: false)
                    .gettingBooksNames();
                Scaffold.of(context).openDrawer();
              }),
        ),
      ),
      drawer: const DrawerScreen(),
      body: const Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}