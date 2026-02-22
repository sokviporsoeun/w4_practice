import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Taps'),
        centerTitle: true,
      ),
      
      body: Column(
        children: CardType.values.map((type) => ColorTap(type: type)).toList(),
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, _) {
        return GestureDetector(
          onTap: () => colorService.increment(type),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: type.color,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: ${colorService.getTapCount(type)}',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics'),
      centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: colorService.tapCounts.entries
                  .map(
                    (entry) => Text(
                      'Number of ${entry.key.label}'
                      ' = ${entry.value}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

enum CardType { red, green, yellow, blue }

extension CardTypeExtension on CardType {
  Color get color {
    switch (this) {
      case CardType.red:
        return Colors.red;
      case CardType.green:
        return Colors.green;
      case CardType.yellow:
        return Colors.yellow;
      case CardType.blue:
        return Colors.blue;
    }
  }

  String get label {
    switch (this) {
      case CardType.red:
        return 'red';
      case CardType.green:
        return 'green';
      case CardType.yellow:
        return 'yellow';
      case CardType.blue:
        return 'blue';
    }
  }
}

final colorService = ColorService();

class ColorService extends ChangeNotifier {
  final Map<CardType, int> _tapCounts = {
    CardType.red: 0,
    CardType.green: 0,
    CardType.yellow: 0,
    CardType.blue: 0,
  };

  Map<CardType, int> get tapCounts => Map.unmodifiable(_tapCounts);

  int getTapCount(CardType type) => _tapCounts[type]!;

  void increment(CardType type) {
    _tapCounts[type] = _tapCounts[type]! + 1;
    notifyListeners();
  }
}


//service color provider