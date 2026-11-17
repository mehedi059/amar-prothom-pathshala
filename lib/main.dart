import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const PathshalaApp());

class PathshalaApp extends StatelessWidget {
  const PathshalaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'আমার প্রথম পাঠশালা',
    theme: ThemeData(useMaterial3: true, fontFamily: 'NotoSansBengali', colorSchemeSeed: const Color(0xffef9f45), scaffoldBackgroundColor: const Color(0xfffffbf1)),
    home: const HomePage(),
  );
}

class Lesson {
  final String letter, word, emoji, audio;
  const Lesson(this.letter, this.word, this.emoji, this.audio);
}
const vowels = <Lesson>[
  Lesson('অ','অজগর','🐍','bn/অজগর.mp3'), Lesson('আ','আম','🥭','bn/আম.mp3'),
  Lesson('ই','ইঁদুর','🐭','bn/ইঁদুর.mp3'), Lesson('ঈ','ঈগল','🦅','bn/ঈগল.mp3'),
  Lesson('উ','উট','🐪','bn/উট.mp3'), Lesson('ঊ','ঊষা','🌅','bn/ঊষা.mp3'),
  Lesson('ঋ','ঋষি','🧘','bn/ঋষি.mp3'), Lesson('এ','একতারা','🎸','bn/একতারা.mp3'),
  Lesson('ঐ','ঐরাবত','🐘','bn/ঐরাবত.mp3'), Lesson('ও','ওল','🍠','bn/ওল.mp3'),
  Lesson('ঔ','ঔষধ','💊','bn/ঔষধ.mp3'),
];
const consonants = <Lesson>[
  Lesson('ক','কলম','✏️','bn/কলম.mp3'), Lesson('খ','খরগোশ','🐇','bn/খরগোশ.mp3'),
  Lesson('গ','গরু','🐄','bn/গরু.mp3'), Lesson('ঘ','ঘড়ি','🕒','bn/ঘড়ি.mp3'),
  Lesson('ঙ','ব্যাঙ','🐸','bn/ব্যাঙ.mp3'), Lesson('চ','চাঁদ','🌙','bn/চাঁদ.mp3'),
  Lesson('ছ','ছাতা','☂️','bn/ছাতা.mp3'), Lesson('জ','জাহাজ','🚢','bn/জাহাজ.mp3'),
  Lesson('ঝ','ঝুড়ি','🧺','bn/ঝুড়ি.mp3'), Lesson('ঞ','জ্ঞান','📚','bn/জ্ঞান.mp3'),
  Lesson('ট','টমেটো','🍅','bn/টমেটো.mp3'), Lesson('ঠ','ঠেলাগাড়ি','🛒','bn/ঠেলাগাড়ি.mp3'),
  Lesson('ড','ডাব','🥥','bn/ডাব.mp3'), Lesson('ঢ','ঢোল','🥁','bn/ঢোল.mp3'),
  Lesson('ণ','হরিণ','🦌','bn/হরিণ.mp3'), Lesson('ত','তরমুজ','🍉','bn/তরমুজ.mp3'),
  Lesson('থ','থালা','🍽️','bn/থালা.mp3'), Lesson('দ','দোয়েল','🐦','bn/দোয়েল.mp3'),
  Lesson('ধ','ধান','🌾','bn/ধান.mp3'), Lesson('ন','নৌকা','🛶','bn/নৌকা.mp3'),
  Lesson('প','পাখি','🐦','bn/পাখি.mp3'), Lesson('ফ','ফুল','🌼','bn/ফুল.mp3'),
  Lesson('ব','বই','📖','bn/বই.mp3'), Lesson('ভ','ভালুক','🐻','bn/ভালুক.mp3'),
  Lesson('ম','মাছ','🐟','bn/মাছ.mp3'), Lesson('য','যন্ত্র','⚙️','bn/যন্ত্র.mp3'),
  Lesson('র','রথ','🛺','bn/রথ.mp3'), Lesson('ল','লিচু','🍒','bn/লিচু.mp3'),
  Lesson('শ','শাপলা','🪷','bn/শাপলা.mp3'), Lesson('ষ','ষাঁড়','🐂','bn/ষাঁড়.mp3'),
  Lesson('স','সাপ','🐍','bn/সাপ.mp3'), Lesson('হ','হাতি','🐘','bn/হাতি.mp3'),
  Lesson('ড়','ঘোড়া','🐎','bn/ঘোড়া.mp3'), Lesson('ঢ়','আষাঢ়','🌧️','bn/আষাঢ়.mp3'),
  Lesson('য়','ময়ূর','🦚','bn/ময়ূর.mp3'), Lesson('ৎ','উৎসব','🎉','bn/উৎসব.mp3'),
  Lesson('ং','রং','🎨','bn/রং.mp3'), Lesson('ঃ','দুঃখ','😢','bn/দুঃখ.mp3'),
  Lesson('ঁ','চাঁদ','🌙','bn/চাঁদ.mp3'),
];
const english = <Lesson>[
  Lesson('A','Apple','🍎','en/A.mp3'),Lesson('B','Ball','⚽','en/B.mp3'),Lesson('C','Cat','🐱','en/C.mp3'),
  Lesson('D','Dog','🐶','en/D.mp3'),Lesson('E','Elephant','🐘','en/E.mp3'),Lesson('F','Fish','🐟','en/F.mp3'),
  Lesson('G','Goat','🐐','en/G.mp3'),Lesson('H','Hen','🐔','en/H.mp3'),Lesson('I','Ice cream','🍦','en/I.mp3'),
  Lesson('J','Jug','🏺','en/J.mp3'),Lesson('K','Kite','🪁','en/K.mp3'),Lesson('L','Lion','🦁','en/L.mp3'),
  Lesson('M','Mango','🥭','en/M.mp3'),Lesson('N','Nest','🪺','en/N.mp3'),Lesson('O','Orange','🍊','en/O.mp3'),
  Lesson('P','Parrot','🦜','en/P.mp3'),Lesson('Q','Queen','👑','en/Q.mp3'),Lesson('R','Rabbit','🐇','en/R.mp3'),
  Lesson('S','Sun','☀️','en/S.mp3'),Lesson('T','Tiger','🐅','en/T.mp3'),Lesson('U','Umbrella','☂️','en/U.mp3'),
  Lesson('V','Van','🚐','en/V.mp3'),Lesson('W','Watch','⌚','en/W.mp3'),Lesson('X','Xylophone','🎼','en/X.mp3'),
  Lesson('Y','Yak','🐂','en/Y.mp3'),Lesson('Z','Zebra','🦓','en/Z.mp3'),
];
const arabic = <Lesson>[
  Lesson('ا','আলিফ','🌙','ar/alif.mp3'),Lesson('ب','বা','📘','ar/ba.mp3'),Lesson('ت','তা','🌷','ar/ta.mp3'),
  Lesson('ث','ছা','⭐','ar/tha.mp3'),Lesson('ج','জীম','🐪','ar/jeem.mp3'),Lesson('ح','হা','🌿','ar/ha.mp3'),
  Lesson('خ','খা','🍞','ar/kha.mp3'),Lesson('د','দাল','🚪','ar/dal.mp3'),Lesson('ذ','যাল','🌽','ar/thal.mp3'),
  Lesson('ر','রা','🌹','ar/ra.mp3'),Lesson('ز','যাই','🦓','ar/zay.mp3'),Lesson('س','সীন','🐟','ar/seen.mp3'),
  Lesson('ش','শীন','☀️','ar/sheen.mp3'),Lesson('ص','সাদ','🦅','ar/sad.mp3'),Lesson('ض','দাদ','🐸','ar/dad.mp3'),
  Lesson('ط','ত্বা','✈️','ar/ta2.mp3'),Lesson('ظ','য্বা','🌳','ar/za2.mp3'),Lesson('ع','আইন','👁️','ar/ain.mp3'),
  Lesson('غ','গইন','☁️','ar/ghain.mp3'),Lesson('ف','ফা','🐘','ar/fa.mp3'),Lesson('ق','ক্বফ','🌙','ar/qaf.mp3'),
  Lesson('ك','কাফ','📖','ar/kaf.mp3'),Lesson('ل','লাম','🍋','ar/lam.mp3'),Lesson('م','মীম','💧','ar/meem.mp3'),
  Lesson('ن','নূন','🐝','ar/noon.mp3'),Lesson('ه','হা','🎁','ar/ha2.mp3'),Lesson('و','ওয়াও','🌹','ar/waw.mp3'),Lesson('ي','ইয়া','✋','ar/ya.mp3'),
];
const rhymes = <Map<String,String>>[
 {'title':'আয় আয় চাঁদ মামা','type':'ছড়া','text':'আয় আয় চাঁদ মামা\\nটিপ দিয়ে যা\\nচাঁদের কপালে চাঁদ\\nটিপ দিয়ে যা।'},
 {'title':'হাট্টিমাটিম টিম','type':'ছড়া','text':'হাট্টিমাটিম টিম\\nতারা মাঠে পাড়ে ডিম\\nতাদের খাড়া দুটো শিং\\nতারা হাট্টিমাটিম টিম।'},
 {'title':'খোকন খোকন ডাক পাড়ি','type':'কবিতা','text':'খোকন খোকন ডাক পাড়ি\\nখোকন মোদের কার বাড়ি\\nআয়রে খোকন ঘরে আয়\\nমায়ের কোলে বসে খায়।'},
 {'title':'প্রজাপতি প্রজাপতি','type':'কবিতা','text':'প্রজাপতি প্রজাপতি\\nপাখনা মেলে উড়ে যাস\\nফুলের বনে রঙ ছড়িয়ে\\nআনন্দে তুই ফিরে আস।'},
 {'title':'সকাল হলো','type':'গান','text':'সকাল হলো, দিন হলো\\nসূর্য ওঠে হাসে\\nপাখিরা সব গান গায়\\nসবুজ ঘাসের পাশে।'},
];
class HomePage extends StatefulWidget { const HomePage({super.key}); @override State<HomePage> createState()=>_HomePageState(); }
class _HomePageState extends State<HomePage> {
 int tab=0; final player=AudioPlayer(); String? playing;
 final colors=[const Color(0xffffe0b5),const Color(0xfffff0a9),const Color(0xffddf1ff),const Color(0xffe8e3fa)];
 Future<void> play(String path) async {
   try { await player.stop(); await player.play(AssetSource('audio/$path')); setState(()=>playing=path); }
   catch (_) { if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('এই পাঠের রেকর্ড করা অডিও এখনো যোগ করা হয়নি।'))); }
 }
 @override void dispose(){player.dispose();super.dispose();}
 @override Widget build(BuildContext context){
  final pages=[_home(),_alphabet('বাংলা স্বরবর্ণ',vowels),_alphabet('বাংলা ব্যঞ্জনবর্ণ',consonants),_alphabet('English Alphabet',english),_alphabet('আরবি হরফ',arabic),_rhymes(),_about()];
  return Scaffold(body:SafeArea(child:pages[tab]),bottomNavigationBar:NavigationBar(selectedIndex:tab>4? (tab==5?5:6):0,onDestinationSelected:(i)=>setState(()=>tab=i==0?0:i),destinations:const[
   NavigationDestination(icon:Icon(Icons.home_rounded),label:'হোম'),
   NavigationDestination(icon:Icon(Icons.abc),label:'বাংলা'),
   NavigationDestination(icon:Icon(Icons.menu_book),label:'ব্যঞ্জন'),
   NavigationDestination(icon:Icon(Icons.language),label:'English'),
   NavigationDestination(icon:Icon(Icons.nightlight_round),label:'আরবি'),
   NavigationDestination(icon:Icon(Icons.music_note),label:'ছড়া'),
   NavigationDestination(icon:Icon(Icons.info_outline),label:'পরিচিতি'),
  ]));
 }
 Widget _home()=>SingleChildScrollView(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
  const SizedBox(height:8),const Text('আমার প্রথম পাঠশালা',textAlign:TextAlign.center,style:TextStyle(fontSize:27,fontWeight:FontWeight.w900,color:Color(0xff65421e))),
  const Text('খেলতে খেলতে শিখি',textAlign:TextAlign.center,style:TextStyle(fontSize:16,color:Colors.brown)),
  const SizedBox(height:22),_homeTile('বাংলা স্বরবর্ণ','১১টি অক্ষর','🔤',1,colors[0]),_homeTile('বাংলা ব্যঞ্জনবর্ণ','ব্যঞ্জনবর্ণের গ্রিড','📚',2,colors[1]),
  _homeTile('English Alphabet','A থেকে Z','🔠',3,colors[2]),_homeTile('আরবি হরফ','আরবি বর্ণমালা','🌙',4,colors[3]),_homeTile('ছড়া, কবিতা ও গান','শুনে শুনে শিখি','🎵',5,colors[0]),
  const SizedBox(height:12),const Text('শেখার জন্য যেকোনো কার্ডে চাপ দাও।',textAlign:TextAlign.center)
 ]));
 Widget _homeTile(String title,String sub,String emoji,int target,Color color)=>Card(color:color,elevation:0,child:ListTile(contentPadding:const EdgeInsets.all(12),leading:Text(emoji,style:const TextStyle(fontSize:34)),title:Text(title,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold)),subtitle:Text(sub),trailing:const Icon(Icons.arrow_forward_ios),onTap:()=>setState(()=>tab=target)));
 Widget _alphabet(String title,List<Lesson> items)=>Column(children:[
  Padding(padding:const EdgeInsets.fromLTRB(8,12,8,6),child:Row(children:[IconButton(onPressed:()=>setState(()=>tab=0),icon:const Icon(Icons.arrow_back)),Expanded(child:Text(title,textAlign:TextAlign.center,style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold))),const SizedBox(width:48)])),
  const Text('যেকোনো বাটনে চাপ দাও, অক্ষর ও শব্দ শোনো',style:TextStyle(color:Colors.brown)),
  Expanded(child:GridView.builder(padding:const EdgeInsets.all(12),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,mainAxisSpacing:10,crossAxisSpacing:10,childAspectRatio:.83),itemCount:items.length,itemBuilder:(context,i){
   final x=items[i]; return Material(color:colors[i%4],borderRadius:BorderRadius.circular(18),child:InkWell(borderRadius:BorderRadius.circular(18),onTap:()=>play(x.audio),child:Padding(padding:const EdgeInsets.all(5),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
    Text(x.letter,style:const TextStyle(fontSize:36,fontWeight:FontWeight.w900,color:Color(0xff27231d))),
    Text(x.emoji,style:const TextStyle(fontSize:32)),Text(x.word,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:13,fontWeight:FontWeight.w700)),
    Icon(playing==x.audio?Icons.volume_up:Icons.touch_app,size:17,color:Colors.brown)
   ]))));
  }))
 ]);
 Widget _rhymes()=>ListView(padding:const EdgeInsets.all(16),children:[
  const Text('ছড়া, কবিতা ও গান',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
  const Text('পড়ি, শুনি, মুখস্থ করি',textAlign:TextAlign.center),
  ...rhymes.map((r)=>Card(color:colors[rhymes.indexOf(r)%4],child:ExpansionTile(title:Text(r['title']!,style:const TextStyle(fontSize:19,fontWeight:FontWeight.bold)),subtitle:Text(r['type']!),children:[Padding(padding:const EdgeInsets.all(16),child:Text(r['text']!,style:const TextStyle(fontSize:20,height:1.8))),Padding(padding:const EdgeInsets.only(bottom:12),child:FilledButton.icon(onPressed:()=>play('rhymes/${rhymes.indexOf(r)+1}.mp3'),icon:const Icon(Icons.play_arrow),label:const Text('অডিও শুনি')))]))),
  const Padding(padding:EdgeInsets.all(12),child:Text('নোট: এই সংস্করণে ছড়ার লেখা নমুনা হিসেবে আছে। প্রকাশের আগে ছড়ার স্বত্ব/অনুমতি যাচাই এবং মানুষের কণ্ঠে অডিও রেকর্ড যোগ করতে হবে।'))
 ]);
 Widget _about()=>const Center(child:Padding(padding:EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[Text('আমার প্রথম পাঠশালা',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold)),SizedBox(height:12),Text('উন্নয়নকারী: মো: মেহেদী হাসান'),Text('Version 1.1.0'),Text('শিশুদের শেখার আনন্দময় সঙ্গী')]))); 
}
