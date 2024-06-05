import 'dart:convert';
import 'package:flutter_api/repo_list.dart';
import 'package:flutter_api/user.dart';
import 'package:http/http.dart' as http;

class HttpIntegration {
  final String url;
  HttpIntegration(this.url);

  Future<GitHubUser> fetchUser(String user) async {
    final response = await http.get(Uri.parse('$url/users/$user'));
    if (response.statusCode == 200) {
      return GitHubUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<RepoList> fetchRepositories(String user) async {
    final response = await http.get(Uri.parse('$url/users/$user/repos'));
    if (response.statusCode == 200) {
      return RepoList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load repository');
    }
  }
}