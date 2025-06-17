// utils/date_formatter.dart
String formatTanggal(String isoString) {
  final dateTime = DateTime.parse(isoString);
  final bulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  final tanggal = dateTime.day;
  final namaBulan = bulan[dateTime.month - 1];
  final tahun = dateTime.year;
  final jam = dateTime.hour.toString().padLeft(2, '0');
  final menit = dateTime.minute.toString().padLeft(2, '0');

  return '$tanggal $namaBulan $tahun, $jam:$menit';
}
