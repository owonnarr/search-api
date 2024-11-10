import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/providers/UsersApiProvider.dart';
import 'package:search/screens/UserScreen.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsersApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: languageController,
              decoration: const InputDecoration(labelText: 'Language'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                provider.setSearchParams(locationController.text, languageController.text, 5);
                provider.search();
              },
              child: Text('Search'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.users.length,
                itemBuilder: (context, index) {
                  final user = provider.users[index];
                  return ListTile(
                    leading: Image.network(user.avatarUrl),
                    title: Text(user.login),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserScreen(user: user),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}