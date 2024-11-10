import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:search/models/RepositoryModel.dart';
import 'dart:convert';

class RepositoriesApiProvider with ChangeNotifier {
  List<RepositoryModel> repositories = [];
  final String _apiUrl = 'https://api.github.com/users/{profile}/repos';

  findRepositories(String username) async {
    final response = await http.get(Uri.parse(_apiUrl.replaceAll('{profile}', username)));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      repositories = (data as List).map((repo) => RepositoryModel.fromJson(repo)).toList();

      if (repositories.isEmpty) {
        return;
      }

      notifyListeners();
    }
  }
}