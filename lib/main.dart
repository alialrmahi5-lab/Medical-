import 'package:flutter/material.dart';

void main() => runApp(const MedTermsApp());

class MedTermsApp extends StatelessWidget {
  const MedTermsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedTerms Quest',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087F8C),
        ),
        scaffoldBackgroundColor: const Color(0xFFF2FAF8),
      ),
      home: const AcademyPage(),
    );
  }
}

class Lesson {
  final String title;
  final String icon;
  final List<Question> questions;

  const Lesson(this.title, this.icon, this.questions);
}

class Question {
  final String term;
  final String prompt;
  final List<String> choices;
  final int answer;
  final String explanation;

  const Question(
    this.term,
    this.prompt,
    this.choices,
    this.answer,
    this.explanation,
  );
}

const lessons = <Lesson>[
  Lesson('أجزاء الجسم', '🫀', [
    Question('Heart', 'ما معنى Heart؟',
        ['الكبد', 'القلب', 'الرئة', 'الكلية'], 1, 'Heart تعني القلب.'),
    Question('Brain', 'اختر معنى Brain',
        ['الدماغ', 'العظم', 'الجلد', 'المعدة'], 0, 'Brain تعني الدماغ.'),
    Question('Lung', 'ما معنى Lung؟',
        ['القلب', 'الكلية', 'الرئة', 'الدم'], 2, 'Lung تعني الرئة.'),
  ]),
  Lesson('الأعراض والفحص', '🩺', [
    Question('Fever', 'ما معنى Fever؟',
        ['حمّى', 'نزيف', 'كسر', 'دوخة'], 0, 'Fever تعني الحمّى.'),
    Question('Pain', 'ما معنى Pain؟',
        ['علاج', 'ألم', 'جرعة', 'عدوى'], 1, 'Pain تعني الألم.'),
    Question('Diagnosis', 'ما معنى Diagnosis؟',
        ['تشخيص', 'عملية', 'دواء', 'تحليل دم'], 0, 'Diagnosis تعني التشخيص.'),
  ]),
  Lesson('الأدوية', '💊', [
    Question('Paracetamol', 'أي استخدام يرتبط بالباراسيتامول؟',
        ['تخفيف الألم والحمّى', 'علاج كل أنواع العدوى',
         'علاج السكري', 'إذابة جميع الجلطات'],
        0, 'يُستخدم لتخفيف الألم والحمّى. الجرعة الزائدة قد تؤذي الكبد.'),
    Question('Amoxicillin', 'إلى أي فئة ينتمي Amoxicillin؟',
        ['مضاد حيوي', 'مسكن أفيوني', 'فيتامين', 'مضاد حموضة'],
        0, 'مضاد حيوي لبعض العدوى البكتيرية، بوصفة وتقييم طبي.'),
    Question('Ibuprofen', 'ما الفئة التي ينتمي إليها Ibuprofen؟',
        ['مضاد التهاب غير ستيرويدي', 'مضاد حيوي',
         'دواء للسكري', 'مضاد فيروسات'],
        0, 'مسكن ومضاد التهاب؛ قد لا يناسب بعض مرضى المعدة والكلى.'),
    Question('Metformin', 'يُستخدم Metformin غالباً في علاج:',
        ['السكري من النوع الثاني', 'الربو', 'العدوى البكتيرية', 'الحساسية'],
        0, 'يُستخدم لعلاج السكري من النوع الثاني حسب التقييم الطبي.'),
  ]),
  Lesson('المستشفى والطوارئ', '🚑', [
    Question('Emergency', 'ما معنى Emergency؟',
        ['موعد', 'طوارئ', 'صيدلية', 'مختبر'], 1, 'Emergency تعني الطوارئ.'),
    Question('Nurse', 'ما معنى Nurse؟',
        ['جرّاح', 'مريض', 'ممرض أو ممرضة', 'صيدلي'], 2,
        'Nurse تعني ممرضاً أو ممرضة.'),
    Question('Bleeding', 'ما معنى Bleeding؟',
        ['نزيف', 'حمّى', 'سعال', 'تورم'], 0, 'Bleeding تعني النزيف.'),
  ]),
];

class AcademyPage extends StatefulWidget {
  const AcademyPage({super.key});

