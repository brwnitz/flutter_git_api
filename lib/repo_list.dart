import 'package:flutter_api/repos.dart';

class RepoList {
  List<Repository> repos;
  RepoList({required this.repos});

  factory RepoList.fromJson(List<dynamic> json) {
    List<Repository> repos = [];
    for (var repo in json) {
      repos.add(Repository.fromJson(repo));
    }
    return RepoList(repos: repos);
  }
}