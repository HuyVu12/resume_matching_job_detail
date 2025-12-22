import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String salary;
  final String location;
  final String logoUrl;
  final String? jobType;

  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.salary,
    required this.location,
    required this.logoUrl,
    required this.jobType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 10,
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(8),
              image: logoUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(logoUrl),
                      fit: BoxFit.contain,
                    )
                  : null,
            ),
            child: logoUrl.isEmpty
                ? Icon(Icons.business, color: Colors.grey.shade400)
                : null,
          ),

          // Nội dung
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  company,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const SizedBox(height: 8),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _tag(salary),
                      const SizedBox(width: 6),
                      _tag(location),
                      const SizedBox(width: 6),
                      _tag(jobType ?? "Không xác định"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Icon Favorite
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.favorite_border, color: Colors.green.shade400),
          // ),
        ],
      ),
    );
  }

  Widget _tag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(text, style: const TextStyle(fontSize: 12)),
  );
}
