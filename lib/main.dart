import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart'; // برای HapticFeedback

// --- پکیج‌های پیشنهادی برای انیمیشن‌های خفن‌تر (در صورت تمایل اضافه و از کامنت خارج کنید) ---
// import 'package:lottie/lottie.dart'; // برای انیمیشن‌های Lottie
// import 'package:audioplayers/audioplayers.dart'; // برای افکت‌های صوتی

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // برای تمام صفحه کردن اپ (اختیاری)
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp());
}

//**********************************************************************
// کلاس اصلی اپلیکیشن
//**********************************************************************
class MyApp extends StatelessWidget {
  // تعریف پالت رنگی
  static const Color primaryColor = Color(0xFF4285F4); // آبی گوگل
  static const Color primaryVariantColor = Color(0xFF1A73E8);
  static const Color secondaryColor = Color(0xFF34A853); // سبز گوگل
  static const Color errorColor = Color(0xFFEA4335); // قرمز گوگل
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Colors.white;
  static const Color onPrimaryColor = Colors.white;
  static const Color onBackgroundColor = Color(0xFF202124);
  static const Color winColor = secondaryColor;
  static const Color drawColor = Color(0xFFFBBC04); // زرد گوگل
  static const Color ChoiceButtonBackground = Color(
    0xFFF1F3F4,
  ); // رنگ پس‌زمینه دکمه انتخاب

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سنگ کاغذ قیچی',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily:
            'Vazirmatn', // یا فونت فارسی دلخواه دیگر که به پروژه اضافه کرده‌اید
        brightness: Brightness.light,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          primaryContainer: primaryVariantColor, // سابقا primaryVariant
          secondary: secondaryColor,
          secondaryContainer: Color(0xFF188038), // سابقا secondaryVariant
          background: backgroundColor,
          surface: surfaceColor,
          error: errorColor,
          onPrimary: onPrimaryColor,
          onSecondary: onPrimaryColor,
          onBackground: onBackgroundColor,
          onSurface: onBackgroundColor,
          onError: onPrimaryColor,
        ),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: surfaceColor,
          foregroundColor: onBackgroundColor,
          elevation: 2.0,
          titleTextStyle: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: onBackgroundColor,
          ),
          iconTheme: IconThemeData(color: primaryColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor, // background
            foregroundColor: onPrimaryColor, // foreground
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(
              fontFamily: 'Vazirmatn',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 3,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: TextStyle(
              fontFamily: 'Vazirmatn',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
          color: surfaceColor,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: primaryColor.withOpacity(0.1),
          labelStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'Vazirmatn',
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          secondarySelectedColor: secondaryColor, // برای انتخاب
          selectedColor: primaryColor, // برای انتخاب
        ),
        textTheme: TextTheme(
          // تعریف استایل‌های متن فارسی
          headlineSmall: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: onBackgroundColor,
            fontFamily: 'Vazirmatn',
          ), // headline5
          titleLarge: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: onBackgroundColor,
            fontFamily: 'Vazirmatn',
          ), // headline6
          bodyLarge: TextStyle(
            fontSize: 17.0,
            color: onBackgroundColor.withOpacity(0.8),
            height: 1.6,
            fontFamily: 'Vazirmatn',
          ), // bodyText1
          bodyMedium: TextStyle(
            fontSize: 15.0,
            color: onBackgroundColor.withOpacity(0.7),
            height: 1.5,
            fontFamily: 'Vazirmatn',
          ), // bodyText2
          labelLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: onPrimaryColor,
            fontFamily: 'Vazirmatn',
          ), // button text
        ),
      ),
      home: HomePage(),
      // برای راست‌چین کردن کل برنامه
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}

