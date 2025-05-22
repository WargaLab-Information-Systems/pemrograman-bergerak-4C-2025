// import 'package:flutter/material.dart';
// import 'laporan_kesehatan.dart';
// import 'login.dart';

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HealthTrackerPage(),
//   ));
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // File ini sudah kamu punya
import 'laporan_kesehatan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaporanKesehatanPage(),
    );
  }
}




class HealthTrackerApp extends StatelessWidget {
  const HealthTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HealthTrackerPage(), // <-- ini tampilan pertama
    );
  }
}

class HealthTrackerPage extends StatelessWidget {
  const HealthTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
     body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              const Text("Health Tracker", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildTrackerGrid(context),
              const SizedBox(height: 20),
              const Text("My Plan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildPlanCard("Muscle Builder", Icons.fitness_center),
              const SizedBox(height: 10),
              _buildPlanCard("70 kg weight target", Icons.monitor_weight),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LaporanKesehatanPage()),
            );
          }
          // Tambah logika lainnya kalau perlu nanti
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 20,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Hello, John", style: TextStyle(fontWeight: FontWeight.w600)),
                Text("Aug, 17 2022", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        const Icon(Icons.notifications_none),
      ],
    );
  }

  Widget _buildTrackerGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildTrackerCard("Walk", "4252 Steps", Icons.directions_walk, Colors.green, context),
        _buildTrackerCard("Water", "2 Litres", Icons.local_drink, Colors.blue, context),
        _buildTrackerCard("Sleep", "6 hr 34 min", Icons.nights_stay, Colors.purple, context),
        _buildTrackerCard("Heart", "84 BPM", Icons.favorite, Colors.red, context),
      ],
    );
  }

  Widget _buildTrackerCard(String title, String subtitle, IconData icon, Color color, BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == "Heart") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HeartDetailPage()),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const Spacer(),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Lorem ipsum", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.nights_stay, color: Colors.blue),
        ],
      ),
    );
  }
}

class HeartDetailPage extends StatelessWidget {
  const HeartDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Heart Activity"),
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Text(
          "70 BPM\n(Detail Chart Here)",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
