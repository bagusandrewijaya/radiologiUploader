


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationRailExample extends StatefulWidget {
  @override
  _NavigationRailExampleState createState() => _NavigationRailExampleState();
}

class _NavigationRailExampleState extends State<NavigationRailExample> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.pageview),
                label: Text('Halaman 1'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.pageview),
                label: Text('Halaman 2'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.pageview),
                label: Text('Halaman 3'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) {
                    return _getPageForIndex(_selectedIndex, context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPageForIndex(int index, BuildContext context) {
    switch (index) {
      case 0:
        return Halaman1(
          onNavigateToHalaman4: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Halaman4()));
          },
        );
      case 1:
        return Center(child: Text('Halaman 2'));
      case 2:
        return Center(child: Text('Halaman 3'));
      default:
        return Container();
    }
  }
}

class Halaman1 extends StatelessWidget {
  final VoidCallback onNavigateToHalaman4;

  Halaman1({@required this.onNavigateToHalaman4});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Halaman 1'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNavigateToHalaman4,
            child: Text('Pergi ke Halaman 4'),
          ),
        ],
      ),
    );
  }
}

class Halaman4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman 4'),
      ),
      body: Center(
        child: Text('Ini adalah Halaman 4'),
      ),
    );
  }
}