//**********************************************************************
// صفحه اصلی (مدیریت‌کننده صفحات دیگر)
//**********************************************************************
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentPageIndex = 0; // 0: Intro, 1: Game, 2: Rules, 3: About
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // --- صدا (اختیاری) ---
  // final _audioPlayer = AudioPlayer();
  // Future<void> _playSound(String assetPath) async {
  //   try {
  //     await _audioPlayer.play(AssetSource(assetPath));
  //   } catch (e) {
  //     print("Error playing sound: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();

    // --- بارگذاری صداها (اختیاری) ---
    // _audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    // _audioPlayer.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    HapticFeedback.mediumImpact();
    // _playSound('sounds/ui_tap.mp3'); // صدای کلیک
    if (_currentPageIndex == index) return;
    _fadeController.reverse().then((_) {
      setState(() {
        _currentPageIndex = index;
      });
      _fadeController.forward();
    });
  }

  Widget _buildPage() {
    switch (_currentPageIndex) {
      case 0:
        return IntroPage(onStartGame: () => _navigateToPage(1));
      case 1:
        return RockPaperScissorsGame(); // صفحه بازی را مستقیم برمی‌گردانیم
      case 2:
        return RulesPage();
      case 3:
        return AboutPage();
      default:
        return IntroPage(onStartGame: () => _navigateToPage(1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentPageIndex == 1 ? 'بازی سنگ، کاغذ، قیچی!' : 'خوش آمدید!',
        ),
        centerTitle: true,
        actions: [
          if (_currentPageIndex != 0 &&
              _currentPageIndex !=
                  1) // دکمه بازگشت به خانه برای قوانین و درباره ما
            IconButton(
              icon: Icon(Icons.home_filled, color: MyApp.primaryColor),
              tooltip: "بازگشت به صفحه اصلی",
              onPressed: () => _navigateToPage(0),
            ),
          if (_currentPageIndex ==
              1) // دکمه‌های راهنما و درباره ما در صفحه بازی
            PopupMenuButton<int>(
              icon: Icon(Icons.more_vert_rounded, color: MyApp.primaryColor),
              onSelected: (value) => _navigateToPage(value),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(Icons.gavel_rounded, color: MyApp.primaryColor),
                          SizedBox(width: 8),
                          Text('قوانین بازی'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: MyApp.primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text('درباره ما'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app_rounded,
                            color: MyApp.errorColor,
                          ),
                          SizedBox(width: 8),
                          Text('خروج از بازی'),
                        ],
                      ),
                    ),
                  ],
            ),
        ],
      ),
      body: FadeTransition(opacity: _fadeAnimation, child: _buildPage()),
      bottomNavigationBar:
          _currentPageIndex !=
                  1 // نوار پایین برای صفحات غیر از بازی
              ? BottomNavigationBar(
                currentIndex:
                    _currentPageIndex == 0
                        ? 0
                        : (_currentPageIndex == 2 ? 1 : 2), // تنظیم ایندکس صحیح
                onTap: (index) {
                  if (index == 0)
                    _navigateToPage(0); // خانه
                  else if (index == 1)
                    _navigateToPage(2); // قوانین
                  else if (index == 2)
                    _navigateToPage(3); // درباره ما
                },
                backgroundColor: MyApp.surfaceColor,
                selectedItemColor: MyApp.primaryColor,
                unselectedItemColor: MyApp.onBackgroundColor.withOpacity(0.6),
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Vazirmatn',
                ),
                unselectedLabelStyle: TextStyle(fontFamily: 'Vazirmatn'),
                elevation: 8.0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'خانه',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.gavel_rounded),
                    label: 'قوانین',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info_rounded),
                    label: 'درباره',
                  ),
                ],
              )
              : null, // در صفحه بازی نوار پایین نداریم
    );
  }
}

