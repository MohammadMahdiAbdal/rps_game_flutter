import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart'; // برای HapticFeedback

// --- پکیج‌های پیشنهادی (باید به pubspec.yaml اضافه شوند) ---
// import 'package:lottie/lottie.dart'; // flutter pub add lottie
// import 'package:audioplayers/audioplayers.dart'; // flutter pub add audioplayers
// import 'package:sensors_plus/sensors_plus.dart'; // flutter pub add sensors_plus (برای افکت لرزش با شتاب‌سنج - اختیاری)

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//**********************************************************************
// کلاس اصلی اپلیکیشن
//**********************************************************************
class MyApp extends StatelessWidget {
  // پالت رنگی مشابه نسخه پیکسل گوگل با کمی تغییرات
  static const Color primaryColor = Color(0xFF3A82F8); // آبی گوگل کمی روشن‌تر
  static const Color primaryVariantColor = Color(0xFF1A73E8);
  static const Color secondaryColor = Color(0xFF34A853); // سبز گوگل
  static const Color errorColor = Color(0xFFEA4335); // قرمز گوگل
  static const Color backgroundColor = Color(0xFFF0F2F5); // پس‌زمینه روشن‌تر
  static const Color surfaceColor = Colors.white;
  static const Color onPrimaryColor = Colors.white;
  static const Color onBackgroundColor = Color(0xFF1F2023); // متن تیره‌تر
  static const Color winColor = secondaryColor;
  static const Color drawColor = Color(0xFFFBBC04); // زرد گوگل
  static const Color choiceButtonBorder = Color(0xFFDADCE0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سنگ کاغذ قیچی خفن',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Vazirmatn',
        brightness: Brightness.light,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          primaryContainer: primaryVariantColor,
          secondary: secondaryColor,
          secondaryContainer: Color(0xFF188038),
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
          elevation: 1.5, // سایه کمتر
          titleTextStyle: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: onBackgroundColor,
          ),
          iconTheme: IconThemeData(color: primaryColor),
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: onPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 13),
            textStyle: TextStyle(
              fontFamily: 'Vazirmatn',
              fontSize: 16.5,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 2.5,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: TextStyle(
              fontFamily: 'Vazirmatn',
              fontSize: 15.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          margin: EdgeInsets.symmetric(vertical: 7.0),
          color: surfaceColor,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: primaryColor.withOpacity(0.1),
          labelStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'Vazirmatn',
          ),
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
            color: onBackgroundColor,
            fontFamily: 'Vazirmatn',
          ),
          titleLarge: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.w600,
            color: onBackgroundColor,
            fontFamily: 'Vazirmatn',
          ),
          bodyLarge: TextStyle(
            fontSize: 17.5,
            color: onBackgroundColor.withOpacity(0.8),
            height: 1.55,
            fontFamily: 'Vazirmatn',
          ),
          bodyMedium: TextStyle(
            fontSize: 15.5,
            color: onBackgroundColor.withOpacity(0.7),
            height: 1.45,
            fontFamily: 'Vazirmatn',
          ),
          labelLarge: TextStyle(
            fontSize: 16.5,
            fontWeight: FontWeight.w500,
            color: onPrimaryColor,
            fontFamily: 'Vazirmatn',
          ),
        ),
        // انیمیشن انتقال صفحه نرم‌تر
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: HomePage(),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}

