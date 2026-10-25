import 'package:flutter/material.dart';

const kRed = Color(0xFFE53935);
const kBg = Color(0xFF121212);
const kCard = Color(0xFF1E1E1E);

void main() => runApp(const CarApp());

String sar(int p) =>
    '${p.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')} ر.س';

class Car {
  final String name, type;
  final int price, year, hp, topSpeed;
  final Color color;
  const Car(this.name, this.type, this.price, this.year, this.hp,
      this.topSpeed, this.color);
}

const cars = [
  Car('مرسيدس AMG GT', 'رياضية', 450000, 2023, 585, 315, Color(0xFFB71C1C)),
  Car('BMW M5', 'سيدان', 380000, 2022, 600, 305, Color(0xFF0D47A1)),
  Car('تويوتا لاندكروزر', 'دفع رباعي', 280000, 2024, 409, 210, Color(0xFF33691E)),
  Car('تسلا Model 3', 'كهربائية', 200000, 2023, 480, 233, Color(0xFF4A148C)),
  Car('لكزس LS', 'سيدان', 320000, 2023, 415, 250, Color(0xFF37474F)),
  Car('بورش 911', 'رياضية', 520000, 2024, 640, 330, Color(0xFFE65100)),
];

const types = ['الكل', 'رياضية', 'سيدان', 'دفع رباعي', 'كهربائية'];

class CarApp extends StatelessWidget {
  const CarApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'عالم السيارات',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBg,
        colorScheme: const ColorScheme.dark(primary: kRed),
      ),
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      home: const AuthPage(),
    );
  }
}
// صورة مؤقتة للسيارة (استبدلها بـ Image.network أو Image.asset)//
class CarImage extends StatelessWidget {
  final Car car;
  final double? width;
  final double height;
  final double radius;
  const CarImage(this.car,
      {super.key, this.width, required this.height, this.radius = 16});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [car.color, Colors.black],
        ),
      ),
      child: Center(
        child: Icon(Icons.directions_car,
            size: height * 0.45, color: Colors.white70),
      ),
    );
  }
}

// ───────────── الصفحة 1: تسجيل الدخول / إنشاء حساب ─────────────//
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  bool hidden = true;

  Widget field(String label, IconData icon, {bool password = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        obscureText: password && hidden,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: password
              ? IconButton(
                  icon: Icon(hidden ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => hidden = !hidden),
                )
              : null,
          filled: true,
          fillColor: kCard,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget tab(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? kRed : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  void enter() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => const MainShell()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: kRed, borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.directions_car, size: 40),
                ),
                const SizedBox(height: 14),
                const Text('عالم السيارات',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const Text('وجهتك الأولى لعالم السيارات',
                    style: TextStyle(color: Colors.white54)),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: kCard, borderRadius: BorderRadius.circular(14)),
                  child: Row(children: [
                    tab('تسجيل الدخول', isLogin,
                        () => setState(() => isLogin = true)),
                    tab('إنشاء حساب', !isLogin,
                        () => setState(() => isLogin = false)),
                  ]),
                ),
                const SizedBox(height: 24),
                if (!isLogin) field('الاسم', Icons.person_outline),
                field('البريد الإلكتروني', Icons.email_outlined),
                field('كلمة المرور', Icons.lock_outline, password: true),
                if (!isLogin)
                  field('تأكيد كلمة المرور', Icons.lock_outline,
                      password: true),
                if (isLogin)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text('نسيت كلمة المرور؟',
                            style: TextStyle(color: kRed))),
                  ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: kRed,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: enter,
                    child: Text(isLogin ? 'دخول' : 'إنشاء حساب',
                        style: const TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('أو', style: TextStyle(color: Colors.white54)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: enter,
                    icon: const Icon(Icons.g_mobiledata, size: 32),
                    label: const Text('المتابعة عبر Google'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────── الهيكل: شريط التنقل السفلي ─────────────//
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: i, children: const [
        HomePage(),
        SearchPage(),
        ProfilePage(),
      ]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        indicatorColor: kRed.withOpacity(0.3),
        onDestinationSelected: (v) => setState(() => i = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.search), label: 'بحث'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }
}

void openDetails(BuildContext context, Car car) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => CarDetailsPage(car: car)));