//**********************************************************************
// صفحه معرفی (Intro)
//**********************************************************************
class IntroPage extends StatelessWidget {
  final VoidCallback onStartGame;
  IntroPage({required this.onStartGame});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- انیمیشن Lottie خوش‌آمدگویی (اختیاری) ---
          // SizedBox(
          //   height: 180,
          //   child: Lottie.asset('assets/animations/welcome_rps.json', fit: BoxFit.contain),
          // ),
          // یا یک تصویر گرافیکی:
          Icon(
            Icons.sports_esports_rounded,
            size: 120,
            color: MyApp.primaryColor.withOpacity(0.8),
          ),
          SizedBox(height: 24),
          Text(
            'به بازی سنگ، کاغذ، قیچی خوش آمدید!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          Text(
            'یک بازی کلاسیک و سرگرم‌کننده برای محک زدن شانس و استراتژی شما. آماده‌ای؟',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 40),
          ElevatedButton.icon(
            icon: Icon(Icons.play_circle_fill_rounded, size: 28),
            label: Text('بزن بریم شروع کنیم!', style: TextStyle(fontSize: 18)),
            onPressed: onStartGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: MyApp.secondaryColor,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}

//**********************************************************************
// صفحه قوانین (Rules)
//**********************************************************************
class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'قوانین بازی چطوریه؟ 🤔',
            style: textTheme.titleLarge?.copyWith(color: MyApp.primaryColor),
          ),
          SizedBox(height: 16),
          _buildRuleItem(
            context,
            '🪨',
            'سنگ',
            'قیچی رو میشکنه!',
            Icons.hardware_rounded,
          ),
          _buildRuleItem(
            context,
            '📄',
            'کاغذ',
            'سنگ رو میپوشونه!',
            Icons.article_rounded,
          ),
          _buildRuleItem(
            context,
            '✂️',
            'قیچی',
            'کاغذ رو میبره!',
            Icons.content_cut_rounded,
          ),
          SizedBox(height: 20),
          Text(
            'نکات بازی:',
            style: textTheme.titleLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          _buildTipItem(
            context,
            'انتخاب کنید: یکی از سه گزینه سنگ، کاغذ یا قیچی رو انتخاب کن.',
          ),
          _buildTipItem(
            context,
            'نتیجه: برنده کسیه که انتخابش بر حریف غلبه کنه.',
          ),
          _buildTipItem(
            context,
            'مساوی: اگه هر دو یک گزینه رو انتخاب کنید، نتیجه مساویه و دور تکرار نمیشه (مگر اینکه خودتون بخواید دوباره بازی کنید).',
          ),
          _buildTipItem(
            context,
            'امتیازدهی: هر برد یک امتیاز داره. ببینیم کی بیشتر امتیاز میگیره!',
          ),
          SizedBox(height: 24),
          Center(
            child: Text(
              '✨ موفق و پیروز باشی! ✨',
              style: textTheme.bodyLarge?.copyWith(
                color: MyApp.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleItem(
    BuildContext context,
    String emoji,
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(emoji, style: TextStyle(fontSize: 36)),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Icon(icon, size: 30, color: MyApp.primaryColor.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 20,
            color: MyApp.secondaryColor,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

//**********************************************************************
// صفحه درباره ما (About)
//**********************************************************************
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- لوگو یا انیمیشن Lottie (اختیاری) ---
          // SizedBox(
          //   height: 120,
          //   child: Lottie.asset('assets/animations/developer_icon.json'),
          // ),
          // یا:
          CircleAvatar(
            radius: 50,
            backgroundColor: MyApp.primaryColor.withOpacity(0.1),
            child: Icon(
              Icons.sentiment_very_satisfied_rounded,
              size: 60,
              color: MyApp.primaryColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'درباره این بازی باحال 😎',
            style: textTheme.titleLarge?.copyWith(color: MyApp.primaryColor),
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'این بازی سنگ، کاغذ، قیچی با عشق و فلاتر توسط گروه احسان محمدی ساخته شده! هدف ما ایجاد یک تجربه سرگرم‌کننده و روان با طراحی مدرن متریال بود. امیدواریم از بازی لذت ببرید.\n\nنسخه: 1.0.0 - Pixel Edition\n\nایده‌ها و پیشنهادات شما همیشه مورد استقبال ماست.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'ساخته شده با:',
            style: textTheme.titleLarge?.copyWith(fontSize: 18),
          ),
          SizedBox(height: 8),
          FlutterLogo(size: 60),
          SizedBox(height: 24),
          Text(
            'ما رو دنبال کنید (الکی مثلاً 😉):',
            style: textTheme.bodyMedium,
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.alternate_email_rounded,
                  color: MyApp.primaryColor,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.public_rounded, color: MyApp.primaryColor),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//**********************************************************************
// صفحه اصلی بازی سنگ، کاغذ، قیچی
//**********************************************************************
class RockPaperScissorsGame extends StatefulWidget {
  @override
  _RockPaperScissorsGameState createState() => _RockPaperScissorsGameState();
}

class _RockPaperScissorsGameState extends State<RockPaperScissorsGame>
    with TickerProviderStateMixin {
  String? _playerChoiceEmoji;
  String? _computerChoiceEmoji;
  String _resultText = 'انتخاب کن تا بازی شروع بشه!';
  Color _resultColor = MyApp.onBackgroundColor;

  int _userWins = 0;
  int _computerWins = 0;
  int _draws = 0;

  final List<Map<String, String>> _history = [];

  final Map<String, Map<String, dynamic>> _choices = {
    '🪨': {
      'label': 'سنگ',
      'icon': Icons.brightness_1_outlined,
    }, // استفاده از آیکون به جای ایموجی در دکمه
    '📄': {'label': 'کاغذ', 'icon': Icons.wysiwyg_rounded},
    '✂️': {'label': 'قیچی', 'icon': Icons.content_cut_outlined},
  };

  // --- انیمیشن کنترلرها ---
  late AnimationController _resultAnimationController;
  late Animation<double> _resultScaleAnimation;
  late AnimationController _choiceButtonController;
  late AnimationController _scoreUpdateController;
  late Animation<double> _scoreScaleAnimation;

  // --- صدا (اختیاری) ---
  // final _audioPlayerGame = AudioPlayer();
  // Future<void> _playGameSound(String assetPath) async {
  //   try {
  //     await _audioPlayerGame.play(AssetSource(assetPath));
  //   } catch (e) {
  //     print("Error playing game sound: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _resultAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _resultScaleAnimation = CurvedAnimation(
      parent: _resultAnimationController,
      curve: Curves.elasticOut,
    );

    _choiceButtonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    _scoreUpdateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scoreScaleAnimation = CurvedAnimation(
      parent: _scoreUpdateController,
      curve: Curves.bounceOut,
    );

    // --- بارگذاری صداهای بازی (اختیاری) ---
    // _audioPlayerGame.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    _resultAnimationController.dispose();
    _choiceButtonController.dispose();
    _scoreUpdateController.dispose();
    // _audioPlayerGame.dispose();
    super.dispose();
  }

  void _playGame(String playerEmoji) {
    HapticFeedback.heavyImpact();
    // _playGameSound('sounds/player_choice.mp3');

    final random = Random();
    final compEmoji = _choices.keys.toList()[random.nextInt(3)];

    String gameResultText;
    Color gameResultColor;
    String resultEmoji = '';

    int prevUserWins = _userWins;
    int prevComputerWins = _computerWins;
    int prevDraws = _draws;

    if (playerEmoji == compEmoji) {
      gameResultText = 'مساوی شد! 🤝';
      gameResultColor = MyApp.drawColor;
      resultEmoji = '🤝';
      _draws++;
      // _playGameSound('sounds/draw_sound.mp3');
    } else if ((playerEmoji == '🪨' && compEmoji == '✂️') ||
        (playerEmoji == '📄' && compEmoji == '🪨') ||
        (playerEmoji == '✂️' && compEmoji == '📄')) {
      gameResultText = 'تو بردی! 🎉';
      gameResultColor = MyApp.winColor;
      resultEmoji = '🎉';
      _userWins++;
      // _playGameSound('sounds/win_sound.mp3');
    } else {
      gameResultText = 'کامپیوتر برد! 😬';
      gameResultColor = MyApp.errorColor;
      resultEmoji = '😬';
      _computerWins++;
      // _playGameSound('sounds/lose_sound.mp3');
    }

    setState(() {
      _playerChoiceEmoji = playerEmoji;
      _computerChoiceEmoji = compEmoji;
      _resultText = gameResultText;
      _resultColor = gameResultColor;
      _history.insert(0, {
        'player': playerEmoji,
        'computer': compEmoji,
        'result': resultEmoji,
        'player_label': _choices[playerEmoji]!['label'] as String,
        'computer_label': _choices[compEmoji]!['label'] as String,
      });
      if (_history.length > 5) _history.removeLast(); // محدود کردن تاریخچه
    });

    _resultAnimationController.forward(from: 0.0);

    // انیمیشن برای آپدیت امتیاز
    if (_userWins != prevUserWins ||
        _computerWins != prevComputerWins ||
        _draws != prevDraws) {
      _scoreUpdateController.forward(from: 0.0);
    }
  }

  void _resetRound() {
    HapticFeedback.lightImpact();
    setState(() {
      _playerChoiceEmoji = null;
      _computerChoiceEmoji = null;
      _resultText = 'دوباره انتخاب کن!';
      _resultColor = MyApp.onBackgroundColor;
    });
  }

  void _resetGameStats() {
    HapticFeedback.mediumImpact();
    // _playGameSound('sounds/reset_all_game.mp3');
    setState(() {
      _userWins = 0;
      _computerWins = 0;
      _draws = 0;
      _history.clear();
      _resetRound();
      _resultText = 'بازی از نو شروع شد!';
    });
  }

  Widget _buildChoiceButton(String emojiKey) {
    final choiceData = _choices[emojiKey]!;
    final bool isSelected =
        _playerChoiceEmoji == emojiKey &&
        _computerChoiceEmoji != null; // انتخاب شده و نتیجه آمده

    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => _choiceButtonController.forward(),
        onTapUp: (_) => _choiceButtonController.reverse(),
        onTapCancel: () => _choiceButtonController.reverse(),
        onTap: () => _playGame(emojiKey),
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1.0,
            end: 0.92,
          ).animate(_choiceButtonController),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: 6),
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: MyApp.ChoiceButtonBackground,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: isSelected ? MyApp.primaryColor : Colors.grey.shade300,
                width: isSelected ? 2.5 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isSelected ? 0.15 : 0.08),
                  blurRadius: isSelected ? 8 : 5,
                  offset: Offset(0, isSelected ? 4 : 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emojiKey, style: TextStyle(fontSize: 38)),
                SizedBox(height: 8),
                Text(
                  choiceData['label'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyApp.onBackgroundColor.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreChip(
    String label,
    int score,
    Color color, {
    bool animate = false,
  }) {
    Widget content = Chip(
      avatar: CircleAvatar(
        backgroundColor: color.withOpacity(0.8),
        child: Text(
          '$score',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      label: Text(label),
      backgroundColor: color.withOpacity(0.15),
      labelStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontFamily: 'Vazirmatn',
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );

    if (animate) {
      return ScaleTransition(scale: _scoreScaleAnimation, child: content);
    }
    return content;
  }

  Widget _buildPlayerDisplay(String title, String? emoji, Color bgColor) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color:
                emoji != null
                    ? bgColor.withOpacity(0.15)
                    : Colors.grey.shade200,
            shape: BoxShape.circle,
            border: Border.all(
              color: emoji != null ? bgColor : Colors.grey.shade300,
              width: 2.5,
            ),
          ),
          child: Center(
            child:
                emoji != null
                    ? Text(emoji, style: TextStyle(fontSize: 40))
                    : Icon(
                      Icons.hourglass_empty_rounded,
                      size: 30,
                      color: Colors.grey.shade400,
                    ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // امتیازات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildScoreChip(
                'شما 🎉',
                _userWins,
                MyApp.winColor,
                animate: true,
              ),
              _buildScoreChip(
                'مساوی 🤝',
                _draws,
                MyApp.drawColor,
                animate: true,
              ),
              _buildScoreChip(
                'کامپیوتر 😬',
                _computerWins,
                MyApp.errorColor,
                animate: true,
              ),
            ],
          ),
          SizedBox(height: 24),

          // نمایش انتخاب‌ها
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPlayerDisplay(
                  'انتخاب شما',
                  _playerChoiceEmoji,
                  MyApp.primaryColor,
                ),
                ScaleTransition(
                  // انیمیشن برای نتیجه کلی
                  scale: _resultScaleAnimation,
                  child: Icon(
                    Icons.compare_arrows_rounded,
                    size: 36,
                    color: _resultColor,
                  ),
                ),
                _buildPlayerDisplay(
                  'انتخاب کامپیوتر',
                  _computerChoiceEmoji,
                  MyApp.errorColor,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // نمایش متن نتیجه
          ScaleTransition(
            scale: _resultScaleAnimation,
            child: Text(
              _resultText,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(
                color: _resultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 24),

          // دکمه‌های انتخاب
          if (_playerChoiceEmoji ==
              null) // فقط وقتی هنوز انتخابی نشده یا دور ریست شده
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  _choices.keys.map((key) => _buildChoiceButton(key)).toList(),
            )
          else // دکمه بازی مجدد دور
            ElevatedButton.icon(
              icon: Icon(Icons.refresh_rounded),
              label: Text('بازی مجدد این دور'),
              onPressed: _resetRound,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyApp.secondaryColor,
              ),
            ),
          SizedBox(height: 20),

          // تاریخچه بازی
          if (_history.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'آخرین نتایج:',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final item = _history[index];
                    Color histResultColor = MyApp.onBackgroundColor;
                    if (item['result'] == '🎉')
                      histResultColor = MyApp.winColor;
                    else if (item['result'] == '😬')
                      histResultColor = MyApp.errorColor;
                    else if (item['result'] == '🤝')
                      histResultColor = MyApp.drawColor;

                    return Card(
                      elevation: 1.5,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Text(
                          item['player']!,
                          style: TextStyle(fontSize: 28),
                        ),
                        title: Text(
                          'شما: ${item['player_label']} مقابل کامپیوتر: ${item['computer_label']}',
                          style: textTheme.bodyMedium?.copyWith(fontSize: 13.5),
                        ),
                        trailing: Text(
                          item['result']!,
                          style: TextStyle(
                            fontSize: 28,
                            color: histResultColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12),
              ],
            ),

          // دکمه ریست کامل بازی
          TextButton.icon(
            icon: Icon(Icons.delete_sweep_rounded, color: MyApp.errorColor),
            label: Text(
              'شروع مجدد کل بازی',
              style: TextStyle(color: MyApp.errorColor),
            ),
            onPressed: _resetGameStats,
          ),
          SizedBox(height: 10), // فضای اضافی در پایین
        ],
      ),
    );
  }
}