//**********************************************************************
// صفحه اصلی (مدیریت‌کننده صفحات)
//**********************************************************************
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentPageIndex = 0; // 0: Intro, 1: Game, 2: Rules, 3: About
  late AnimationController _pageTransitionController;
  late Animation<Offset> _slideAnimation;

  // --- صدا (اختیاری) ---
  // final AudioPlayer _audioPlayer = AudioPlayer();
  // Future<void> _playSound(String assetPath, {double volume = 0.8}) async {
  //   try {
  //     await _audioPlayer.setVolume(volume);
  //     await _audioPlayer.play(AssetSource(assetPath)); // مثال: 'sounds/ui_click.mp3'
  //   } catch (e) {
  //     print("Error playing sound: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _pageTransitionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350), // سرعت انتقال کمتر
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _pageTransitionController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _pageTransitionController.forward(); // برای اولین صفحه

    // --- بارگذاری صداها (اختیاری) ---
    // _audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    _pageTransitionController.dispose();
    // _audioPlayer.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    HapticFeedback.mediumImpact();
    // _playSound('sounds/ui_transition.mp3');
    if (_currentPageIndex == index) return;

    _pageTransitionController.reverse().then((_) {
      setState(() {
        _currentPageIndex = index;
      });
      // تنظیم انیمیشن بر اساس جهت حرکت
      _slideAnimation = Tween<Offset>(
        begin: Offset(
          index > _currentPageIndex ? 1.0 : -1.0,
          0.0,
        ), // اگر به صفحه جلوتر می‌رویم از راست، وگرنه از چپ
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _pageTransitionController,
          curve: Curves.easeInOutCubic,
        ),
      );
      _pageTransitionController.forward(from: 0.0);
    });
  }

  Widget _buildPage() {
    switch (_currentPageIndex) {
      case 0:
        return IntroPage(onStartGame: () => _navigateToPage(1));
      case 1:
        return RockPaperScissorsGame();
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
          _currentPageIndex == 1 ? 'بجنگ تا پیروز شی!' : 'سنگ، کاغذ، قیچی',
        ),
        centerTitle: true,
        // افکت گرادیانت برای AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyApp.surfaceColor,
                MyApp.primaryColor.withOpacity(0.05),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          if (_currentPageIndex != 0 && _currentPageIndex != 1)
            IconButton(
              icon: Icon(Icons.home_outlined, color: MyApp.primaryColor),
              tooltip: "بازگشت به خانه",
              onPressed: () => _navigateToPage(0),
            ),
          if (_currentPageIndex == 1)
            IconButton(
              icon: Icon(Icons.settings_outlined, color: MyApp.primaryColor),
              tooltip: "تنظیمات (بزودی!)",
              onPressed: () {
                /* برای تنظیمات آینده */
              },
            ),
        ],
      ),
      body: SlideTransition(position: _slideAnimation, child: _buildPage()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _navigateToPage,
        backgroundColor: MyApp.surfaceColor,
        selectedItemColor: MyApp.primaryColor,
        unselectedItemColor: MyApp.onBackgroundColor.withOpacity(0.55),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Vazirmatn',
          fontSize: 12.5,
        ),
        unselectedLabelStyle: TextStyle(fontFamily: 'Vazirmatn', fontSize: 12),
        type: BottomNavigationBarType.fixed, // برای نمایش همه لیبل‌ها
        elevation: 5.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch_outlined),
            activeIcon: Icon(Icons.rocket_launch),
            label: 'شروع',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports_outlined),
            activeIcon: Icon(Icons.sports_esports),
            label: 'بازی',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rule_folder_outlined),
            activeIcon: Icon(Icons.rule_folder),
            label: 'قوانین',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            activeIcon: Icon(Icons.auto_awesome),
            label: 'درباره',
          ),
        ],
      ),
    );
  }
}

