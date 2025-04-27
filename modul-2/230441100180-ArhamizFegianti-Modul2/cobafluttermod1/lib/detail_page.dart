import 'package:cobafluttermod1/model_data.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Wisata? place;
  const DetailPage({Key? key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFormCrud = place != null;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          isFormCrud ? place!.nama : 'National Park Yosemite',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      ),

      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  isFormCrud
                      ? Image.file(
                        place!.image,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                      : Image.asset(
                        'image.jpg',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.map_outlined),
                        const SizedBox(width: 3),
                        Text(
                          isFormCrud ? ' ${place!.jenis}' : ' Wisata Alam',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(width: 3),
                        Text(
                          isFormCrud ? ' ${place!.lokasi}' : ' California',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.more_outlined),
                    const SizedBox(width: 4),
                    Text(
                      isFormCrud ? ' ${place!.harga}' : ' 30000',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text(
              isFormCrud
                  ? place!.deskripsi
                  : 'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
