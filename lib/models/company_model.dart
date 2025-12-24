class CompanyModel {
  final int id;
  final String name;
  final String description;
  final String? logo_url;
  final String? website;
  final String? address;

  CompanyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logo_url,
    required this.website,
    required this.address,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      logo_url: json['logo_url'],
      description: json['description'],
      website: json['website'],
      address: json['address'],
    );
  }
}
