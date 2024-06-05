import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_api/api_integration.dart';
import 'package:flutter_api/lista_repo.dart';
import 'package:flutter_api/repo_list.dart';
import 'package:flutter_api/user.dart';

class MyHomePage extends StatelessWidget{
  
  final HttpIntegration http = HttpIntegration('https://api.github.com');
  final TextEditingController userController = TextEditingController();
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width*0.7,
                child: TextField(
                controller: userController,
                style: const TextStyle(fontSize: 16,),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35)),
                  borderSide: BorderSide(color: Colors.grey, width: 1)),
                ),
              ),),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FutureBuilder<GitHubUser>(
                        future: http.fetchUser(userController.text),
                        builder: (BuildContext context, AsyncSnapshot<GitHubUser> userSnapshot) {
                          if (userSnapshot.hasData) {
                            return FutureBuilder<RepoList>(
                              future: http.fetchRepositories(userController.text),
                              builder: (BuildContext context, AsyncSnapshot<RepoList> repoSnapshot) {
                                if (repoSnapshot.hasData) {
                                  return ListagemRepositorios(
                                    gitHubUser: userSnapshot.data!,
                                    repoList: repoSnapshot.data!,
                                  );
                                } else if (repoSnapshot.hasError) {
                                  return Text('${repoSnapshot.error}');
                                }
                                return const Scaffold(
                            body: Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                              },
                            );
                          } else if (userSnapshot.hasError) {
                            return Text('${userSnapshot.error}');
                          }
                          return const Scaffold(
                            body: Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Buscar usuario'),
              ),
            ],
        ),
      ),
    )
    );
  }
  
}