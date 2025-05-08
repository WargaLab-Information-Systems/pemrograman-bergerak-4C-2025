import 'package:flutter/material.dart';
void main(){
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
        backgroundColor: const Color.fromARGB(255, 229, 213, 213),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "National Park Yosemite",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/FotoAll.jpg',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.nature_people_outlined),
                    SizedBox(width: 6),
                    Text("Wisata Alam"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.price_change_outlined),
                    SizedBox(width: 6),
                    Text("30.000,00"),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.location_on_outlined, size: 20),
                SizedBox(width: 4),
                Text("California"),
              ],
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  "Lorem ipsum est donec non interdum amet pharetra egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed massa neque amet turpis placerat in luctus ac eget egestas praesent congue semper in facilisis purus dui pharetra odio ullamcorper euismod a donec consectetur pellentesque sapien porta tincidunt non augue turpis massa egestas sapien fringilla nulla arcu ac turpis eros eget adipiscing dui lorem elit id ac auctor mattis urna fermentum facilisi sed augue sit purus eget magna aenean nulla placerat eget id platea lorem suspendisse ullamcorper pellentesque eget posuere tortor risus tortor consectetur et duis varius metus lacinia morbi scelerisque gravida egestas blandit tincidunt ullamcorper orci ut gravida egestas. Id dapibus est ut ipsum congue tortor at erat semper fames eleifend rhoncus quis varius pellentesque quam vulputate velit sit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.",
                  style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                  textAlign: TextAlign.justify,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
