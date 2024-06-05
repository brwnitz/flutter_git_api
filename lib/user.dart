class GitHubUser {
  final String login;
  final int id;
  final String avatarUrl;
  final String name;
  final String bio;

  GitHubUser({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.name,
    required this.bio,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],
      name: json['name'],
      bio: json['bio'],
    );
  }
}