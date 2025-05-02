class WisataModel {
  final String nama;
  final String lokasi;
  final String jenis;
  final String harga;
  final String deskripsi;
  final String imagePath;

  WisataModel({
    required this.nama,
    required this.lokasi,
    required this.jenis,
    required this.harga,
    required this.deskripsi,
    required this.imagePath,
  });

  static List<WisataModel> dummyData = List.generate(
  5,
  (index) => WisataModel(
      nama: 'National Park Yosemite',
      lokasi: 'California',
      jenis: 'Wisata Alam',
      harga: '30.000,00',
      deskripsi: 'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.',
      imagePath: 'assets/images/alam.png',
  ),
);
}
