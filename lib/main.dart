import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سنگ کاغذ قیچی',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'sans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  int _currentPage = 0; // 0 = Intro, 1 = Rules, 2 = About, 3 = Game

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildIntroPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Text(
              'بازی سنگ، کاغذ، قیچی!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _currentPage = 3;
              });
            },
            icon: Icon(Icons.play_arrow),
            label: Text('شروع بازی'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade400,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.2, 0.5, curve: Curves.easeOutBack),
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentPage = 1;
                      });
                    },
                    icon: Icon(Icons.rule),
                    label: Text('قوانین'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade300,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.3, 0.6, curve: Curves.easeOutBack),
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentPage = 2;
                      });
                    },
                    icon: Icon(Icons.info_outline),
                    label: Text('درباره ما'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade300,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRulesPage() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Text(
                'قوانین بازی',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '۱. هر بازیکن یکی از سه گزینه را انتخاب می‌کند: \n\n'
                '🪨 سنگ > ✂️ قیچی\n'
                '📄 کاغذ > 🪨 سنگ\n'
                '✂️ قیچی > 📄 کاغذ\n\n'
                '۲. برنده کسی است که گزینه او بر گزینه حریف غلبه کند.\n\n'
                '۳. در صورت تساوی، دور مجدد انجام می‌شود.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.4, 0.7, curve: Curves.easeOutBack),
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentPage = 0;
                      });
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('بازگشت'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.5, 0.8, curve: Curves.easeOutBack),
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentPage = 2;
                      });
                    },
                    icon: Icon(Icons.info_outline),
                    label: Text('درباره ما'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAboutPage() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Text(
                'درباره ما',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'این بازی توسط گروه احسان محمدی فوق‌العاده عالی 😎 با Flutter نوشته شده!\n\n'
                'نسخه: 0.1.0\n'
                'ساخته شده باحرفه‌ای‌ترین حالت ممکن\n'
                'ممنون از نگاه‌داشتن این بازی و حمایت شما!\n\n',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.4, 0.7, curve: Curves.easeOutBack),
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentPage = 0;
                      });
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('بازگشت'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.5, 0.8, curve: Curves.easeOutBack),
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentPage = 1;
                      });
                    },
                    icon: Icon(Icons.rule),
                    label: Text('قوانین'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPage == 3) {
      return RockPaperScissorsGame(
        onBackToMenu: () {
          setState(() {
            _currentPage = 0;
          });
        },
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.cyan.shade50,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            layoutBuilder:
                (widget, list) => Stack(children: [widget!, ...list]),
            child:
                _currentPage == 0
                    ? buildIntroPage()
                    : _currentPage == 1
                    ? buildRulesPage()
                    : buildAboutPage(),
          ),
        ),
      ),
    );
  }
}

// --- صفحه اصلی بازی ---
class RockPaperScissorsGame extends StatefulWidget {
  final VoidCallback onBackToMenu;

  RockPaperScissorsGame({required this.onBackToMenu});

  @override
  _RockPaperScissorsGameState createState() => _RockPaperScissorsGameState();
}

class _RockPaperScissorsGameState extends State<RockPaperScissorsGame>
    with SingleTickerProviderStateMixin {
  String _playerChoice = '';
  String _computerChoice = '';
  String _result = '';

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  int _userWins = 0;
  int _computerWins = 0;
  int _draws = 0;

  final List<String> _history = [];

  final Map<String, String> _choices = {
    '🪨': 'سنگ',
    '📄': 'کاغذ',
    '✂️': 'قیچی',
  };

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  void _playGame(String emoji) {
    final random = Random();
    final compEmoji = _choices.keys.toList()[random.nextInt(3)];

    String result;
    if (emoji == compEmoji) {
      result = 'مساوی شد!';
      _draws++;
    } else if ((emoji == '🪨' && compEmoji == '✂️') ||
        (emoji == '📄' && compEmoji == '🪨') ||
        (emoji == '✂️' && compEmoji == '📄')) {
      result = 'شما بردید 🎉';
      _userWins++;
    } else {
      result = 'کامپیوتر برد 😢';
      _computerWins++;
    }

    setState(() {
      _playerChoice = emoji;
      _computerChoice = compEmoji;
      _result = result;
      _history.insert(0, "$emoji - $compEmoji ➜ $result");
    });

    _controller.forward(from: 0);
  }

  void _resetGame() {
    setState(() {
      _playerChoice = '';
      _computerChoice = '';
      _result = '';
    });
    _controller.forward(from: 0);
  }

  void _clearAll() {
    setState(() {
      _userWins = 0;
      _computerWins = 0;
      _draws = 0;
      _history.clear();
      _playerChoice = '';
      _computerChoice = '';
      _result = '';
    });
    _controller.forward(from: 0);
  }

  Widget _buildChoiceButton(String emoji, String label) {
    final bool isSelected = _playerChoice == emoji;
    return Expanded(
      child: GestureDetector(
        onTap: () => _playGame(emoji),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.cyan.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Colors.teal.shade400
                            : Colors.grey.shade200,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(emoji, style: TextStyle(fontSize: 48)),
                ),
              ),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int count, Color color) {
    return Expanded(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Chip(
          backgroundColor: color.withOpacity(0.2),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: TextStyle(color: color)),
              SizedBox(width: 4),
              Text('$count', style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.cyan.shade50,
        appBar: AppBar(
          title: const Text('سنگ، کاغذ، قیچی'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.teal),
            onPressed: widget.onBackToMenu,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // شمارنده‌ها
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCounter("برد", _userWins, Colors.green),
                  _buildCounter("باخت", _computerWins, Colors.red),
                  _buildCounter("مساوی", _draws, Colors.orange),
                ],
              ),

              SizedBox(height: 20),

              Text(
                'یک گزینه انتخاب کن:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),

              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    _choices.entries
                        .map((e) => _buildChoiceButton(e.key, e.value))
                        .toList(),
              ),

              SizedBox(height: 32),

              if (_playerChoice.isNotEmpty || _computerChoice.isNotEmpty)
                FadeTransition(
                  opacity: _scaleAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'شما',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              _playerChoice,
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'کامپیوتر',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              _computerChoice,
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 20),

              if (_result.isNotEmpty)
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Text(
                    _result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:
                          _result.contains("بردید")
                              ? Colors.green
                              : _result.contains("مساوی")
                              ? Colors.orange
                              : Colors.red,
                    ),
                  ),
                ),

              SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                            (index / _history.length),
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                      child: Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.history, color: Colors.teal),
                          title: Text(
                            _history[index],
                            style: TextStyle(color: Colors.teal),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: ElevatedButton.icon(
                        onPressed: _resetGame,
                        icon: Icon(Icons.refresh),
                        label: Text('ریست دور فعلی'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey.shade200,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: ElevatedButton.icon(
                        onPressed: _clearAll,
                        icon: Icon(Icons.delete_forever),
                        label: Text('حذف کلی'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade200,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
