import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DetailPage(),
  ));
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        title: const Text(
          "National Park Yosemite",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'image/img1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Lorem ipsum est donec non interdum amet pharetra egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed massa neque amet turpis placerat in luctus ac eget egestas praesent congue semper in facilisis purus dui pharetra odio ullamcorper euismod a donec consectetur pellentesque sapien porta tincidunt non augue turpis massa egestas sapien fringilla nulla arcu ac turpis eros eget adipiscing dui lorem elit id ac auctor mattis urna fermentum facilisi sed augue sit purus eget magna aenean nulla placerat eget id platea lorem suspendisse ullamcorper pellentesque eget posuere tortor risus tortor consectetur et duis varius metus lacinia morbi scelerisque gravida egestas blandit tincidunt ullamcorper orci ut gravida egestas. Id dapibus est ut ipsum congue tortor at erat semper fames eleifend rhoncus quis varius pellentesque quam vulputate velit sit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
