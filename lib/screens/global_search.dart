import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class GlobalSearchScreen extends StatelessWidget {
   
  const GlobalSearchScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('GlobalSearchScreen'),
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}