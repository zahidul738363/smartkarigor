import 'package:flutter/material.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final String subjectName;

  const SubjectDetailsScreen({
    super.key,
    required this.subjectName,
  });

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  bool _isDarkMode = false;
  int _selectedTab = 0;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.subjectName,
          style: const TextStyle(
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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
              border: Border(
                bottom: BorderSide(
                  color: _isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
              ),
            ),
            child: Row(
              children: [
                _buildTab(0, 'PDF Materials', Icons.picture_as_pdf),
                _buildTab(1, 'Videos', Icons.video_library),
                _buildTab(2, 'Quizzes', Icons.quiz),
              ],
            ),
          ),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String title, IconData icon) {
    return Expanded(
      child: Material(
        color: _selectedTab == index
            ? (_isDarkMode ? Colors.blue.shade800 : Colors.blue.shade100)
            : Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedTab = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: _selectedTab == index
                      ? (_isDarkMode ? Colors.blue.shade200 : Colors.blue.shade700)
                      : (_isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: _selectedTab == index ? FontWeight.bold : FontWeight.normal,
                    color: _selectedTab == index
                        ? (_isDarkMode ? Colors.blue.shade200 : Colors.blue.shade700)
                        : (_isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildPdfMaterials();
      case 1:
        return _buildVideos();
      case 2:
        return _buildQuizzes();
      default:
        return _buildPdfMaterials();
    }
  }

  Widget _buildPdfMaterials() {
    final List<Map<String, dynamic>> pdfMaterials = [
      {
        'title': '${widget.subjectName} Chapter 1',
        'size': '2.5 MB',
        'pages': 15,
        'uploadDate': '2024-01-15',
        'downloads': 245,
      },
      {
        'title': '${widget.subjectName} Chapter 2',
        'size': '3.1 MB',
        'pages': 20,
        'uploadDate': '2024-01-20',
        'downloads': 189,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pdfMaterials.length,
      itemBuilder: (context, index) {
        final pdf = pdfMaterials[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: _isDarkMode ? Colors.grey.shade800 : Colors.white,
          elevation: 2,
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
                size: 24,
              ),
            ),
            title: Text(
              pdf['title'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${pdf['size']} • ${pdf['pages']} Pages',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              color: Colors.blue,
              onPressed: () {
                _downloadPdf(pdf['title'] as String);
              },
            ),
            onTap: () {
              _viewPdf(pdf['title'] as String);
            },
          ),
        );
      },
    );
  }

  Widget _buildVideos() {
    final List<Map<String, dynamic>> videos = [
      {
        'title': '${widget.subjectName} Introduction',
        'duration': '15:30',
        'views': 1245,
        'uploadDate': '2024-01-10',
        'instructor': 'Dr. Rahman',
      },
      {
        'title': '${widget.subjectName} Chapter 1 Explanation',
        'duration': '25:45',
        'views': 892,
        'uploadDate': '2024-01-12',
        'instructor': 'Prof. Ahmed',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: _isDarkMode ? Colors.grey.shade800 : Colors.white,
          elevation: 2,
          child: Column(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: _isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 60,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          video['duration'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: _isDarkMode ? Colors.white : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 14,
                          color: _isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          video['instructor'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: _isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 14,
                          color: _isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${video['views']} views',
                          style: TextStyle(
                            fontSize: 12,
                            color: _isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _playVideo(video['title'] as String);
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Watch Video'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuizzes() {
    final List<Map<String, dynamic>> quizzes = [
      {
        'title': '${widget.subjectName} Chapter 1 Quiz',
        'questions': 15,
        'time': '20 mins',
        'difficulty': 'Easy',
        'attempts': 567,
        'averageScore': '75%',
      },
      {
        'title': '${widget.subjectName} Chapter 2 Quiz',
        'questions': 20,
        'time': '30 mins',
        'difficulty': 'Medium',
        'attempts': 423,
        'averageScore': '65%',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        final quiz = quizzes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: _isDarkMode ? Colors.grey.shade800 : Colors.white,
          elevation: 2,
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.quiz,
                color: Colors.orange,
                size: 24,
              ),
            ),
            title: Text(
              quiz['title'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildQuizInfo(Icons.question_answer, '${quiz['questions']} Questions'),
                    const SizedBox(width: 12),
                    _buildQuizInfo(Icons.timer, quiz['time'] as String),
                  ],
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                _startQuiz(quiz['title'] as String);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Start'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuizInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12),
        const SizedBox(width: 2),
        Text(text, style: const TextStyle(fontSize: 10)),
      ],
    );
  }

  void _downloadPdf(String pdfName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading $pdfName...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _viewPdf(String pdfName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $pdfName...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _playVideo(String videoName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Playing $videoName...'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _startQuiz(String quizName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting $quizName...'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}