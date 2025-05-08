import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: DetailPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back & Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "National Park Yosemite",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),

              // Gambar utama
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "image/home.jpg",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),

              // Deskripsi panjang
              const Text(
                "Lorem ipsum est doace non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus "
                "ad ullamcorper at vestibulum sed nunc magna amet turpis placerat in luctus at eget egestas proaca congue "
                "semper in facilisis purus ele pharetra odio ullamcorper euismod a donec consectetur pellentesque parturient "
                "enim proin tincidunt non congue turpis magna euismod quis lorem eu feugiat ornare id eros sed eget adipiscing "
                "dolor massa mi sit a eu auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse sapien turpis "
                "pellentesque id quis risus donec habitasse ullamcorper interdum eget placerat tortor eros nulla consectetur "
                "et dui viverra mattis vitae scelerisque gravida egestas habitant tincidunt ullamcorper placerat ultricies in "
                "urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus massa tincidunt pellentesque "
                "quam neque vitae eu velit leo massa pulvinar velit pellentesque cursus laoreet donec diam id vulputate nisi "
                "integer eget gravida volutpat.",
                style: TextStyle(fontSize: 14, height: 1.5),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
