import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:search/models/UserModel.dart';

class UsersApiProvider with ChangeNotifier {
  List<UserModel> users = [];

  int _limitPerPage = 5;
  final int _maxLimitPage = 10;

  final String _apiUrl = 'https://api.github.com/search/users?q=location:{location}+language:{language}&per_page={per_page}';

  String _location = '';
  String _language = '';

  void setSearchParams(String location, String language, int limitPerPage) {
    _location = location;
    _language = language;

    if (limitPerPage > _maxLimitPage) {
      limitPerPage = _maxLimitPage;
    }

    _limitPerPage = limitPerPage;
  }

  void search() async {
    if (_language.isEmpty || _location.isEmpty || _limitPerPage == 0) {
      return;
    }

    final replacedUrl = _apiUrl
        .replaceAll('{location}', _location)
        .replaceAll('{language}', _language)
        .replaceAll('{per_page}', _limitPerPage.toString());

    final response = await http.get(Uri.parse(replacedUrl));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      users = (responseData['items'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();

      notifyListeners();
    }
  }
}