class CarTile extends StatelessWidget {
  final Car car;
  const CarTile(this.car, {super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openDetails(context, car),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: kCard, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            CarImage(car, width: 90, height: 80),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(car.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${car.year} • ${car.hp} حصان • ${car.type}',
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text(sar(car.price),
                      style: const TextStyle(
                          color: kRed, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const Icon(Icons.chevron_left, color: Colors.white38),
          ],
        ),
      ),
    );
  }
}

// ───────────── الصفحة 2: الرئيسية ─────────────
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('عالم السيارات',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kRed)),
              Icon(Icons.notifications_none),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final car = cars[i];
                return GestureDetector(
                  onTap: () => openDetails(context, car),
                  child: Stack(
                    children: [
                      CarImage(car, width: 290, height: 190, radius: 20),
                      Positioned(
                        right: 16,
                        bottom: 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(car.name,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text(sar(car.price),
                                style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text('أحدث السيارات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...cars.map((c) => CarTile(c)),
        ],
      ),
    );
  }
}

// ───────────── الصفحة 3: تفاصيل السيارة ─────────────
class CarDetailsPage extends StatelessWidget {
  final Car car;
  const CarDetailsPage({super.key, required this.car});

  Widget spec(String label, String value) => Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
              color: kCard, borderRadius: BorderRadius.circular(14)),
          child: Column(children: [
            Text(value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    const features = ['فتحة سقف بانورامية', 'نظام صوتي فاخر', 'مقاعد جلد', 'كاميرا 360°'];
    return Scaffold(
      appBar: AppBar(
          title: const Text('تفاصيل السيارة'),
          backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CarImage(car, height: 230, radius: 20),
          const SizedBox(height: 16),
          Text(car.name,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(sar(car.price),
              style: const TextStyle(
                  fontSize: 20, color: kRed, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(children: [
            spec('سنة الصنع', '${car.year}'),
            spec('القوة (حصان)', '${car.hp}'),
            spec('السرعة (كم/س)', '${car.topSpeed}'),
          ]),
          const SizedBox(height: 20),
          const Text('الوصف',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('سيارة ${car.type} بحالة ممتازة وأداء قوي وتصميم أنيق، مناسبة لمن يبحث عن الفخامة والراحة.',
              style: const TextStyle(color: Colors.white70, height: 1.6)),
          const SizedBox(height: 20),
          const Text('المميزات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...features.map((f) => ListTile(
                dense: true,
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text(f),
              )),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: kRed,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
          onPressed: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('تم إرسال طلب الحجز ✅'))),
          child: const Text('احجز الآن', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

// ───────────── الصفحة 4: البحث والفلترة ─────────────//
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  String type = 'الكل';

  @override
  Widget build(BuildContext context) {
    final results = cars
        .where((c) =>
            (type == 'الكل' || c.type == type) && c.name.contains(query))
        .toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: InputDecoration(
                hintText: 'ابحث عن سيارة...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: kCard,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: types.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => ChoiceChip(
                  label: Text(types[i]),
                  selected: type == types[i],
                  selectedColor: kRed,
                  onSelected: (_) => setState(() => type = types[i]),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: results.isEmpty
                  ? const Center(child: Text('لا توجد نتائج'))
                  : ListView(children: results.map((c) => CarTile(c)).toList()),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────── الصفحة 5: الملف الشخصي ─────────────//
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget item(IconData icon, String text) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: kCard, borderRadius: BorderRadius.circular(14)),
        child: ListTile(
          leading: Icon(icon, color: kRed),
          title: Text(text),
          trailing: const Icon(Icons.chevron_left, color: Colors.white38),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          const Center(
            child: CircleAvatar(
              radius: 46,
              backgroundColor: kRed,
              child: Icon(Icons.person, size: 50),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
              child: Text('أحمد',
                  style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          const Center(
              child: Text('ahmed@example.com',
                  style: TextStyle(color: Colors.white54))),
          const SizedBox(height: 24),
          item(Icons.favorite_border, 'المفضلة'),
          item(Icons.shopping_bag_outlined, 'طلباتي'),
          item(Icons.location_on_outlined, 'العناوين'),
          item(Icons.settings_outlined, 'الإعدادات'),
          item(Icons.help_outline, 'المساعدة والدعم'),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
                foregroundColor: kRed,
                padding: const EdgeInsets.symmetric(vertical: 14)),
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const AuthPage())),
            icon: const Icon(Icons.logout),
            label: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}