import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/api_integration.dart';
import 'package:flutter_api/repo_list.dart';
import 'package:flutter_api/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ListagemRepositorios extends StatelessWidget {
  GitHubUser gitHubUser;
  RepoList repoList;
  ListagemRepositorios({super.key, required this.gitHubUser, required this.repoList});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Screen'),
      ),
      body:
      Container(
        color: Colors.yellowAccent,
        child: Column(
        children: <Widget>[
          Container(
          color: Colors.amber,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.35,
          child: Center(
            child: Image.network(gitHubUser.avatarUrl,width: MediaQuery.of(context).size.width*0.7,fit: BoxFit.cover),
          )),
          Column(
            children: <Widget>[
              Container(
                color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.1,
                child: Center(
                  child: Text(gitHubUser.name,style: const TextStyle(fontSize: 24),),
                )),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
            itemCount: repoList.repos.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  Text(repoList.repos[index].name),
                  TextButton(onPressed: () async {
                                    Uri url = Uri.parse(repoList.repos[index].html_url);
                  try {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    if (kDebugMode) {
                      print('Error launching URL: $e');
                    }
                  }
                },
                child: const Text('Abrir repositório'),)
                ] 
              );
            },
           ))
            )
        ],
      )),
    );
  }
}