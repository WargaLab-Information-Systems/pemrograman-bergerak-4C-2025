import 'package:flutter/material.dart';
import 'package:latihan_layout_navigation/latihan_navigation.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Layout'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const Text(
            'Static ListView',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // START TODO 1
          ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          subtitle: const Text('This is the home page'),
          trailing: const Icon(Icons.arrow_forward),
          ),

          ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          subtitle: const Text('This is the settings page'),
          trailing: const Icon(Icons.arrow_forward),
          ),
          // END TODO 1
          const SizedBox(height: 20),

          
          const Text(
            'ListView.builder (Vertical)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 300,
            // START TODO 2
            child: ListView.builder( 
            itemCount: 10, 
            itemBuilder: (context, index) { 
            return ListTile( 
            leading: const Icon(Icons.list),
            title: Text('Item $index'),
            subtitle: const Text('This is a list item'),
            trailing: const Icon(Icons.arrow_forward),
            ); 
            }, 
            ),
            // END TODO 2
          ),
          const SizedBox(height: 20),

          
          const Text(
            'Horizontal ListView',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 100,
            // START TODO 3
           child:  ListView.builder( 
          scrollDirection: Axis.horizontal, 
          itemCount: 5, 
          itemBuilder: (context, index) { 
          return Container( 
          width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Item $index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
          }, 
          ) 
            // END TODO 3
          ),
          const SizedBox(height: 20),

        
          const Text(
            'GridView',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 300,
            // START TODO 4
          child:  GridView.count( 
          
          crossAxisCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(6, (index) {
            return Card(
              color: Colors.teal[400],
              elevation: 4,
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.widgets, size: 40, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      'Item $index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          ),
            // END TODO 4
          ),

          const SizedBox(height: 20),
          const Text(
            'Navigation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // START TODO 5 : navigation.push
              Navigator.push( 
              context, 
              MaterialPageRoute(builder: (context) => NavigationPage()), 
              ); 
                // END TODO 5
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Pergi ke NavigationPage',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}