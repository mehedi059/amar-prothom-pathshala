import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PathshalaApp());

class PathshalaApp extends StatelessWidget {
  const PathshalaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'আমার প্রথম পাঠশালা',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C8D45)),
        scaffoldBackgroundColor: const Color(0xFFFFF9EE),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class Lesson {
  final String title;
  final String subtitle;
  final String symbol;
  final Color color;
  final String language;
  final String? audio;
  final String? rhyme;

  const Lesson({
    required this.title,
    required this.subtitle,
    required this.symbol,
    required this.color,
    required this.language,
    this.audio,
    this.rhyme,
  });
}

class Subject {
  final String title;
  final String subtitle;
  final String emoji;
  final Color color;
  final List<Lesson> lessons;

  const Subject(this.title, this.subtitle, this.emoji, this.color, this.lessons);
}

final subjects = <Subject>[
  Subject('বাংলা বর্ণমালা', 'স্বরবর্ণ, ব্যঞ্জনবর্ণ ও শব্দ', 'অ', const Color(0xFFFFE0B2), const [
    Lesson(title: 'অ', subtitle: 'অজগর', symbol: '🐍', color: Color(0xFFFFE0B2), language: 'bn', audio: 'bn/অ.mp3', rhyme: 'অ-তে অজগর, লম্বা তার গা,\\nবনের পথে চলে সে, ধীরে ধীরে বা।'),
    Lesson(title: 'আ', subtitle: 'আম', symbol: '🥭', color: Color(0xFFFFF0B3), language: 'bn', audio: 'bn/আ.mp3', rhyme: 'আ-তে আম, মিষ্টি তার ঘ্রাণ,\\nগ্রীষ্মকালে খেতে লাগে, ভীষণ মজার টান।'),
    Lesson(title: 'ই', subtitle: 'ইঁদুর', symbol: '🐭', color: Color(0xFFE1F5FE), language: 'bn', audio: 'bn/ই.mp3', rhyme: 'ই-তে ইঁদুর ছোট্ট ভাই,\\nদৌড়ে বেড়ায় এদিক-ওদিক তাই।'),
    Lesson(title: 'ঈ', subtitle: 'ঈগল', symbol: '🦅', color: Color(0xFFE8EAF6), language: 'bn', audio: 'bn/ঈ.mp3'),
    Lesson(title: 'উ', subtitle: 'উট', symbol: '🐪', color: Color(0xFFFFE0B2), language: 'bn', audio: 'bn/উ.mp3'),
    Lesson(title: 'ঊ', subtitle: 'ঊষা', symbol: '🌅', color: Color(0xFFFFF9C4), language: 'bn', audio: 'bn/ঊ.mp3'),
    Lesson(title: 'ক', subtitle: 'কলা', symbol: '🍌', color: Color(0xFFFFF9C4), language: 'bn', audio: 'bn/ক.mp3', rhyme: 'ক-তে কলা, হলুদ তার রং,\\nখেতে মজা, শক্তি দেয় ঢং।'),
    Lesson(title: 'খ', subtitle: 'খরগোশ', symbol: '🐰', color: Color(0xFFF3E5F5), language: 'bn', audio: 'bn/খ.mp3'),
    Lesson(title: 'গ', subtitle: 'গরু', symbol: '🐄', color: Color(0xFFE8F5E9), language: 'bn', audio: 'bn/গ.mp3'),
    Lesson(title: 'ঘ', subtitle: 'ঘড়ি', symbol: '⏰', color: Color(0xFFE0F7FA), language: 'bn', audio: 'bn/ঘ.mp3'),
  ]),
  Subject('English Alphabet', 'Letters, words and sounds', 'A', const Color(0xFFDDEBFF), const [
    Lesson(title: 'A a', subtitle: 'Apple', symbol: '🍎', color: Color(0xFFFFE0E0), language: 'en', audio: 'en/a.mp3', rhyme: 'A for Apple, red and sweet,\\nA lovely fruit for us to eat.'),
    Lesson(title: 'B b', subtitle: 'Ball', symbol: '⚽', color: Color(0xFFE3F2FD), language: 'en', audio: 'en/b.mp3'),
    Lesson(title: 'C c', subtitle: 'Cat', symbol: '🐱', color: Color(0xFFFFF3E0), language: 'en', audio: 'en/c.mp3'),
    Lesson(title: 'D d', subtitle: 'Duck', symbol: '🦆', color: Color(0xFFE8F5E9), language: 'en', audio: 'en/d.mp3'),
    Lesson(title: 'E e', subtitle: 'Elephant', symbol: '🐘', color: Color(0xFFF3E5F5), language: 'en', audio: 'en/e.mp3'),
  ]),
  Subject('প্রাথমিক গণিত', 'সংখ্যা, যোগ-বিয়োগ ও আকৃতি', '🔢', const Color(0xFFE1F5E8), const [
    Lesson(title: '১', subtitle: 'একটি আপেল', symbol: '🍎', color: Color(0xFFFFE0E0), language: 'bn', rhyme: 'একটি আপেল, লাল টুকটুকে,\\nগুনতে শিখি মজা করে।'),
    Lesson(title: '২', subtitle: 'দুটি প্রজাপতি', symbol: '🦋🦋', color: Color(0xFFEDE7F6), language: 'bn'),
    Lesson(title: '৩', subtitle: 'তিনটি বল', symbol: '⚽⚽⚽', color: Color(0xFFE3F2FD), language: 'bn'),
    Lesson(title: 'বৃত্ত', subtitle: 'গোল আকৃতি', symbol: '🔴', color: Color(0xFFFFEBEE), language: 'bn'),
    Lesson(title: 'ত্রিভুজ', subtitle: 'তিন কোণা', symbol: '🔺', color: Color(0xFFFFF3E0), language: 'bn'),
  ]),
  Subject('আরবি শিক্ষা', 'আরবি হরফ ও সহজ শব্দ', 'ا', const Color(0xFFE5DDF7), const [
    Lesson(title: 'ا', subtitle: 'আলিফ', symbol: '🌙', color: Color(0xFFEDE7F6), language: 'ar', audio: 'ar/alif.mp3'),
    Lesson(title: 'ب', subtitle: 'বা', symbol: '📘', color: Color(0xFFE3F2FD), language: 'ar', audio: 'ar/ba.mp3'),
    Lesson(title: 'ت', subtitle: 'তা', symbol: '🌴', color: Color(0xFFE8F5E9), language: 'ar', audio: 'ar/ta.mp3'),
    Lesson(title: 'ث', subtitle: 'ছা', symbol: '⭐', color: Color(0xFFFFF3E0), language: 'ar', audio: 'ar/tha.mp3'),
  ]),
  Subject('ছবি দেখে শিখি', 'ফল, প্রাণী, রং ও যানবাহন', '🧸', const Color(0xFFFFE6EF), const [
    Lesson(title: 'ফলমূল', subtitle: 'আম, কলা, আপেল', symbol: '🥭🍌🍎', color: Color(0xFFFFF3E0), language: 'bn'),
    Lesson(title: 'প্রাণী', subtitle: 'বাঘ, হাতি, সিংহ', symbol: '🐯🐘🦁', color: Color(0xFFE8F5E9), language: 'bn'),
    Lesson(title: 'যানবাহন', subtitle: 'বাস, ট্রেন, নৌকা', symbol: '🚌🚂🚤', color: Color(0xFFE3F2FD), language: 'bn'),
    Lesson(title: 'রং', subtitle: 'লাল, নীল, হলুদ', symbol: '🎨', color: Color(0xFFF3E5F5), language: 'bn'),
  ]),
  Subject('ছড়া ও গান', 'বাংলা ছড়া ও ইংরেজি রাইম', '🎵', const Color(0xFFFFF0C9), const [
    Lesson(title: 'আয় আয় চাঁদ মামা', subtitle: 'বাংলা ছড়া', symbol: '🌙', color: Color(0xFFEDE7F6), language: 'bn'),
    Lesson(title: 'Twinkle Twinkle', subtitle: 'English rhyme', symbol: '⭐', color: Color(0xFFE3F2FD), language: 'en'),
    Lesson(title: 'নতুন ছড়া', subtitle: 'মৌলিক শিশুতোষ ছড়া', symbol: '🎼', color: Color(0xFFFFF3E0), language: 'bn'),
  ]),
  Subject('ইসলামিক শিক্ষা', 'দোয়া, আদব ও ভালো অভ্যাস', '🕌', const Color(0xFFDDF3E6), const [
    Lesson(title: 'বিসমিল্লাহ', subtitle: 'কাজের শুরুতে', symbol: '🌿', color: Color(0xFFE8F5E9), language: 'ar'),
    Lesson(title: 'সালাম', subtitle: 'আসসালামু আলাইকুম', symbol: '🤝', color: Color(0xFFE3F2FD), language: 'bn'),
    Lesson(title: 'ছোট্ট দোয়া', subtitle: 'সহজে শেখার দোয়া', symbol: '🤲', color: Color(0xFFEDE7F6), language: 'ar'),
  ]),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9EE),
        title: const Text('আমার প্রথম পাঠশালা', style: TextStyle(fontWeight: FontWeight.w800)),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'আমাদের সম্পর্কে',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
            ),
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFFD98A), Color(0xFFFFEFC9)]),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🌈  শেখার মজার জগতে স্বাগতম!', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text('খেলতে খেলতে শিখি, আনন্দে বড় হই।', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('৩–৬ বছর • বাংলা • English • গণিত • আরবি', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text('📚  তোমার বইগুলো', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subjects.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubjectScreen(subject: subject))),
                child: Ink(
                  decoration: BoxDecoration(color: subject.color, borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(subject.emoji, style: const TextStyle(fontSize: 35)),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(subject.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 3),
                          Text(subject.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11)),
                        ]),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          const Center(child: Text('প্রতিদিন একটু একটু করে শিখি ❤️', style: TextStyle(color: Colors.black54))),
        ],
      ),
    );
  }
}

