import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'vocational_class9_screen.dart';
import 'vocational_class10_screen.dart';
import 'vocational_class11_screen.dart';
import 'vocational_class12_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // State variables for profile features
  String _selectedLanguage = 'English';

  // Current active screen for home content
  Widget _currentHomeScreen = const HomeContentScreen();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _openProfileDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No new notifications'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _showComingSoon(String featureName) {
    Navigator.pop(context); // Close drawer first
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName - Coming Soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Course Enrollment Function
  void _showCourseEnrollment() {
    Navigator.pop(context); // Close drawer
    setState(() {
      _currentHomeScreen = const CourseEnrollmentScreen();
      _currentIndex = 0;
    });
  }

  // Show Attended Exam List
  void _showAttendedExamList() {
    Navigator.pop(context); // Close drawer
    setState(() {
      _currentHomeScreen = const AttendedExamListScreen();
      _currentIndex = 0;
    });
  }

  // Show Downloaded PDF List
  void _showDownloadedPdfList() {
    Navigator.pop(context); // Close drawer
    setState(() {
      _currentHomeScreen = const DownloadedPdfListScreen();
      _currentIndex = 0;
    });
  }

  // Show Downloaded Video List
  void _showDownloadedVideoList() {
    Navigator.pop(context); // Close drawer
    setState(() {
      _currentHomeScreen = const DownloadedVideoListScreen();
      _currentIndex = 0;
    });
  }

  // Change Password Function
  void _showChangePassword() {
    Navigator.pop(context); // Close drawer
    setState(() {
      _currentHomeScreen = const ChangePasswordScreen();
      _currentIndex = 0;
    });
  }

  // Change Language Function
  void _showChangeLanguage() {
    Navigator.pop(context); // Close drawer
    setState(() {
      _currentHomeScreen = ChangeLanguageScreen(
        selectedLanguage: _selectedLanguage,
        onLanguageChanged: (language) {
          setState(() {
            _selectedLanguage = language;
          });
        },
      );
      _currentIndex = 0;
    });
  }

  // Logout Function
  void _logout() {
    Navigator.pop(context); // Close drawer
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _openDrawer,
          ),
          title: const Text(
            'Smart Karigor',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleTheme,
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: _showNotifications,
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: _openProfileDrawer,
            ),
          ],
        ),
        drawer: _buildMainDrawer(),
        endDrawer: _buildProfileDrawer(), // এখানে endDrawer ব্যবহার করছি
        body: _currentHomeScreen,
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          // Reset to home content when navigating through bottom nav
          if (index == 0) {
            _currentHomeScreen = const HomeContentScreen();
          } else {
            // For other tabs, show their respective screens
            switch (index) {
              case 1:
                _currentHomeScreen = const LibraryScreen();
                break;
              case 2:
                _currentHomeScreen = const RoutineScreen();
                break;
              case 3:
                _currentHomeScreen = const SearchScreen();
                break;
              case 4:
                _currentHomeScreen = const JobCircularScreen();
                break;
            }
          }
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_outlined),
          activeIcon: Icon(Icons.library_books),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule_outlined),
          activeIcon: Icon(Icons.schedule),
          label: 'Routine',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline),
          activeIcon: Icon(Icons.work),
          label: 'Job Circular',
        ),
      ],
    );
  }

  Widget _buildMainDrawer() {
    return Drawer(
      child: Column(
        children: [
          // Header Section
          _buildDrawerHeader(),

          // Main Menu Sections
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Vocational Education
                _buildDrawerSection(
                  title: 'Vocational Education',
                  icon: Icons.school,
                  children: [
                    _buildDrawerItem(
                      title: 'Class 9',
                      onTap: () => _navigateTo(const VocationalClass9Screen()),
                    ),
                    _buildDrawerItem(
                      title: 'Class 10',
                      onTap: () => _navigateTo(const VocationalClass10Screen()),
                    ),
                    _buildDrawerItem(
                      title: 'Class 11',
                      onTap: () => _navigateTo(const VocationalClass11Screen()),
                    ),
                    _buildDrawerItem(
                      title: 'Class 12',
                      onTap: () => _navigateTo(const VocationalClass12Screen()),
                    ),
                  ],
                ),

                // Diploma Education
                _buildDrawerSection(
                  title: 'Diploma Education',
                  icon: Icons.engineering,
                  children: [
                    _buildDrawerItem(
                      title: 'Computer Technology',
                      onTap: () => _showComingSoon('Computer Technology'),
                    ),
                    _buildDrawerItem(
                      title: 'Electrical Technology',
                      onTap: () => _showComingSoon('Electrical Technology'),
                    ),
                    _buildDrawerItem(
                      title: 'Civil Technology',
                      onTap: () => _showComingSoon('Civil Technology'),
                    ),
                    _buildDrawerItem(
                      title: 'Mechanical Technology',
                      onTap: () => _showComingSoon('Mechanical Technology'),
                    ),
                    _buildDrawerItem(
                      title: 'Architecture Technology',
                      onTap: () => _showComingSoon('Architecture Technology'),
                    ),
                  ],
                ),

                // Job Preparation
                _buildDrawerSection(
                  title: 'Job Preparation',
                  icon: Icons.work,
                  children: [
                    _buildDrawerSubSection('Junior Instructor'),
                    _buildDrawerItem(
                      title: 'Electrical Junior Instructor',
                      onTap: () => _showComingSoon('Electrical Junior Instructor'),
                    ),
                    _buildDrawerItem(
                      title: 'Computer Junior Instructor',
                      onTap: () => _showComingSoon('Computer Junior Instructor'),
                    ),
                    _buildDrawerItem(
                      title: 'Mechanical Junior Instructor',
                      onTap: () => _showComingSoon('Mechanical Junior Instructor'),
                    ),
                    _buildDrawerSubSection('Non Cadre'),
                    _buildDrawerItem(
                      title: 'Office Assistant',
                      onTap: () => _showComingSoon('Office Assistant'),
                    ),
                    _buildDrawerItem(
                      title: 'Data Entry Operator',
                      onTap: () => _showComingSoon('Data Entry Operator'),
                    ),
                    _buildDrawerItem(
                      title: 'Technical Assistant',
                      onTap: () => _showComingSoon('Technical Assistant'),
                    ),
                  ],
                ),

                // Settings & Help
                const Divider(),
                _buildDrawerListItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () => _showComingSoon('Settings'),
                ),
                _buildDrawerListItem(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () => _showComingSoon('Help & Support'),
                ),
                _buildDrawerListItem(
                  icon: Icons.info_outline,
                  title: 'About App',
                  onTap: () => _showComingSoon('About App'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: [
          // Profile Header
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade700,
                  Colors.blue.shade500,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.blue),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'User ID: SK2024001',
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'john.doe@smartkarigor.com',
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Profile Options
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildProfileSectionTitle('ACCOUNT'),
                _buildProfileItem(
                  icon: Icons.school,
                  title: 'Course Enrollment',
                  onTap: _showCourseEnrollment,
                ),
                _buildProfileItem(
                  icon: Icons.assignment,
                  title: 'Attended Exam List',
                  onTap: _showAttendedExamList,
                ),
                _buildProfileItem(
                  icon: Icons.picture_as_pdf,
                  title: 'Downloaded PDF List',
                  onTap: _showDownloadedPdfList,
                ),
                _buildProfileItem(
                  icon: Icons.video_library,
                  title: 'Downloaded Video List',
                  onTap: _showDownloadedVideoList,
                ),

                const SizedBox(height: 16),
                _buildProfileSectionTitle('SETTINGS'),
                _buildProfileItem(
                  icon: Icons.lock,
                  title: 'Change Password',
                  onTap: _showChangePassword,
                ),
                _buildProfileItem(
                  icon: Icons.language,
                  title: 'Change Language',
                  onTap: _showChangeLanguage,
                ),

                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton.icon(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade700,
            Colors.blue.shade500,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.school,
                size: 36,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Smart Karigor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Education Platform',
              style: TextStyle(
                color: Colors.white.withAlpha(180),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue.shade700,
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildDrawerSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: Icon(
        icon,
        color: Colors.blue.shade700,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      children: children,
    );
  }

  Widget _buildDrawerItem({
    required String title,
    IconData? icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: icon != null
          ? Icon(
        icon,
        size: 20,
        color: Colors.grey.shade700,
      )
          : const SizedBox(width: 20),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade800,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 40, right: 16),
      visualDensity: const VisualDensity(vertical: -4),
      onTap: onTap,
    );
  }

  Widget _buildDrawerListItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey.shade700,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildDrawerSubSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 12, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.blue.shade700,
          fontSize: 13,
        ),
      ),
    );
  }
}


