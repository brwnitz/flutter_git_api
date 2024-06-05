class Repository {
  final int id;
  final String name;
  final String url;
  final String html_url;

  Repository({
    required this.id,
    required this.name,
    required this.url,
    required this.html_url,
  });

    factory Repository.fromJson(Map<String, dynamic> json) {
      return Repository(
        id: json['id'],
        name: json['name'],
        url: json['url'],
        html_url: json['html_url'],
      );
    }
}