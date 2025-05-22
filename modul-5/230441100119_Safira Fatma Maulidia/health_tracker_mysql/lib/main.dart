import 'package:flutter/material.dart';
import 'laporan_kesehatan.dart';
import 'login.dart';
import 'models/aktivitas.dart';
import 'screens/aktivitas_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AktivitasPage(),
  ));
}

class HealthTrackerApp extends StatelessWidget {
  const HealthTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AktivitasPage(),
    );
  }
}

class HealthTrackerPage extends StatefulWidget {
  const HealthTrackerPage({Key? key}) : super(key: key);

  @override
  State<HealthTrackerPage> createState() => _HealthTrackerPageState();
}

class _HealthTrackerPageState extends State<HealthTrackerPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const LaporanPage(),
    const ProfilePage(),
  ];

  void _handleMenuOption(String value) {
    if (value == 'update') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Update Profile dipilih")),
      );
    } else if (value == 'logout') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Log Out dipilih")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EDF7),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF739072),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('images/pp.png'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'Hello, Safira!',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: _handleMenuOption,
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'update',
                            child: Text('Update Profile'),
                          ),
                          const PopupMenuItem(
                            value: 'logout',
                            child: Text('Log Out'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF4F6F52),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBarItem(Icons.home, "Home", 0),
          _buildBarItem(Icons.bar_chart, "Laporan", 1),
          _buildBarItem(Icons.person, "Profile", 2),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      label: label,
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: isSelected
            ? const BoxDecoration(
                color: Color(0xFFF3EDF7),
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(icon, size: 24, color: isSelected ? const Color(0xFF4F6F52) : Colors.grey),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text("Meal Plan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildMealCard(context, "Breakfast", "images/sarapan.jpg", () {}),
          _buildMealCard(context, "Lunch", "images/siang.jpg", () {}),
          _buildMealCard(context, "Dinner", "images/malam.jpg", () {}),
          _buildMealCard(context, "Aktivitas Harian", "images/aktivitas.jpg", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AktivitasPage()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMealCard(BuildContext context, String title, String imageAsset, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Meal plan", style: TextStyle(color: Color(0xFF4F6F52), fontSize: 12)),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text(
                  "Personalized workouts will help\nyou gain strength",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("See more", style: TextStyle(color: Colors.white, fontSize: 12)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Halaman Laporan"));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Halaman Profile"));
  }
}