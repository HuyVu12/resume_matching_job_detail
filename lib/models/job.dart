class Job {
  final String? id;
  final String title;
  final String company;
  final String salary;
  final String location;
  final String logoUrl;

  Job({
    this.id,
    required this.title,
    required this.company,
    required this.salary,
    required this.location,
    required this.logoUrl,
  });

  factory Job.fromMap(String id, Map<String, dynamic> data) {
    return Job(
      id: id,
      title: data['title'] ?? '',
      company: data['company'] ?? '',
      salary: data['salary'] ?? '',
      location: data['location'] ?? '',
      logoUrl: data['logoUrl'] ?? '',
    );
  }
}
