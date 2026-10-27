import 'package:flutter/material.dart';

void main() {
  runApp(const MedTermsApp());
}

class MedTermsApp extends StatelessWidget {
  const MedTermsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedTerms Quest',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D9488)),
        scaffoldBackgroundColor: const Color(0xFFF4FBF9),
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
  int xp = 0;
  int completed = 0;

  final List<Map<String, String>> lessons = [
    {'title': 'أجزاء الجسم', 'subtitle': 'Body Parts', 'icon': '🫀', 'words': 'Heart = القلب\nBrain = الدماغ\nLung = الرئة'},
    {'title': 'المصطلحات الطبية', 'subtitle': 'Medical Terms', 'icon': '🩺', 'words': 'Diagnosis = التشخيص\nTreatment = العلاج\nSymptom = عَرَض'},
    {'title': 'الطوارئ والإسعافات', 'subtitle': 'Emergency', 'icon': '🚑', 'words': 'Emergency = طوارئ\nBleeding = نزيف\nPain = ألم'},
    {'title': 'الأدوية', 'subtitle': 'Medicine', 'icon': '💊', 'words': 'Medicine = دواء\nDose = جرعة\nTablet = قرص'},
  ];

  void openLesson(Map<String, String> lesson) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LessonPage(
      title: lesson['title']!, subtitle: lesson['subtitle']!, icon: lesson['icon']!, words: lesson['words']!,
      onComplete: () { setState(() { xp += 10; completed++; }); },
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MedTerms Quest', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFF0D9488), borderRadius: BorderRadius.circular(22)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('رحلتك نحو الطب تبدأ هنا! 🩺', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8), const Text('تعلّم المصطلحات الطبية بالإنجليزي والعربي', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 18), Row(children: [const Icon(Icons.bolt, color: Colors.amber), Text(' $xp XP', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const Spacer(), const Icon(Icons.menu_book, color: Colors.white), Text(' $completed دروس مكتملة', style: const TextStyle(color: Colors.white))]),
        ])),
        const SizedBox(height: 24),
        const Text('📚 مسارات التعلّم', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...lessons.map((lesson) => Card(margin: const EdgeInsets.only(bottom: 12), elevation: 0, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: Color(0xFFDDEEEA)),), child: ListTile(contentPadding: const EdgeInsets.all(12), leading: Text(lesson['icon']!, style: const TextStyle(fontSize: 32)), title: Text(lesson['title']!, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(lesson['subtitle']!), trailing: const Icon(Icons.arrow_forward_ios, size: 18), onTap: () => openLesson(lesson)))),
        const SizedBox(height: 8),
        const Center(child: Text('كل يوم مصطلح جديد، خطوة أقرب لهدفك 💚', textAlign: TextAlign.center)),
      ]),
    );
  }
}

class LessonPage extends StatefulWidget {
  final String title, subtitle, icon, words;
  final VoidCallback onComplete;
  const LessonPage({super.key, required this.title, required this.subtitle, required this.icon, required this.words, required this.onComplete});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  bool finished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(widget.icon, textAlign: TextAlign.center, style: const TextStyle(fontSize: 65)),
        Text(widget.subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Text('تعلّم واحفظ المصطلحات التالية:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Text(widget.words, textDirection: TextDirection.ltr, style: const TextStyle(fontSize: 20, height: 2.1)))),
        const Spacer(),
        FilledButton.icon(onPressed: finished ? null : () { widget.onComplete(); setState(() { finished = true; }); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('أحسنت! حصلت على 10 XP 🎉'))); }, icon: Icon(finished ? Icons.check_circle : Icons.star), label: Text(finished ? 'أكملت هذا الدرس' : 'إكمال الدرس +10 XP'), style: FilledButton.styleFrom(padding: const EdgeInsets.all(16))),
        const SizedBox(height: 10),
        OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('العودة للدروس')),
      ])),
    );
  }
}
