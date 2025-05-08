import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "National Park Yosemite",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFE2E2E2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      backgroundColor: Color(0xFFE2E2E2),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "lib/images/gambar.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.",
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}