
import 'package:flutter/material.dart';

void main() {
  runApp(const UniversalDownloader());
}

class UniversalDownloader extends StatelessWidget {
  const UniversalDownloader({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Universal Video Downloader',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1769FF),
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController linkController =
      TextEditingController();

  String platform = '';
  String message = 'Paste your video link here';

  final Map<String, List<String>> platforms = {
    'Facebook': ['facebook.com', 'fb.watch'],
    'TikTok': ['tiktok.com', 'vm.tiktok.com'],
    'Instagram': ['instagram.com'],
    'Telegram': ['t.me', 'telegram.me'],
    'X (Twitter)': ['x.com', 'twitter.com'],
    'YouTube': ['youtube.com', 'youtu.be'],
  };

  void detectPlatform() {
    final input = linkController.text.trim();
    final uri = Uri.tryParse(input);

    if (uri == null ||
        !uri.hasAuthority ||
        !(uri.scheme == 'https' || uri.scheme == 'http')) {
      setState(() {
        platform = '';
        message = 'Please enter a valid video URL';
      });
      return;
    }

    final host = uri.host.toLowerCase();

    String detected = '';

    for (final entry in platforms.entries) {
      if (entry.value.any((domain) =>
          host == domain || host.endsWith('.$domain'))) {
        detected = entry.key;
        break;
      }
    }

    setState(() {
      platform = detected;
      message = detected.isEmpty
          ? 'This platform is not supported yet'
          : 'Platform detected: $detected';
    });
  }

  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  Widget platformCard(String name, IconData icon) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 8),
            Text(name,
                style: const TextStyle(
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1769FF),
        foregroundColor: Colors.white,
        title: const Text(
          'Universal Downloader',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 15),

              const Icon(
                Icons.cloud_download_rounded,
                size: 75,
                color: Color(0xFF1769FF),
              ),

              const SizedBox(height: 12),

              const Text(
                'Universal Video Downloader',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Download and save videos you are authorized to access',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              const Text(
                'Paste Video Link',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: linkController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: 'https://example.com/video',
                  prefixIcon: const Icon(Icons.link),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: detectPlatform,
                  icon: const Icon(Icons.search),
                  label: const Text(
                    'DETECT VIDEO PLATFORM',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1769FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                        size: 30,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (platform.isNotEmpty)
                        Text(
                          platform,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Supported Platforms',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  platformCard('Facebook', Icons.facebook),
                  platformCard('TikTok', Icons.music_note),
                  platformCard('Instagram', Icons.camera_alt),
                  platformCard('Telegram', Icons.send),
                  platformCard('X', Icons.alternate_email),
                  platformCard('YouTube', Icons.play_circle),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Universal Video Downloader © 2026',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
