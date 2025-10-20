import 'package:flutter/material.dart';
import 'subject_details_screen.dart';

class VocationalClass11Screen extends StatefulWidget {
  const VocationalClass11Screen({super.key});

  @override
  State<VocationalClass11Screen> createState() => _VocationalClass11ScreenState();
}

class _VocationalClass11ScreenState extends State<VocationalClass11Screen> {
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
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
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
                    'Vocational Class 11',
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 0) {
              Navigator.pop(context);
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'My-Note',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'My Course',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNonDepartmentSection(bool isDarkMode) {
    final List<String> nonDepartmentSubjects = [
      'Bangla',
      'English',
      'Mathematics',
      'Physics',
      'Chemistry',
      'Biology',
      'Social Science',
      'Information Technology'
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
          color: Colors.orange,
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
                  backgroundColor: Colors.orange,
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
        return 'Class 11 advanced Bengali literature, poetry, and composition.';
      case 'English':
        return 'Advanced English literature, writing skills, and communication.';
      case 'Mathematics':
        return 'Higher mathematics including calculus, statistics, and advanced algebra.';
      case 'Physics':
        return 'Advanced physics including mechanics, electricity, and modern physics.';
      case 'Chemistry':
        return 'Organic and inorganic chemistry, chemical reactions, and laboratory work.';
      case 'Biology':
        return 'Advanced biology including genetics, ecology, and human physiology.';
      case 'Social Science':
        return 'Economics, sociology, and advanced social studies.';
      case 'Information Technology':
        return 'Programming, database management, and advanced IT skills.';
      default:
        return 'Class 11 specialized subject with advanced curriculum.';
    }
  }

  Widget _buildDepartmentSection(bool isDarkMode) {
    final List<Map<String, dynamic>> departmentItems = [
      {
        'title': 'Software Development',
        'icon': Icons.code,
        'color': Colors.blue,
        'description': 'Programming and software development basics'
      },
      {
        'title': 'Electronics Engineering',
        'icon': Icons.electrical_services,
        'color': Colors.purple,
        'description': 'Electronics and circuit design'
      },
      {
        'title': 'Mechanical Workshop',
        'icon': Icons.build,
        'color': Colors.red,
        'description': 'Mechanical tools and workshop practice'
      },
      {
        'title': 'Automotive Technology',
        'icon': Icons.directions_car,
        'color': Colors.green,
        'description': 'Automobile mechanics and technology'
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