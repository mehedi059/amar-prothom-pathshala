import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

void main() => runApp(const PathshalaApp());

class PathshalaApp extends StatelessWidget {
  const PathshalaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'আমার প্রথম পাঠশালা',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF168A70), scaffoldBackgroundColor: const Color(0xFFFFFBF2)),
        home: const HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer _player = AudioPlayer();
  List<dynamic> _lessons = [];
  List<dynamic> _rhymes = [];
  int _tab = 0;
  String _language = 'bn';
  String _bnGroup = 'vowels';
  String? _playingId;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
    _player.onPlayerComplete.listen((_) { if (mounted) setState(() => _playingId = null); });
  }

  Future<void> _loadData() async {
    try {
      final raw = await rootBundle.loadString('assets/data/lessons.json');
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      if (!mounted) return;
      setState(() {
        _lessons = decoded['lessons'] as List<dynamic>;
        _rhymes = decoded['rhymes'] as List<dynamic>;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() { _loading = false; _error = 'পাঠের তথ্য লোড করা যায়নি: $e'; });
    }
  }

  Future<void> _play(String id, String language, String filename) async {
    final path = language == 'rhyme' ? 'audio/rhymes/$filename' : 'audio/$language/$filename';
    try {
      await _player.stop();
      if (mounted) setState(() => _playingId = id);
      await _player.play(AssetSource(path));
    } catch (e) {
      if (!mounted) return;
      setState(() => _playingId = null);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('অডিও চালানো যায়নি। APK-তে অডিও যুক্ত আছে কি না যাচাই করুন। ($e)')));
    }
  }

  @override
  void dispose() { _player.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(_error!))));
    return Scaffold(
      appBar: AppBar(title: const Text('আমার প্রথম পাঠশালা', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true, backgroundColor: const Color(0xFFFFE8A3)),
      body: IndexedStack(index: _tab, children: [_learningPage(), _rhymePage(), _aboutPage()]),
      bottomNavigationBar: NavigationBar(selectedIndex: _tab, onDestinationSelected: (v) => setState(() => _tab = v), destinations: const [
        NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'বর্ণ শিখি'),
        NavigationDestination(icon: Icon(Icons.music_note_outlined), selectedIcon: Icon(Icons.music_note), label: 'ছড়া'),
        NavigationDestination(icon: Icon(Icons.family_restroom), selectedIcon: Icon(Icons.family_restroom), label: 'অভিভাবক'),
      ]),
    );
  }

  Widget _learningPage() {
    final list = _lessons.where((e) => e['language'] == _language).toList();
    final filtered = _language == 'bn' ? list.where((e) => (_bnGroup == 'vowels') == (e['id'] as String).startsWith('bn_vowel')).toList() : list;
    final title = _language == 'bn' ? 'বাংলা বর্ণমালা' : _language == 'en' ? 'English Alphabet' : 'আরবি হরফ';
    return Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 4), child: SegmentedButton<String>(segments: const [
        ButtonSegment(value: 'bn', label: Text('বাংলা')), ButtonSegment(value: 'en', label: Text('English')), ButtonSegment(value: 'ar', label: Text('আরবি')),
      ], selected: {_language}, onSelectionChanged: (s) => setState(() { _language = s.first; _bnGroup = 'vowels'; }))),
      if (_language == 'bn') Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), child: SegmentedButton<String>(segments: const [
        ButtonSegment(value: 'vowels', label: Text('স্বরবর্ণ (১১)')), ButtonSegment(value: 'consonants', label: Text('ব্যঞ্জনবর্ণ (৩৯)')),
      ], selected: {_bnGroup}, onSelectionChanged: (s) => setState(() => _bnGroup = s.first))),
      Padding(padding: const EdgeInsets.only(top: 4, bottom: 8), child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      Expanded(child: GridView.builder(padding: const EdgeInsets.fromLTRB(12, 0, 12, 16), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: .92), itemCount: filtered.length, itemBuilder: (context, index) {
        final item = filtered[index] as Map<String, dynamic>;
        final active = _playingId == item['id'];
        return InkWell(borderRadius: BorderRadius.circular(18), onTap: () => _play(item['id'], item['language'], item['audio']), child: Container(decoration: BoxDecoration(color: active ? const Color(0xFFB9E8D8) : Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: active ? const Color(0xFF168A70) : const Color(0xFFE8DCC5), width: active ? 2 : 1), boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 4, offset: Offset(0, 2))]), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(item['letter'], style: TextStyle(fontSize: _language == 'ar' ? 43 : 39, fontWeight: FontWeight.bold, color: const Color(0xFF244A43))),
          const SizedBox(height: 5), Padding(padding: const EdgeInsets.symmetric(horizontal: 3), child: Text(item['word'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
          const SizedBox(height: 5), Icon(active ? Icons.volume_up : Icons.play_circle_fill, size: 22, color: const Color(0xFF168A70)),
        ])));
      })),
    ]);
  }

  Widget _rhymePage() => ListView(padding: const EdgeInsets.all(14), children: [const Text('মজার ছড়া', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 10), ..._rhymes.map((raw) {
    final r = raw as Map<String, dynamic>; final active = _playingId == r['id'];
    return Card(color: active ? const Color(0xFFDDF4E9) : Colors.white, child: ListTile(leading: const CircleAvatar(child: Icon(Icons.music_note)), title: Text(r['title'], style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(r['text']), trailing: IconButton(icon: Icon(active ? Icons.volume_up : Icons.play_arrow), onPressed: () => _play(r['id'], 'rhyme', r['audio']))));
  })]);

  Widget _aboutPage() => ListView(padding: const EdgeInsets.all(20), children: const [
    Icon(Icons.child_care, size: 64, color: Color(0xFF168A70)), SizedBox(height: 12), Text('আমার প্রথম পাঠশালা', textAlign: TextAlign.center, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
    SizedBox(height: 12), Text('৩–৬ বছর বয়সী শিশুদের জন্য বাংলা, ইংরেজি ও আরবি বর্ণ শেখার আনন্দময় অ্যাপ। বর্ণ বা ছড়ার কার্ডে চাপ দিলে অডিও শোনা যাবে। অডিও অ্যাপের ভেতরে থাকলে ইন্টারনেট ছাড়াই চলবে।'),
    SizedBox(height: 20), Text('ডেভেলপার: মো: মেহেদী হাসান', style: TextStyle(fontWeight: FontWeight.bold)), Text('সংস্করণ: 1.2.0'),
  ]);
}
