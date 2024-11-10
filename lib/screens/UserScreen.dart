import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/models/UserModel.dart';
import 'package:search/providers/RepositoriesApiProvider.dart';

class UserScreen extends StatelessWidget {
  final UserModel user;
  UserScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RepositoriesApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.login),
      ),
      body: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
            radius: 50,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              provider.findRepositories(user.login);
            },
            child: const Text('Show Repositories'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.repositories.length,
              itemBuilder: (context, index) {
                final repo = provider.repositories[index];
                return ListTile(
                  title: Text(repo.name),
                  subtitle: Text(repo.url),
                  onTap: () {
                    // Optionally, open repo URL in a browser
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}