//**********************************************************************
// صفحه معرفی (Intro)
//**********************************************************************
class IntroPage extends StatefulWidget {
  final VoidCallback onStartGame;
  IntroPage({required this.onStartGame});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200), // انیمیشن طولانی‌تر
    )..forward();
    _bounceAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ); // افکت فنری
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // گرادیانت برای پس‌زمینه صفحه معرفی
        gradient: LinearGradient(
          colors: [MyApp.backgroundColor, MyApp.primaryColor.withOpacity(0.15)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScaleTransition(
              scale: _bounceAnimation,
              // --- استفاده از Lottie برای آیکون اصلی (پیشنهادی) ---
              // child: SizedBox(
              //   height: 160,
              //   child: Lottie.asset('assets/lottie/rps_main_icon.json'),
              // ),
              // یا آیکون فعلی:
              child: Icon(
                Icons.emoji_people_rounded,
                size: 130,
                color: MyApp.primaryColor,
              ),
            ),
            SizedBox(height: 28),
            ScaleTransition(
              scale: _bounceAnimation,
              child: Text(
                'بازی افسانه‌ای سنگ، کاغذ، قیچی!',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: MyApp.primaryColor),
              ),
            ),
            SizedBox(height: 18),
            FadeTransition(
              // انیمیشن محو شدن برای متن توضیحات
              opacity: CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.3, 1.0, curve: Curves.easeIn),
              ),
              child: Text(
                'یه نبرد ذهنی نفس‌گیر! آماده‌ای که هوش و شانس خودت رو به چالش بکشی و حریف رو شکست بدی؟',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 45),
            ScaleTransition(
              scale: CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.5, 1.0, curve: Curves.elasticOut),
              ),
              child: ElevatedButton.icon(
                icon: Icon(Icons.flash_on_rounded, size: 28),
                label: Text(
                  'بریم که بترکونیم!',
                  style: TextStyle(fontSize: 18.5),
                ),
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  // _playSound('sounds/start_game_button.mp3', volume: 1.0);
                  widget.onStartGame();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyApp.secondaryColor,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//**********************************************************************
// صفحات قوانین و درباره ما (مشابه قبل با کمی تغییرات ظاهری)
//**********************************************************************
class RulesPage extends StatelessWidget {
  /* ... کد مشابه قبل، فقط استایل‌ها از Theme می‌آیند ... */
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'قوانین بازی چیه؟ 📜',
            style: textTheme.titleLarge?.copyWith(color: MyApp.primaryColor),
          ),
          SizedBox(height: 18),
          _buildRuleItem(
            context,
            '🪨',
            'سنگ کبیر',
            'قیچی رو در هم می‌شکنه!',
            Icons.fitness_center_rounded,
          ),
          _buildRuleItem(
            context,
            '📄',
            'کاغذ جادویی',
            'سنگ رو قورت میده!',
            Icons.menu_book_rounded,
          ),
          _buildRuleItem(
            context,
            '✂️',
            'قیچی تیز',
            'کاغذ رو رشته رشته می‌کنه!',
            Icons.cut_rounded,
          ),
          SizedBox(height: 22),
          Text(
            'چطور برنده بشیم؟',
            style: textTheme.titleLarge?.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          _buildTipItem(
            context,
            'هر بازیکن در هر دور یکی از سه گزینه (سنگ، کاغذ، یا قیچی) را انتخاب می‌کند.',
          ),
          _buildTipItem(
            context,
            'برنده کسی است که انتخابش بر انتخاب حریف غلبه کند (طبق قوانین بالا).',
          ),
          _buildTipItem(
            context,
            'در صورت انتخاب گزینه‌های یکسان، نتیجه مساوی خواهد بود.',
          ),
          _buildTipItem(
            context,
            'سعی کن حرکت بعدی حریف رو حدس بزنی! البته اگه حریفت کامپیوتر نباشه 😉',
          ),
          SizedBox(height: 28),
          Center(
            child: Text(
              '🚀 برو برای قهرمانی! 🚀',
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
      margin: EdgeInsets.symmetric(vertical: 9),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Text(emoji, style: TextStyle(fontSize: 38)),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Icon(icon, size: 32, color: MyApp.primaryColor.withOpacity(0.75)),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.star_border_purple500_outlined,
            size: 22,
            color: MyApp.secondaryColor,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  /* ... کد مشابه قبل، فقط استایل‌ها از Theme می‌آیند ... */
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Lottie برای لوگوی درباره ما (پیشنهادی) ---
          // SizedBox(height: 130, child: Lottie.asset('assets/lottie/about_us_animation.json')),
          CircleAvatar(
            radius: 55,
            backgroundColor: MyApp.primaryColor.withOpacity(0.08),
            child: Icon(
              Icons.sentiment_satisfied_alt_rounded,
              size: 65,
              color: MyApp.primaryColor,
            ),
          ),
          SizedBox(height: 22),
          Text(
            'پشت صحنه این بازی خفن 🎬',
            style: textTheme.titleLarge?.copyWith(color: MyApp.primaryColor),
          ),
          SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'این بازی با کلی ذوق و با استفاده از فریم‌ورک قدرتمند فلاتر توسط "توسعه‌دهنده خلاق شما" ساخته شده. هدفمون این بود که یه بازی ساده ولی خیلی سرگرم‌کننده و باحال بسازیم که لبخند رو لبتون بیاره.\n\nنسخه: 2.1 - Ultra Fun Edition\n\nهر گونه بازخورد یا ایده‌ای دارید، خوشحال میشیم بشنویم!',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
            ),
          ),
          SizedBox(height: 22),
          Text(
            'تکنولوژی مورد استفاده:',
            style: textTheme.titleMedium?.copyWith(fontSize: 19),
          ),
          SizedBox(height: 10), FlutterLogo(size: 65), SizedBox(height: 28),
        ],
      ),
    );
  }
}

