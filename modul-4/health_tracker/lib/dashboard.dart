import 'package:flutter/material.dart';
import 'laporan_kesehatan.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Health Tracker Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column( 
          children: [
            Text('Selamat datang di Health Tracker!'),
            DashboardCard(
              icon: Icons.directions_walk,
              title: 'Langkah Hari Ini',
              value: '6.234',
              unit: 'langkah',
              color: Colors.green,
            ),
            DashboardCard(
              icon: Icons.local_fire_department,
              title: 'Kalori Terbakar',
              value: '320',
              unit: 'kcal',
              color: Colors.orange,
            ),
            DashboardCard(
              icon: Icons.favorite,
              title: 'Detak Jantung',
              value: '76',
              unit: 'BPM',
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.analytics),
              label: const Text('Lihat Laporan Kesehatan'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LaporanKesehatanPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final Color color;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 32, color: color),
        title: Text(title),
        subtitle: Text(
          '$value $unit',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
