class JobModel {
  final int id;
  final int company_id;
  final String company_name;
  final String title;
  final String? logoUrl;
  final String? description;
  final String? requirements;
  final String? location;
  final String? job_type;
  final double? salaryMin;
  final double? salaryMax;
  final String? status;
  final String? benefits;
  final double? match_score;
  final String? file_path;

  JobModel({
    required this.id,
    required this.company_id,
    required this.title,
    required this.company_name,
    this.logoUrl,
    this.description,
    this.requirements,
    this.location,
    this.job_type,
    this.salaryMin,
    this.salaryMax,
    this.status,
    this.benefits,
    this.match_score,
    this.file_path,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      company_id: json['company_id'],
      company_name: json['company_name'],
      logoUrl: json['logo_url'],
      title: json['title'],
      description: json['description'],
      requirements: json['requirements'],
      location: json['location'],
      job_type: json['job_type'],
      salaryMin: json['salary_min']?.toDouble(),
      salaryMax: json['salary_max']?.toDouble(),
      status: json['status'],
      benefits: json['benefits'],
      match_score: json['match_score']?.toDouble(),
    );
  }
}
