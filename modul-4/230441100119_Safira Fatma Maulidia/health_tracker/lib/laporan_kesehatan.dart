import 'package:flutter/material.dart';

class LaporanKesehatanPage extends StatelessWidget {
  const LaporanKesehatanPage({super.key});

  final List<Map<String, dynamic>> weeklyData = const [
    {'day': 'Senin', 'steps': 5234, 'calories': 300, 'bpm': 75},
    {'day': 'Selasa', 'steps': 6120, 'calories': 320, 'bpm': 72},
    {'day': 'Rabu', 'steps': 4890, 'calories': 280, 'bpm': 78},
    {'day': 'Kamis', 'steps': 7000, 'calories': 350, 'bpm': 80},
    {'day': 'Jumat', 'steps': 6567, 'calories': 330, 'bpm': 77},
    {'day': 'Sabtu', 'steps': 7345, 'calories': 360, 'bpm': 76},
    {'day': 'Minggu', 'steps': 5100, 'calories': 295, 'bpm': 74},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Kesehatan Mingguan')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: weeklyData.length,
        itemBuilder: (context, index) {
          final data = weeklyData[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(data['day']),
              subtitle: Text(
                'Langkah: ${data['steps']} | Kalori: ${data['calories']} kcal | BPM: ${data['bpm']}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}