  @override
  State<AcademyPage> createState() => _AcademyPageState();
}

class _AcademyPageState extends State<AcademyPage> {
  int xp = 0;
  int hearts = 5;
  int unlocked = 1;
  final Set<int> completed = {};

  void openLesson(int index) {
    if (index >= unlocked || hearts == 0) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizPage(
          lesson: lessons[index],
          onFinish: (correct, total) {
            setState(() {
              xp += correct * 10;
              if (correct == total) {
                completed.add(index);
                if (unlocked < lessons.length) unlocked++;
              }
            });
          },
          onMistake: () {
            setState(() {
              if (hearts > 0) hearts--;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedTerms Quest',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF087F8C),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('رحلتك الطبية تبدأ هنا! 🩺',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('تعلّم المصطلحات الطبية خطوة بخطوة',
                    style: TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                Text('⭐  $xp XP     ❤️  $hearts',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: 8),
                Text('أنجزت ${completed.length} من ${lessons.length} مستويات',
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('مسار التعلّم',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          for (int i = 0; i < lessons.length; i++)
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                leading: Text(
                  i < unlocked ? lessons[i].icon : '🔒',
                  style: const TextStyle(fontSize: 30),
                ),
                title: Text('المستوى ${i + 1}: ${lessons[i].title}'),
                subtitle: Text(
                  completed.contains(i)
                      ? 'مكتمل ✓'
                      : i < unlocked
                          ? '${lessons[i].questions.length} أسئلة'
                          : 'أكمل المستوى السابق لفتحه',
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 17),
                onTap: () => openLesson(i),
              ),
            ),
          if (hearts == 0)
            FilledButton(
              onPressed: () => setState(() => hearts = 5),
              child: const Text('استعادة القلوب للتدريب'),
            ),
          const SizedBox(height: 16),
          const Text(
            'المحتوى للتعلّم فقط. لا تستخدم التطبيق لتحديد علاجك أو جرعاتك.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final Lesson lesson;
  final void Function(int correct, int total) onFinish;
  final VoidCallback onMistake;

  const QuizPage({
    super.key,
    required this.lesson,
    required this.onFinish,
    required this.onMistake,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int current = 0;
  int correct = 0;
  int? selected;
  bool checked = false;
  bool finished = false;

  Question get question => widget.lesson.questions[current];

  void choose(int index) {
    if (checked || finished) return;
    setState(() => selected = index);
  }

  void checkAnswer() {
    if (selected == null || checked) return;

    final isCorrect = selected == question.answer;
    setState(() {
      checked = true;
      if (isCorrect) {
        correct++;
      } else {
        widget.onMistake();
      }
    });
  }

  void nextQuestion() {
    if (!checked) return;

    if (current + 1 < widget.lesson.questions.length) {
      setState(() {
        current++;
        selected = null;
        checked = false;
      });
    } else {
      setState(() => finished = true);
      widget.onFinish(correct, widget.lesson.questions.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.lesson.questions.length;

    return Scaffold(
      appBar: AppBar(title: Text(widget.lesson.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: finished
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🎉', style: TextStyle(fontSize: 65)),
                    const Text('انتهى الدرس!',
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Text('إجابات صحيحة: $correct من $total'),
                    Text('حصلت على ${correct * 10} XP'),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('العودة للمستويات'),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(value: (current + 1) / total),
                  const SizedBox(height: 25),
                  Text('السؤال ${current + 1} من $total',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  Text(question.term,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(question.prompt,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  for (int i = 0; i < question.choices.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: checked && i == question.answer
                              ? Colors.green.shade100
                              : selected == i
                                  ? Colors.teal.shade50
                                  : null,
                        ),
                        onPressed: () => choose(i),
                        child: Text(question.choices[i],
                            style: const TextStyle(fontSize: 17)),
                      ),
                    ),
                  if (checked)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '${selected == question.answer ? 'إجابة صحيحة!' : 'الإجابة الصحيحة: ${question.choices[question.answer]}'}\n${question.explanation}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: checked
                        ? nextQuestion
                        : selected == null
                            ? null
                            : checkAnswer,
                    child: Text(checked ? 'السؤال التالي' : 'تحقق من الإجابة'),
                  ),
                ],
              ),
      ),
    );
  }
}
