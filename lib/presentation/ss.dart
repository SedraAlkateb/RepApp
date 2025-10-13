import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  runApp(const MyDynamicColorApp());
}

class MyDynamicColorApp extends StatefulWidget {
  const MyDynamicColorApp({super.key});

  @override
  State<MyDynamicColorApp> createState() => _MyDynamicColorAppState();
}

class _MyDynamicColorAppState extends State<MyDynamicColorApp> {
  // لو اختارت المستخدم لون من الـ palette نحفظه هنا
  Color? _selectedSeedColor;

  @override
  Widget build(BuildContext context) {
    // DynamicColorBuilder يحاول الحصول على ألوان النظام إن وجدت
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        // إذا المستخدم اختار لون نستخدمه كـ seed، وإلا لو في dynamic نستخدمه، وإلا نستخدم seed افتراضي
        final ColorScheme lightScheme = _selectedSeedColor != null
            ? ColorScheme.fromSeed(seedColor: _selectedSeedColor!,
            brightness: Brightness.light)
            : (lightDynamic?.harmonized() ?? ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.light));

        final ColorScheme darkScheme = _selectedSeedColor != null
            ? ColorScheme.fromSeed(seedColor: _selectedSeedColor!, brightness: Brightness.dark)
            : (darkDynamic?.harmonized() ?? ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.dark));

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dynamic Color Demo',
          themeMode: ThemeMode.system,
          theme: ThemeData(useMaterial3: true, colorScheme: lightScheme),
          darkTheme: ThemeData(useMaterial3: true, colorScheme: darkScheme),
          home: HomePage(
            currentSeedColor: _selectedSeedColor,
            onSeedColorChanged: (c) {
              setState(() {
                _selectedSeedColor = c;
              });
            },
            lightScheme: lightScheme,
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final Color? currentSeedColor;
  final ValueChanged<Color?> onSeedColorChanged;
  final ColorScheme lightScheme;

  const HomePage({
    super.key,
    required this.currentSeedColor,
    required this.onSeedColorChanged,
    required this.lightScheme,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;

  // عيّنة ألوان لتجريب الـ seeds — اختاري/أضيفي ألوان كما تحبي
  final List<Color> _demoSeeds = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.indigo,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.amber,
    Colors.orange,
    Colors.brown,
    Colors.grey,
    Colors.deepPurple,
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Color — تجربة'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // --- لوّن Container بألوان من الـ ColorScheme ---
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: cs.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: cs.shadow.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Container مُلوّن (secondaryContainer)',
                    style: TextStyle(
                      color: cs.onSecondaryContainer,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // --- زر للتجريب ---
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Button (primary)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  final snack = SnackBar(
                    content: Text(
                      'هذا زر يستخدم colorScheme.primary',
                      style: TextStyle(color: cs.onPrimary),
                    ),
                    backgroundColor: cs.primary,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snack);
                },
              ),

              const SizedBox(height: 12),

              // --- نص للتجريب ---
              Text(
                'هذا نص (onBackground) يظهر كيف تتغير ألوان النص تلقائيًا',
                style: TextStyle(color: cs.onBackground, fontSize: 16),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 18),

              // --- قائمة ألوان للاختيار (seed palette) ---
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'اختر لونًا (seed) لتغيير ثيم التطبيق:',
                  style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                //  shrinkWrap: true,
                  itemCount: _demoSeeds.length + 1, // +1 للخيار "system" (Dynamic)
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // الزر الأول => استخدم ألوان النظام (reset)
                      return _seedChip(
                        label: 'System',
                        color: null,
                        selected: widget.currentSeedColor == null,
                        onTap: () => widget.onSeedColorChanged(null),
                      );
                    }
                    final color = _demoSeeds[index - 1];
                    return _seedChip(
                      label: '',
                      color: color,
                      selected: widget.currentSeedColor == color,
                      onTap: () => widget.onSeedColorChanged(color),
                    );
                  },
                ),
              ),

              const SizedBox(height: 18),

              // --- معاينة سريعة لبعض أدوار اللون ---
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _colorPreview('primary', cs.primary, cs.onPrimary),
                  _colorPreview('secondary', cs.secondary, cs.onSecondary),
                  _colorPreview('surface', cs.surface, cs.onSurface),
                  _colorPreview('background', cs.background, cs.onBackground),
                  _colorPreview('error', cs.error, cs.onError),
                ],
              ),
              const SizedBox(height: 24),

              // مُلاحظة صغيرة
              Text(
                'غَيّر اللون من الأعلى لتلاحظ كيف تتبدّل ألوان التطبيق تلقائيًا (Material 3 Dynamic Color).',
                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),

      // --- Bottom Navigation لاختبار ألوان الـ nav ---
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (i) => setState(() => _navIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        // NavigationBar يلتقط ألوان من colorScheme تلقائيًا (M3)
      ),
    );
  }

  // ويدجتٌ صغيرة لزر اختيار اللون (seed)
  Widget _seedChip({
    required String label,
    required Color? color,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final border = selected ? Border.all(width: 3, color: Colors.white) : null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: border,
          boxShadow: selected
              ? [BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 6)]
              : null,
        ),
        child: color == null
            ? CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.smartphone, color: Colors.black54),
        )
            : CircleAvatar(radius: 20, backgroundColor: color),
      ),
    );
  }

  // معاينة للون ودوره
  Widget _colorPreview(String name, Color bg, Color fg) {
    return Container(
      width: 140,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 12, backgroundColor: fg),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: TextStyle(color: fg, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
