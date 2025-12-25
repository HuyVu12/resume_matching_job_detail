import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/cores/my_router.dart';
import 'package:resume_matching_jd/view_models/tools_view_model.dart';

class ToolsView extends StatelessWidget {
  const ToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ToolsViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Công cụ hỗ trợ'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Section
                _buildTestCardsSection(context),
                const SizedBox(height: 24),

                // Tools List Section
                _buildToolsListSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Test Cards Section
  Widget _buildTestCardsSection(BuildContext context) {
    final vm = context.watch<ToolsViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trắc nghiệm',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            // MBTI Test Card
            _buildTestCard(
              title: 'Trắc nghiệm tính cách MBTI',
              subtitle: 'Khám phá phong cách làm việc của bạn',
              onTap: () {
                MyRouter().navigateToWebView(
                  context,
                  'Trắc nghiệm MBTI',
                  ToolsViewModel.mbtiTestUrl,
                );
              },
            ),
            const SizedBox(height: 16),

            // MI Test Card
            _buildTestCard(
              title: 'Trắc nghiệm đa trí thông minh MI',
              subtitle: 'Xác định những điểm mạnh của bạn',
              onTap: () {
                MyRouter().navigateToWebView(
                  context,
                  'Trắc nghiệm MI',
                  ToolsViewModel.miTestUrl,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  // Individual Test Card Widget
  Widget _buildTestCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8A8CFF),
            const Color(0xFF8A8CFF).withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A8CFF).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF8A8CFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Khám phá ngay',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tools List Section
  Widget _buildToolsListSection(BuildContext context) {
    final vm = context.watch<ToolsViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thêm công cụ - Thêm vượt trội',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.tools.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final tool = vm.tools[index];
            return _buildToolTile(
              icon: tool.icon,
              title: tool.title,
              onTap: () {
                MyRouter().navigateToWebView(
                  context,
                  tool.title,
                  tool.url,
                );
              },
            );
          },
        ),
      ],
    );
  }

  // Tool Tile Widget
  Widget _buildToolTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF8A8CFF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF8A8CFF),
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