// Course Enrollment Screen
class CourseEnrollmentScreen extends StatelessWidget {
  const CourseEnrollmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course Enrollment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Fill out the form to enroll in your desired course',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Course',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                items: [
                  'Vocational Class 9',
                  'Vocational Class 10',
                  'Vocational Class 11',
                  'Vocational Class 12',
                  'Computer Basic Training',
                  'Web Design',
                  'Web Development',
                  'App Development',
                ].map((String course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Course enrollment submitted successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Enroll Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Attended Exam List Screen
class AttendedExamListScreen extends StatelessWidget {
  const AttendedExamListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample exam data
    List<Map<String, dynamic>> exams = [
      {
        'title': 'Mathematics Midterm Exam',
        'date': '2024-01-15',
        'score': '85%',
        'status': 'Completed'
      },
      {
        'title': 'English Final Exam',
        'date': '2024-01-20',
        'score': '78%',
        'status': 'Completed'
      },
      {
        'title': 'Science Quiz',
        'date': '2024-01-25',
        'score': '92%',
        'status': 'Completed'
      },
      {
        'title': 'Computer Basic Test',
        'date': '2024-02-01',
        'score': 'Pending',
        'status': 'Upcoming'
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attended Exam List',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'View all your exam results and upcoming tests',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  final exam = exams[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(
                        exam['status'] == 'Completed' ? Icons.assignment_turned_in : Icons.assignment,
                        color: exam['status'] == 'Completed' ? Colors.green : Colors.orange,
                        size: 32,
                      ),
                      title: Text(
                        exam['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text('Date: ${exam['date']}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            exam['score'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: exam['score'] == 'Pending' ? Colors.orange : Colors.green,
                            ),
                          ),
                          Text(
                            exam['status'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Downloaded PDF List Screen
class DownloadedPdfListScreen extends StatelessWidget {
  const DownloadedPdfListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample PDF data
    List<Map<String, dynamic>> pdfs = [
      {
        'title': 'Mathematics Chapter 1',
        'size': '2.5 MB',
        'downloadDate': '2024-01-15'
      },
      {
        'title': 'English Grammar Guide',
        'size': '1.8 MB',
        'downloadDate': '2024-01-18'
      },
      {
        'title': 'Science Lab Manual',
        'size': '3.2 MB',
        'downloadDate': '2024-01-20'
      },
      {
        'title': 'Computer Basics PDF',
        'size': '4.1 MB',
        'downloadDate': '2024-01-25'
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Downloaded PDF List',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Access all your downloaded study materials',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pdfs.length,
                itemBuilder: (context, index) {
                  final pdf = pdfs[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 32),
                      title: Text(
                        pdf['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Size: ${pdf['size']}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pdf['downloadDate'],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          IconButton(
                            icon: const Icon(Icons.open_in_new, size: 20),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Opening ${pdf['title']}'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Downloaded Video List Screen
class DownloadedVideoListScreen extends StatelessWidget {
  const DownloadedVideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample video data
    List<Map<String, dynamic>> videos = [
      {
        'title': 'Mathematics Lecture 1',
        'duration': '25:30',
        'downloadDate': '2024-01-16'
      },
      {
        'title': 'English Speaking Practice',
        'duration': '18:45',
        'downloadDate': '2024-01-19'
      },
      {
        'title': 'Science Experiment Guide',
        'duration': '32:15',
        'downloadDate': '2024-01-22'
      },
      {
        'title': 'Web Development Tutorial',
        'duration': '45:20',
        'downloadDate': '2024-01-28'
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Downloaded Video List',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Watch your downloaded video lectures',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.video_library, color: Colors.red, size: 32),
                      title: Text(
                        video['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Duration: ${video['duration']}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            video['downloadDate'],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          IconButton(
                            icon: const Icon(Icons.play_arrow, size: 20),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Playing ${video['title']}'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Change Password Screen
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Update your account password securely',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_reset),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password changed successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Update Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Change Language Screen
class ChangeLanguageScreen extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageChanged;

  const ChangeLanguageScreen({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Language',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select your preferred language',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              child: RadioListTile<String>(
                title: const Text(
                  'English',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                value: 'English',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  onLanguageChanged(value!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Language changed to English'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: RadioListTile<String>(
                title: const Text(
                  'বাংলা',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                value: 'Bangla',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  onLanguageChanged(value!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('ভাষা বাংলাতে পরিবর্তন করা হয়েছে'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Home Content Screen (Previous implementation remains same)
class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  void _navigateToClass(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(),
                  const SizedBox(height: 24),
                  _buildStudySection(context),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildDiplomaEngineeringSection(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildJobPreparationSection(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildAdmissionSection(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTrainingSection(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade100,
              child: Icon(
                Icons.school,
                size: 32,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Smart Karigor!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Start your learning journey today',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudySection(BuildContext context) {
    final List<Map<String, dynamic>> studyItems = [
      {
        'title': 'Class 9',
        'icon': Icons.school,
        'color': Colors.blue,
        'students': '120 Students',
        'screen': const VocationalClass9Screen(),
      },
      {
        'title': 'Class 10',
        'icon': Icons.school,
        'color': Colors.green,
        'students': '98 Students',
        'screen': const VocationalClass10Screen(),
      },
      {
        'title': 'Class 11',
        'icon': Icons.school,
        'color': Colors.orange,
        'students': '85 Students',
        'screen': const VocationalClass11Screen(),
      },
      {
        'title': 'Class 12',
        'icon': Icons.school,
        'color': Colors.purple,
        'students': '76 Students',
        'screen': const VocationalClass12Screen(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vocational Classes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose your class to explore subjects',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.1,
          ),
          itemCount: studyItems.length,
          itemBuilder: (context, index) {
            final item = studyItems[index];
            return _buildStudyGridItem(
              context: context,
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              color: item['color'] as Color,
              students: item['students'] as String,
              screen: item['screen'] as Widget,
            );
          },
        ),
      ],
    );
  }

  Widget _buildStudyGridItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required String students,
    required Widget screen,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _navigateToClass(context, screen),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                students,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiplomaEngineeringSection() {
    final List<Map<String, dynamic>> diplomaItems = [
      {
        'title': 'Civil Technology',
        'icon': Icons.architecture,
        'color': Colors.brown,
        'students': '150 Students',
      },
      {
        'title': 'Electrical Technology',
        'icon': Icons.electrical_services,
        'color': Colors.amber,
        'students': '145 Students',
      },
      {
        'title': 'Mechanical Technology',
        'icon': Icons.settings,
        'color': Colors.deepOrange,
        'students': '138 Students',
      },
      {
        'title': 'Computer Technology',
        'icon': Icons.computer,
        'color': Colors.indigo,
        'students': '165 Students',
      },
      {
        'title': 'Electronics Technology',
        'icon': Icons.memory,
        'color': Colors.purple,
        'students': '125 Students',
      },
      {
        'title': 'Chemical Technology',
        'icon': Icons.science,
        'color': Colors.green,
        'students': '110 Students',
      },
      {
        'title': 'Textile Technology',
        'icon': Icons.palette,
        'color': Colors.pink,
        'students': '98 Students',
      },
      {
        'title': 'Automobile Technology',
        'icon': Icons.directions_car,
        'color': Colors.red,
        'students': '105 Students',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Diploma Engineering',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Explore various engineering technologies',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.1,
          ),
          itemCount: diplomaItems.length,
          itemBuilder: (context, index) {
            final item = diplomaItems[index];
            return _buildDiplomaGridItem(
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              color: item['color'] as Color,
              students: item['students'] as String,
            );
          },
        ),
      ],
    );
  }

  Widget _buildDiplomaGridItem({
    required String title,
    required IconData icon,
    required Color color,
    required String students,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                students,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobPreparationSection() {
    final List<Map<String, dynamic>> jobItems = [
      {
        'title': 'SAE Job Preparation',
        'icon': Icons.engineering,
        'color': Colors.blue.shade700,
        'description': 'Sub Assistant Engineer'
      },
      {
        'title': 'AE Job Preparation',
        'icon': Icons.architecture,
        'color': Colors.green.shade700,
        'description': 'Assistant Engineer'
      },
      {
        'title': 'BCS MCQ Solution',
        'icon': Icons.assignment,
        'color': Colors.orange.shade700,
        'description': 'Bangladesh Civil Service'
      },
      {
        'title': 'NTRCA MCQ Solution',
        'icon': Icons.school,
        'color': Colors.purple.shade700,
        'description': 'Non-Govt Teachers'
      },
      {
        'title': 'BUET Pattern MCQ',
        'icon': Icons.science,
        'color': Colors.red.shade700,
        'description': 'Engineering University'
      },
      {
        'title': 'Junior Instructor',
        'icon': Icons.work,
        'color': Colors.teal.shade700,
        'description': 'Technical Instructor'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Job Preparation',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Prepare for various job exams',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.3,
          ),
          itemCount: jobItems.length,
          itemBuilder: (context, index) {
            final item = jobItems[index];
            return _buildJobGridItem(
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              color: item['color'] as Color,
              description: item['description'] as String,
            );
          },
        ),
      ],
    );
  }

  Widget _buildJobGridItem({
    required String title,
    required IconData icon,
    required Color color,
    required String description,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
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

  // New Admission Section
  Widget _buildAdmissionSection() {
    final List<Map<String, dynamic>> admissionItems = [
      {
        'title': 'DUET Admission',
        'icon': Icons.school,
        'color': Colors.deepPurple,
        'description': 'Dhaka University of Engineering'
      },
      {
        'title': 'Narail Engineering Admission',
        'icon': Icons.engineering,
        'color': Colors.teal,
        'description': 'Narail Polytechnic Institute'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Admission Section',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Get admission guidance for engineering institutes',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.3,
          ),
          itemCount: admissionItems.length,
          itemBuilder: (context, index) {
            final item = admissionItems[index];
            return _buildAdmissionGridItem(
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              color: item['color'] as Color,
              description: item['description'] as String,
            );
          },
        ),
      ],
    );
  }

  Widget _buildAdmissionGridItem({
    required String title,
    required IconData icon,
    required Color color,
    required String description,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
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

  // New Training Section
  Widget _buildTrainingSection() {
    final List<Map<String, dynamic>> trainingItems = [
      {
        'title': 'Computer Basic Training',
        'icon': Icons.computer,
        'color': Colors.blue,
        'description': 'Learn computer fundamentals'
      },
      {
        'title': 'Web Design',
        'icon': Icons.web,
        'color': Colors.green,
        'description': 'HTML, CSS, JavaScript'
      },
      {
        'title': 'Web Development',
        'icon': Icons.code,
        'color': Colors.orange,
        'description': 'Full-stack development'
      },
      {
        'title': 'App Development',
        'icon': Icons.phone_android,
        'color': Colors.purple,
        'description': 'Mobile app development'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Training Section',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enhance your skills with professional training',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.3,
          ),
          itemCount: trainingItems.length,
          itemBuilder: (context, index) {
            final item = trainingItems[index];
            return _buildTrainingGridItem(
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              color: item['color'] as Color,
              description: item['description'] as String,
            );
          },
        ),
      ],
    );
  }

  Widget _buildTrainingGridItem({
    required String title,
    required IconData icon,
    required Color color,
    required String description,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
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

// Other screens (Library, Routine, Search, Job Circular) remain the same
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.library_books, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Library',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Access your study materials and books',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Class Routine',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'View your class schedule',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search courses, subjects, notes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 32),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Search for Content',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find courses, subjects, and study materials',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobCircularScreen extends StatelessWidget {
  const JobCircularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Job Circulars',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Find latest job opportunities',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}