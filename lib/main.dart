import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const PathshalaApp());

class PathshalaApp extends StatelessWidget {
  const PathshalaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'আমার প্রথম পাঠশালা',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF168B68)), useMaterial3: true),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer player = AudioPlayer();
  Map<String,dynamic>? data;
  int tab = 0;
  String? activeAudio;
  @override void initState(){ super.initState(); _load(); }
  Future<void> _load() async {
    final raw = await rootBundle.loadString('assets/data/lessons.json');
    if(mounted) setState(()=>data=jsonDecode(raw) as Map<String,dynamic>);
  }
  Future<void> play(String path) async {
    try {
      setState(()=>activeAudio=path);
      await player.stop();
      await player.play(AssetSource(path.replaceFirst('assets/','')));
    } catch (_) {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('অডিও ফাইল পাওয়া যায়নি। GitHub Actions সফলভাবে সম্পন্ন হয়েছে কি না দেখুন।')));
    }
  }
  @override void dispose(){player.dispose();super.dispose();}
  @override Widget build(BuildContext context) {
    if(data==null) return const Scaffold(body: Center(child:CircularProgressIndicator()));
    final titles=['বাংলা বর্ণমালা','English Alphabet','আরবি হরফ','ছড়া ও কবিতা','অভিভাবক'];
    final all=(data!['lessons'] as List).cast<Map<String,dynamic>>();
    final page=tab<3
      ? AlphabetPage(title:titles[tab],lessons:all.where((x)=>x['language']==['bn','en','ar'][tab]).toList(),onTap:(x)=>play(x['audio'] as String),active:activeAudio)
      : tab==3 ? RhymesPage(items:(data!['rhymes'] as List).cast<Map<String,dynamic>>(),onTap:(x)=>play(x['audio'] as String))
      : const ParentPage();
    return Scaffold(
      appBar:AppBar(title:const Text('আমার প্রথম পাঠশালা'),centerTitle:true),
      body:Column(children:[
        Container(width:double.infinity,margin:const EdgeInsets.all(12),padding:const EdgeInsets.all(16),
          decoration:BoxDecoration(color:const Color(0xFFE4F5EC),borderRadius:BorderRadius.circular(18)),
          child:const Column(children:[Text('চলো শিখি, খেলতে খেলতে!',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold,color:Color(0xFF126B50))),SizedBox(height:4),Text('৩–৬ বছর বয়সী শিশুদের আনন্দময় পাঠশালা')]),
        ),
        Expanded(child:page),
      ]),
      bottomNavigationBar:NavigationBar(selectedIndex:tab,onDestinationSelected:(v)=>setState(()=>tab=v),destinations:const[
        NavigationDestination(icon:Icon(Icons.abc),label:'বাংলা'),
        NavigationDestination(icon:Icon(Icons.language),label:'English'),
        NavigationDestination(icon:Icon(Icons.menu_book),label:'আরবি'),
        NavigationDestination(icon:Icon(Icons.music_note),label:'ছড়া'),
        NavigationDestination(icon:Icon(Icons.family_restroom),label:'অভিভাবক'),
      ]),
    );
  }
}

class AlphabetPage extends StatelessWidget {
  final String title; final List<Map<String,dynamic>> lessons; final ValueChanged<Map<String,dynamic>> onTap; final String? active;
  const AlphabetPage({super.key,required this.title,required this.lessons,required this.onTap,this.active});
  @override Widget build(BuildContext context)=>Column(children:[
    Padding(padding:const EdgeInsets.fromLTRB(16,4,16,10),child:Row(children:[Expanded(child:Text(title,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold))),const Text('ছুঁয়ে শোনো 🔊')])),
    Expanded(child:GridView.builder(padding:const EdgeInsets.fromLTRB(12,0,12,16),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:.92,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:lessons.length,itemBuilder:(context,i){
      final x=lessons[i]; final isActive=active==x['audio'];
      return Material(color:isActive?const Color(0xFFD7F5E7):const Color(0xFFF1F8FF),borderRadius:BorderRadius.circular(16),child:InkWell(borderRadius:BorderRadius.circular(16),onTap:()=>onTap(x),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
        Text(x['symbol'],style:const TextStyle(fontSize:34,fontWeight:FontWeight.bold,color:Color(0xFF164B83))),
        Text(x['emoji'],style:const TextStyle(fontSize:30)),
        Padding(padding:const EdgeInsets.symmetric(horizontal:3),child:Text(x['word'],textAlign:TextAlign.center,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:13,fontWeight:FontWeight.w600))),
        const Icon(Icons.volume_up_rounded,size:17,color:Color(0xFF168B68)),
      ])));
    })),
  ]);
}

class RhymesPage extends StatelessWidget {
  final List<Map<String,dynamic>> items; final ValueChanged<Map<String,dynamic>> onTap;
  const RhymesPage({super.key,required this.items,required this.onTap});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(14),children:[
    for(final x in items) Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.music_note)),title:Text(x['title'],style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text(x['text']),trailing:IconButton(icon:const Icon(Icons.play_circle_fill,color:Color(0xFF168B68),size:32),onPressed:()=>onTap(x)))),
  ]);
}
class ParentPage extends StatelessWidget {
  const ParentPage({super.key});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:const[
    Card(child:ListTile(leading:Icon(Icons.child_care),title:Text('শিশুর শেখার জায়গা'),subtitle:Text('বর্ণ, শব্দ, ছবি ও ছড়া ছুঁয়ে শেখার জন্য তৈরি।'))),
    Card(child:ListTile(leading:Icon(Icons.offline_bolt),title:Text('অফলাইন ব্যবহার'),subtitle:Text('GitHub Actions অডিও তৈরি করে APK-তে যুক্ত করলে শেখার অডিও ইন্টারনেট ছাড়াই চলবে।'))),
    Card(child:ListTile(leading:Icon(Icons.info_outline),title:Text('অ্যাপ সম্পর্কে'),subtitle:Text('আমার প্রথম পাঠশালা\nডেভেলপার: মো: মেহেদী হাসান\nসংস্করণ: 2.0.0'))),
  ]);
}
