import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class GlobalSearchScreen extends StatelessWidget {
  const GlobalSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 70),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Buscar',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                    onTap: () {},
                  );
                },
              ),
            ),

          
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