class SubjectScreen extends StatelessWidget {
  final Subject subject;
  const SubjectScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject.title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: subject.lessons.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final lesson = subject.lessons[index];
          return Card(
            color: lesson.color,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                radius: 27, backgroundColor: Colors.white,
                child: Text(lesson.symbol, style: const TextStyle(fontSize: 25)),
              ),
              title: Text(lesson.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
              subtitle: Text(lesson.subtitle),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonScreen(lesson: lesson))),
            ),
          );
        },
      ),
    );
  }
}

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final AudioPlayer _player = AudioPlayer();
  bool _playing = false;
  String _audioMessage = 'অডিও রেকর্ডিং যুক্ত হলে এখানে শুনতে পারবে।';

  Future<void> _playAudio() async {
    final path = widget.lesson.audio;
    if (path == null) {
      setState(() => _audioMessage = 'এই পাঠের অডিও এখনো যোগ করা হয়নি।');
      return;
    }
    try {
      await _player.stop();
      await _player.play(AssetSource('audio/$path'));
      setState(() {
        _playing = true;
        _audioMessage = 'শুনছি...';
      });
    } catch (_) {
      setState(() {
        _playing = false;
        _audioMessage = 'রেকর্ড করা অডিও ফাইল পাওয়া যায়নি। assets/audio ফোল্ডারে MP3 যোগ করতে হবে।';
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    return Scaffold(
      appBar: AppBar(title: const Text('শিখি ও শুনি')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: lesson.color, borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(lesson.title, style: const TextStyle(fontSize: 76, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 16),
                    Text(lesson.symbol, style: const TextStyle(fontSize: 100)),
                    const SizedBox(height: 12),
                    Text(lesson.subtitle, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            if (lesson.rhyme != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                child: Text(lesson.rhyme!.replaceAll(r'\n', '\n'),
                    textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, height: 1.7)),
              ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity, height: 58,
              child: FilledButton.icon(
                onPressed: _playAudio,
                icon: Icon(_playing ? Icons.volume_up_rounded : Icons.play_circle_fill_rounded, size: 27),
                label: const Text('শুনে শিখি', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 8),
            Text(_audioMessage, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static final Uri _github = Uri.parse('https://github.com/mehedi059');
  static final Uri _facebook = Uri.parse('https://facebook.com/mehedi.am');

  Future<void> _openLink(BuildContext context, Uri uri) async {
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('লিংকটি খোলা যায়নি।')),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('লিংকটি খোলা যায়নি।')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('আমাদের সম্পর্কে')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFD98A), Color(0xFFFFEFC9)],
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu_book_rounded, size: 42, color: Color(0xFF5C8D45)),
                ),
                SizedBox(height: 14),
                Text(
                  'আমার প্রথম পাঠশালা',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 4),
                Text('My First Learning Book', style: TextStyle(fontSize: 14)),
                SizedBox(height: 12),
                Text(
                  'খেলতে খেলতে শিখি, আনন্দে বড় হই।',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('ডেভেলপার পরিচিতি', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: Color(0xFFE8F5E9),
                    child: Icon(Icons.person_rounded, size: 38, color: Color(0xFF39804A)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'মো: মেহেদী হাসান',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
                  ),
                  const Text('Developer & Creator', style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 18),
                  ListTile(
                    leading: const Icon(Icons.code_rounded),
                    title: const Text('GitHub'),
                    subtitle: const Text('github.com/mehedi059'),
                    trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                    onTap: () => _openLink(context, _github),
                  ),
                  ListTile(
                    leading: const Icon(Icons.facebook_rounded, color: Color(0xFF1877F2)),
                    title: const Text('Facebook'),
                    subtitle: const Text('facebook.com/mehedi.am'),
                    trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                    onTap: () => _openLink(context, _facebook),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('অ্যাপ সম্পর্কে', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8),
                  Text(
                    '৩–৬ বছর বয়সী শিশুদের জন্য বাংলা, ইংরেজি, গণিত, আরবি, ছবি, ছড়া ও প্রাথমিক শিক্ষার একটি আনন্দময় অফলাইন শেখার উদ্যোগ।',
                    style: TextStyle(height: 1.6),
                  ),
                  SizedBox(height: 12),
                  Text('সংস্করণ: 1.0.0'),
                  Text('লাইসেন্স: MIT License'),
                  SizedBox(height: 12),
                  Text(
                    '© 2026 Mo: Mehedi Hasan. MIT License অনুযায়ী সোর্স কোড ব্যবহারের শর্ত README ও LICENSE ফাইলে দেওয়া আছে।',
                    style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Center(child: Text('শিশুদের শেখার আনন্দময় সঙ্গী ❤️', style: TextStyle(color: Colors.black54))),
        ],
      ),
    );
  }
}