//**********************************************************************
// صفحه اصلی بازی سنگ، کاغذ، قیچی (با آپشن‌های خفن)
//**********************************************************************
class RockPaperScissorsGame extends StatefulWidget {
  @override
  _RockPaperScissorsGameState createState() => _RockPaperScissorsGameState();
}

class _RockPaperScissorsGameState extends State<RockPaperScissorsGame>
    with TickerProviderStateMixin {
  String? _playerChoiceKey; // کلید انتخاب بازیکن (🪨, 📄, ✂️)
  String? _computerChoiceKey;
  String _resultText = 'گزینه‌ات رو انتخاب کن قهرمان!';
  Color _resultColor = MyApp.onBackgroundColor;
  String _resultLottiePath = ''; // مسیر انیمیشن نتیجه Lottie

  int _userWins = 0;
  int _computerWins = 0;
  int _draws = 0;
  int _streakCount = 0; // شمارنده بردهای متوالی

  final List<Map<String, String>> _history = [];

  // مسیرهای انیمیشن Lottie برای انتخاب‌ها
  final Map<String, Map<String, dynamic>> _choices = {
    '🪨': {
      'label': 'سنگ',
      'lottie': 'assets/lottie/rock_play.json',
      'win_lottie': 'assets/lottie/rock_wins.json',
    },
    '📄': {
      'label': 'کاغذ',
      'lottie': 'assets/lottie/paper_play.json',
      'win_lottie': 'assets/lottie/paper_wins.json',
    },
    '✂️': {
      'label': 'قیچی',
      'lottie': 'assets/lottie/scissors_play.json',
      'win_lottie': 'assets/lottie/scissors_wins.json',
    },
  };

  // مسیرهای انیمیشن Lottie برای نتایج کلی
  final Map<String, String> _resultLotties = {
    'win': 'assets/lottie/player_wins_overall.json',
    'lose': 'assets/lottie/player_loses_overall.json',
    'draw': 'assets/lottie/draw_overall.json',
  };

  late AnimationController _resultDisplayController; // برای نمایش نتیجه کلی
  late Animation<double> _resultScaleAnimation;
  late AnimationController _choiceButtonController;
  late AnimationController _scoreUpdateController;
  late Animation<double> _scoreScaleAnimation;
  late AnimationController _streakController; // برای انیمیشن شمارنده برد متوالی

  // --- صدا (اختیاری) ---
  // final AudioPlayer _gameAudioPlayer = AudioPlayer();
  // Future<void> _playGameSound(String assetPath, {double volume = 0.7}) async {
  //   try {
  //     await _gameAudioPlayer.setVolume(volume);
  //     await _gameAudioPlayer.play(AssetSource(assetPath));
  //   } catch (e) { print("Error playing game sound: $e"); }
  // }

  @override
  void initState() {
    super.initState();
    _resultDisplayController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _resultScaleAnimation = CurvedAnimation(
      parent: _resultDisplayController,
      curve: Curves.elasticOut,
    );

    _choiceButtonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 120),
    );
    _scoreUpdateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _scoreScaleAnimation = CurvedAnimation(
      parent: _scoreUpdateController,
      curve: Curves.bounceOut,
    );

    _streakController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _streakController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _streakController.reverse();
    });
    // --- بارگذاری صداهای بازی (اختیاری) ---
    // _gameAudioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    _resultDisplayController.dispose();
    _choiceButtonController.dispose();
    _scoreUpdateController.dispose();
    _streakController.dispose();
    // _gameAudioPlayer.dispose();
    super.dispose();
  }

  void _playGame(String playerChoiceKey) {
    HapticFeedback.heavyImpact();
    // _playGameSound('sounds/choice_selected_${playerChoiceKey == '🪨' ? 'rock' : (playerChoiceKey == '📄' ? 'paper' : 'scissors')}.mp3');

    final random = Random();
    final computerChoiceKey = _choices.keys.toList()[random.nextInt(3)];

    String gameResultText;
    Color gameResultColor;
    String resultType = ''; // 'win', 'lose', 'draw'

    int prevUserWins = _userWins;
    int prevComputerWins = _computerWins;
    int prevDraws = _draws;

    if (playerChoiceKey == computerChoiceKey) {
      gameResultText = 'مساوی شدیم! 🤝 دوباره تلاش کن.';
      gameResultColor = MyApp.drawColor;
      resultType = 'draw';
      _draws++;
      setState(() {
        _streakCount = 0;
      }); // ریست بردهای متوالی
      // _playGameSound('sounds/round_draw.mp3');
    } else if ((playerChoiceKey == '🪨' && computerChoiceKey == '✂️') ||
        (playerChoiceKey == '📄' && computerChoiceKey == '🪨') ||
        (playerChoiceKey == '✂️' && computerChoiceKey == '📄')) {
      gameResultText = 'ایول! تو بردی این دور رو! 🎉';
      gameResultColor = MyApp.winColor;
      resultType = 'win';
      _userWins++;
      setState(() {
        _streakCount++;
      });
      _streakController.forward(from: 0.0); // انیمیشن برای شمارنده برد
      // _playGameSound('sounds/round_win.mp3');
    } else {
      gameResultText = 'اخ! کامپیوتر این دور رو برد. 😬';
      gameResultColor = MyApp.errorColor;
      resultType = 'lose';
      _computerWins++;
      setState(() {
        _streakCount = 0;
      });
      // _playGameSound('sounds/round_lose.mp3');
    }

    setState(() {
      _playerChoiceKey = playerChoiceKey;
      _computerChoiceKey = computerChoiceKey;
      _resultText = gameResultText;
      _resultColor = gameResultColor;
      _resultLottiePath =
          _resultLotties[resultType]!; // تنظیم انیمیشن نتیجه کلی

      _history.insert(0, {
        'player': playerChoiceKey,
        'computer': computerChoiceKey,
        'result': resultType,
        'player_label': _choices[playerChoiceKey]!['label'] as String,
        'computer_label': _choices[computerChoiceKey]!['label'] as String,
      });
      if (_history.length > 5) _history.removeLast();
    });

    _resultDisplayController.forward(from: 0.0);
    if (_userWins != prevUserWins ||
        _computerWins != prevComputerWins ||
        _draws != prevDraws) {
      _scoreUpdateController.forward(from: 0.0);
    }
  }

  void _resetRound() {
    HapticFeedback.lightImpact();
    // _playGameSound('sounds/reset_round.mp3');
    setState(() {
      _playerChoiceKey = null;
      _computerChoiceKey = null;
      _resultText = 'یه دور دیگه؟ انتخاب کن!';
      _resultColor = MyApp.onBackgroundColor;
      _resultLottiePath = '';
    });
  }

  void _resetGameStats() {
    HapticFeedback.vibrate(); // لرزش متفاوت برای ریست کلی
    // _playGameSound('sounds/reset_all_stats.mp3', volume: 1.0);
    setState(() {
      _userWins = 0;
      _computerWins = 0;
      _draws = 0;
      _streakCount = 0;
      _history.clear();
      _resetRound();
      _resultText = 'بازی از اول شروع شد! بزن بریم.';
    });
  }

  Widget _buildChoiceButton(String choiceKey) {
    final choiceData = _choices[choiceKey]!;
    final bool isEnabled =
        _playerChoiceKey == null; // دکمه‌ها فقط قبل از انتخاب فعالند

    return Expanded(
      child: GestureDetector(
        onTapDown: isEnabled ? (_) => _choiceButtonController.forward() : null,
        onTapUp: isEnabled ? (_) => _choiceButtonController.reverse() : null,
        onTapCancel: isEnabled ? () => _choiceButtonController.reverse() : null,
        onTap: isEnabled ? () => _playGame(choiceKey) : null,
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 0.92).animate(
            CurvedAnimation(
              parent: _choiceButtonController,
              curve: Curves.easeOutSine,
            ),
          ),
          child: Card(
            elevation: 3.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(color: MyApp.choiceButtonBorder, width: 1.2),
            ),
            color:
                isEnabled
                    ? MyApp.surfaceColor
                    : Colors.grey.shade300.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- استفاده از Lottie برای نمایش انتخاب (پیشنهادی) ---
                  // SizedBox(
                  //   height: 65, width: 65,
                  //   child: Lottie.asset(choiceData['lottie'] as String, animate: false /* انیمیشن فقط موقع انتخاب */),
                  // ),
                  // ایموجی فعلی:
                  Text(choiceKey, style: TextStyle(fontSize: 34)),
                  SizedBox(height: 6),
                  Text(
                    choiceData['label'] as String,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isEnabled ? MyApp.onPrimaryColor : Colors.grey.shade600,
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreChip(
    String label,
    int score,
    Color color,
    IconData icon, {
    bool animate = false,
  }) {
    Widget content = Chip(
      avatar: Icon(icon, color: color.withOpacity(0.9), size: 20),
      label: Text('$label: $score'),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontFamily: 'Vazirmatn',
        fontSize: 13.5,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      elevation: 1,
    );
    if (animate)
      return ScaleTransition(scale: _scoreScaleAnimation, child: content);
    return content;
  }

  Widget _buildPlayerDisplayAnimated(
    String title,
    String? choiceKey,
    Color bgColor,
  ) {
    final choiceData = choiceKey != null ? _choices[choiceKey!] : null;
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.5,
          ),
        ),
        SizedBox(height: 8),
        AnimatedSwitcher(
          // انیمیشن برای تغییر انتخاب
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Container(
            key: ValueKey<String?>(choiceKey), // کلید برای تشخیص تغییر
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color:
                  choiceKey != null
                      ? bgColor.withOpacity(0.08)
                      : Colors.grey.shade200,
              shape: BoxShape.circle,
              border: Border.all(
                color: choiceKey != null ? bgColor : Colors.grey.shade300,
                width: 2.8,
              ),
              boxShadow:
                  choiceKey != null
                      ? [
                        BoxShadow(
                          color: bgColor.withOpacity(0.25),
                          blurRadius: 7,
                          spreadRadius: 0.5,
                        ),
                      ]
                      : [],
            ),
            child: Center(
              child:
                  choiceKey != null
                      // --- استفاده از Lottie برای نمایش انتخاب بازیکن/کامپیوتر (پیشنهادی) ---
                      // ? Lottie.asset(choiceData!['lottie'] as String, width: 70, height: 70, fit: BoxFit.contain)
                      ? Text(choiceKey, style: TextStyle(fontSize: 40))
                      : Icon(
                        Icons.question_mark_rounded,
                        size: 30,
                        color: Colors.grey.shade400,
                      ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // افکت گرادیانت متحرک برای پس‌زمینه (اختیاری و کمی سنگین‌تر)
    // final _backgroundGradient = LinearGradient(
    //   colors: _playerChoiceKey == null
    //       ? [MyApp.backgroundColor, MyApp.primaryColor.withOpacity(0.05)]
    //       : (_resultColor == MyApp.winColor
    //           ? [MyApp.winColor.withOpacity(0.1), MyApp.winColor.withOpacity(0.3)]
    //           : (_resultColor == MyApp.errorColor
    //               ? [MyApp.errorColor.withOpacity(0.1), MyApp.errorColor.withOpacity(0.3)]
    //               : [MyApp.drawColor.withOpacity(0.1), MyApp.drawColor.withOpacity(0.3)])),
    //   begin: Alignment.topLeft,
    //   end: Alignment.bottomRight,
    // );

    return Scaffold(
      // appBar در HomePage مدیریت می‌شود
      body: /* AnimatedContainer( // برای گرادیانت متحرک
        duration: Duration(milliseconds: 700),
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: */ SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16.0,
          20.0,
          16.0,
          16.0,
        ), // پدینگ بالا بیشتر
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // امتیازات و شمارنده برد متوالی
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildScoreChip(
                    'شما',
                    _userWins,
                    MyApp.winColor,
                    Icons.emoji_events_rounded,
                    animate: true,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _buildScoreChip(
                    'مساوی',
                    _draws,
                    MyApp.drawColor,
                    Icons.handshake_rounded,
                    animate: true,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _buildScoreChip(
                    'حریف',
                    _computerWins,
                    MyApp.errorColor,
                    Icons.computer_rounded,
                    animate: true,
                  ),
                ),
              ],
            ),
            if (_streakCount > 1) // فقط اگر بیشتر از یک برد متوالی باشد
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Center(
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _streakController,
                      curve: Curves.elasticOut,
                    ),
                    child: Chip(
                      label: Text(
                        '$_streakCount برد متوالی! 🔥',
                        style: TextStyle(
                          color: MyApp.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: MyApp.secondaryColor.withOpacity(0.15),
                      avatar: Icon(
                        Icons.local_fire_department_rounded,
                        color: MyApp.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 22),

            // نمایش انتخاب‌ها و نتیجه (با انیمیشن Lottie)
            Container(
              height: 220, // ارتفاع ثابت برای نمایش انیمیشن‌های نتیجه
              child: Stack(
                // استفاده از Stack برای همپوشانی انیمیشن نتیجه
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildPlayerDisplayAnimated(
                        'انتخاب شما',
                        _playerChoiceKey,
                        MyApp.primaryColor,
                      ),
                      SizedBox(width: 20), // فضای بیشتر برای انیمیشن وسط
                      _buildPlayerDisplayAnimated(
                        'انتخاب حریف',
                        _computerChoiceKey,
                        MyApp.errorColor,
                      ),
                    ],
                  ),
                  if (_resultLottiePath.isNotEmpty)
                    ScaleTransition(
                      scale: _resultScaleAnimation,
                      // --- نمایش انیمیشن نتیجه کلی (پیشنهادی) ---
                      // child: Lottie.asset(_resultLottiePath, height: 180, width: 180, fit: BoxFit.contain),
                      // یا آیکون نتیجه فعلی:
                      child: Icon(
                        _resultLottiePath.contains('win')
                            ? Icons.celebration_rounded
                            : _resultLottiePath.contains('lose')
                            ? Icons.sentiment_very_dissatisfied_rounded
                            : Icons.sync_problem_rounded,
                        size: 80,
                        color: _resultColor,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 12),

            // نمایش متن نتیجه
            Text(
              _resultText,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(
                color: _resultColor,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            SizedBox(height: 22),

            // دکمه‌های انتخاب یا دکمه بازی مجدد
            if (_playerChoiceKey == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildChoiceButton('🪨'),
                  SizedBox(width: 10),
                  _buildChoiceButton('📄'),
                  SizedBox(width: 10),
                  _buildChoiceButton('✂️'),
                ],
              )
            else
              ElevatedButton.icon(
                icon: Icon(Icons.autorenew_rounded),
                label: Text('یه دست دیگه؟', style: TextStyle(fontSize: 17)),
                onPressed: _resetRound,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyApp.secondaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            SizedBox(height: 18),

            // تاریخچه بازی
            if (_history.isNotEmpty)
              ExpansionTile(
                // استفاده از ExpansionTile برای جمع و جور کردن تاریخچه
                tilePadding: EdgeInsets.symmetric(horizontal: 8),
                iconColor: MyApp.primaryColor,
                collapsedIconColor: MyApp.primaryColor,
                title: Text(
                  'مشاهده تاریخچه ۵ دور اخیر',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                children:
                    _history.map((item) {
                      Color histResultColor = MyApp.onBackgroundColor;
                      String resultIcon = '';
                      if (item['result'] == 'win') {
                        histResultColor = MyApp.winColor;
                        resultIcon = '🎉';
                      } else if (item['result'] == 'lose') {
                        histResultColor = MyApp.errorColor;
                        resultIcon = '😬';
                      } else if (item['result'] == 'draw') {
                        histResultColor = MyApp.drawColor;
                        resultIcon = '🤝';
                      }
                      return Card(
                        elevation: 0.8,
                        margin: EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 6,
                        ),
                        color: MyApp.surfaceColor.withOpacity(0.8),
                        child: ListTile(
                          dense: true,
                          leading: Text(
                            item['player']!,
                            style: TextStyle(fontSize: 22),
                          ),
                          title: Text(
                            'شما: ${item['player_label']} | حریف: ${item['computer_label']}',
                            style: textTheme.bodySmall?.copyWith(
                              fontSize: 12.5,
                            ),
                          ),
                          trailing: Text(
                            resultIcon,
                            style: TextStyle(
                              fontSize: 22,
                              color: histResultColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            SizedBox(height: 12),

            TextButton.icon(
              icon: Icon(
                Icons.replay_circle_filled_outlined,
                color: MyApp.errorColor.withOpacity(0.8),
              ),
              label: Text(
                'شروع مجدد کل بازی',
                style: TextStyle(
                  color: MyApp.errorColor.withOpacity(0.8),
                  fontSize: 14.5,
                ),
              ),
              onPressed: _resetGameStats,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      // ),
    );
  }
}
