import 'package:flutter/material.dart';
import 'subject_details_screen.dart';

class VocationalClass9Screen extends StatefulWidget {
  const VocationalClass9Screen({super.key});

  @override
  State<VocationalClass9Screen> createState() => _VocationalClass9ScreenState();
}

class _VocationalClass9ScreenState extends State<VocationalClass9Screen> {
  bool _isDarkMode = false;
  bool _showNonDepartmentList = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _toggleNonDepartmentList() {
    setState(() {
      _showNonDepartmentList = !_showNonDepartmentList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'SmartKarigor',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Vocational Class 9',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _isDarkMode ? Colors.blue.shade200 : Colors.blue.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildNonDepartmentSection(_isDarkMode),
                const SizedBox(height: 24),
                _buildDepartmentSection(_isDarkMode),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNonDepartmentSection(bool isDarkMode) {
    final List<String> nonDepartmentSubjects = [
      'Bangla',
      'English',
      'Mathematics',
      'General Science',
      'Social Science',
      'Religion',
      'Information Technology',
      'Physical Education'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Non Department',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.category, size: 24),
                title: Text(
                  'Non Department Subjects',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                trailing: Icon(
                  _showNonDepartmentList ? Icons.expand_less : Icons.expand_more,
                  color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                onTap: _toggleNonDepartmentList,
              ),

              if (_showNonDepartmentList) ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: nonDepartmentSubjects.map((subject) => _buildSubjectListItem(
                      subject: subject,
                      isDarkMode: isDarkMode,
                    )).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectListItem({
    required String subject,
    required bool isDarkMode,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      leading: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        subject,
        style: TextStyle(
          fontSize: 14,
          color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
      ),
      onTap: () {
        _showSubjectDetails(subject, isDarkMode);
      },
    );
  }

  void _showSubjectDetails(String subject, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              subject,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getSubjectDescription(subject),
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubjectDetailsScreen(subjectName: subject),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Start Learning'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _getSubjectDescription(String subject) {
    switch (subject) {
      case 'Bangla':
        return 'Learn Bengali language, literature, and grammar. Develop reading, writing, and speaking skills.';
      case 'English':
        return 'Improve English language skills including grammar, vocabulary, reading, and communication.';
      case 'Mathematics':
        return 'Study basic mathematics including algebra, geometry, and arithmetic operations.';
      case 'General Science':
        return 'Explore physics, chemistry, biology and environmental science fundamentals.';
      case 'Social Science':
        return 'Learn about history, geography, civics, and social studies.';
      case 'Religion':
        return 'Study religious education and moral values.';
      case 'Information Technology':
        return 'Learn computer basics, software applications, and digital literacy.';
      case 'Physical Education':
        return 'Develop physical fitness, sports skills, and health education.';
      default:
        return 'General subject covering fundamental concepts and principles.';
    }
  }

  Widget _buildDepartmentSection(bool isDarkMode) {
    final List<Map<String, dynamic>> departmentItems = [
      {
        'title': 'IT Support and IOT Basics',
        'icon': Icons.computer,
        'color': Colors.blue,
        'description': 'Learn IT support and Internet of Things fundamentals'
      },
      {
        'title': 'Electrical Works',
        'icon': Icons.electrical_services,
        'color': Colors.orange,
        'description': 'Electrical systems and maintenance'
      },
      {
        'title': 'Welding and Fabrication',
        'icon': Icons.build,
        'color': Colors.red,
        'description': 'Welding techniques and metal fabrication'
      },
      {
        'title': 'Farm Machinery',
        'icon': Icons.agriculture,
        'color': Colors.green,
        'description': 'Agricultural machinery operation and maintenance'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Department',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.blue.shade200 : Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true, // ✅ এটি যোগ করুন
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.3,
          ),
          itemCount: departmentItems.length,
          itemBuilder: (context, index) {
            final item = departmentItems[index];
            return _buildDepartmentGridItem(
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              color: item['color'] as Color,
              description: item['description'] as String,
              isDarkMode: isDarkMode,
            );
          },
        ),
      ],
    );
  }

  Widget _buildDepartmentGridItem({
    required String title,
    required IconData icon,
    required Color color,
    required String description,
    required bool isDarkMode,
  }) {
    return Card(
      elevation: 3,
      color: isDarkMode ? Colors.grey.shade800 : Colors.white,
      child: InkWell(
        onTap: () {
          print('$title tapped');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}