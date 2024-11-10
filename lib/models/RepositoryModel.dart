class RepositoryModel {
  final String name;
  final String url;

  RepositoryModel({required this.name, required this.url});

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'],
      url: json['html_url'],
    );
  }
}