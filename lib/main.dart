import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Material برای برخی رنگ‌ها و آیکون‌ها می‌تواند مفید باشد
import 'dart:math';

// --- برای Lottie (باید پکیج را اضافه کنید: flutter_lottie و در pubspec.yaml تعریف کنید) ---
// import 'package:lottie/lottie.dart';

// --- برای صدا (باید پکیج را اضافه کنید: audioplayers و در pubspec.yaml تعریف کنید) ---
// import 'package:audioplayers/audioplayers.dart';

// --- برای بازخورد لمسی (باید پکیج را اضافه کنید: flutter_haptic_feedback و در pubspec.yaml تعریف کنید) ---
// import 'package:flutter_haptic_feedback/flutter_haptic_feedback.dart';

void main() => runApp(MyApp());

//**********************************************************************
// کلاس اصلی اپلیکیشن
//**********************************************************************
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      // استفاده از CupertinoApp برای ظاهر iOS
      title: 'سنگ کاغذ قیچی',
      theme: CupertinoThemeData(
        // تم پایه کوپرتینو
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemTeal,
        // برای فونت پیش‌فرض iOS نیازی به تنظیم خاصی نیست، CupertinoApp آن را مدیریت می‌کند.
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // برای فارسی سازی کل برنامه اگر از localizations استفاده می‌کنید:
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale('fa', ''), // فارسی
      // ],
      // locale: const Locale('fa', ''), // تنظیم زبان پیش‌فرض به فارسی
    );
  }
}

//**********************************************************************
// صفحه اصلی که مدیریت صفحات معرفی، قوانین، درباره و بازی را بر عهده دارد
//**********************************************************************
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  int _currentPage = 0; // 0 = Intro, 1 = Rules, 2 = About, 3 = Game

  // --- نمونه‌ای برای پلیر صدا ---
  // final _audioPlayer = AudioPlayer();
  // Future<void> _playSound(String assetName) async {
  //   // await _audioPlayer.play(AssetSource(assetName)); // مسیر فایل صوتی از assets
  // }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // _audioPlayer.dispose();
    super.dispose();
  }

  void _navigateToPage(int pageIndex) {
    // --- اضافه کردن بازخورد لمسی ---
    // HapticFeedback.mediumImpact();
    setState(() {
      _currentPage = pageIndex;
      _animationController.reset(); // ریست کردن انیمیشن برای اجرای مجدد
      _animationController.forward();
    });
  }

  Widget _buildCupertinoButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    Color backgroundColor = CupertinoColors.systemTeal,
    Color foregroundColor = CupertinoColors.white,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
  }) {
    return CupertinoButton(
      color: backgroundColor,
      padding: padding,
      borderRadius: BorderRadius.circular(20),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: foregroundColor),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
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
                fontSize: 30, // کمی کوچکتر برای تناسب بهتر
                fontWeight: FontWeight.bold,
                color: CupertinoColors.systemTeal,
              ),
            ),
          ),
          SizedBox(height: 25),
          // --- اینجا می‌توانید یک انیمیشن Lottie برای خوشامدگویی اضافه کنید ---
          // SizedBox(
          //   height: 120,
          //   width: 120,
          //   child: Lottie.asset('assets/animations/rps_welcome.json'), // مسیر انیمیشن لاتی
          // ),
          SizedBox(height: 35),
          ScaleTransition(
            scale: _scaleAnimation,
            child: _buildCupertinoButton(
              label: 'شروع بازی',
              icon: CupertinoIcons.play_arrow_solid,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              onPressed: () {
                // _playSound('sounds/start_game.mp3');
                _navigateToPage(3);
              },
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // دکمه ها در وسط
            children: [
              Flexible(
                // استفاده از Flexible برای جلوگیری از سرریز شدن در صفحات کوچک
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: _buildCupertinoButton(
                      label: 'قوانین',
                      icon: CupertinoIcons.book_solid,
                      backgroundColor: CupertinoColors.systemOrange,
                      onPressed: () => _navigateToPage(1),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: _buildCupertinoButton(
                      label: 'درباره ما',
                      icon: CupertinoIcons.info_circle_fill,
                      backgroundColor: CupertinoColors.systemGrey2,
                      foregroundColor: CupertinoColors.black,
                      onPressed: () => _navigateToPage(2),
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
      // برای محتوای طولانی‌تر
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Text(
                'قوانین بازی',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemIndigo,
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                '۱. هر بازیکن یکی از سه گزینه را انتخاب می‌کند: \n\n'
                '🪨 سنگ: قیچی را می‌شکند.\n'
                '📄 کاغذ: سنگ را می‌پوشاند.\n'
                '✂️ قیچی: کاغذ را می‌برد.\n\n'
                '۲. برنده کسی است که گزینه او بر گزینه حریف غلبه کند.\n'
                '۳. در صورت انتخاب گزینه‌های یکسان، نتیجه مساوی است.\n\n'
                '✨ موفق باشید! ✨',
                textAlign: TextAlign.right, // برای متن فارسی بهتر است
                style: TextStyle(
                  fontSize: 17,
                  color: CupertinoColors.secondaryLabel,
                  height: 1.6,
                ),
              ),
            ),
            SizedBox(height: 35),
            ScaleTransition(
              scale: _scaleAnimation,
              child: _buildCupertinoButton(
                label: 'بازگشت به منو',
                icon: CupertinoIcons.arrow_left_circle_fill,
                backgroundColor: CupertinoColors.systemGrey3,
                foregroundColor: CupertinoColors.black,
                onPressed: () => _navigateToPage(0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAboutPage() {
    return SingleChildScrollView(
      // برای محتوای طولانی‌تر
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Text(
                'درباره بازی',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemOrange,
                ),
              ),
            ),
            SizedBox(height: 25),
            // --- اینجا می‌توانید یک انیمیشن Lottie یا تصویر برای "درباره ما" اضافه کنید ---
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(15.0),
            //   child: Image.asset('assets/images/developer_logo.png', width: 100), // مثال
            // ),
            // SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'بازی "سنگ، کاغذ، قیچی"\n'
                'نسخه: 1.0.0 (iOS Style)\n\n'
                'طراحی و توسعه با Flutter توسط تیم شما!\n'
                'ما به ساختن تجربیات سرگرم‌کننده و جذاب اعتقاد داریم. از اینکه بازی ما را انتخاب کردید سپاسگزاریم.\n\n'
                'با آرزوی لحظاتی خوش! 😊',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: CupertinoColors.secondaryLabel,
                  height: 1.6,
                ),
              ),
            ),
            SizedBox(height: 35),
            ScaleTransition(
              scale: _scaleAnimation,
              child: _buildCupertinoButton(
                label: 'بازگشت به منو',
                icon: CupertinoIcons.arrow_left_circle_fill,
                backgroundColor: CupertinoColors.systemGrey3,
                foregroundColor: CupertinoColors.black,
                onPressed: () => _navigateToPage(0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // اگر صفحه بازی فعال است، ویجت RockPaperScissorsGame را برگردان
    if (_currentPage == 3) {
      return RockPaperScissorsGame(
        onBackToMenu: () {
          _navigateToPage(0);
        },
      );
    }

    // در غیر این صورت، یکی از صفحات معرفی، قوانین یا درباره ما را نمایش بده
    return Directionality(
      textDirection: TextDirection.rtl, // برای پشتیبانی از راست به چپ
      child: CupertinoPageScaffold(
        backgroundColor: Color(0xFFF0F0F5), // یک رنگ پس‌زمینه iOS مانند روشن‌تر
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 30.0,
          ), // پدینگ بیشتر
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 350), // سرعت انیمیشن تغییر صفحه
            transitionBuilder: (Widget child, Animation<double> animation) {
              // انیمیشن محو شدن و مقیاس برای تغییر صفحات
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: KeyedSubtree(
              // برای اینکه AnimatedSwitcher درست کار کند با تغییر ویجت‌ها
              key: ValueKey<int>(_currentPage),
              child:
                  _currentPage == 0
                      ? buildIntroPage()
                      : _currentPage == 1
                      ? buildRulesPage()
                      : buildAboutPage(),
            ),
          ),
        ),
      ),
    );
  }
}

//**********************************************************************
// صفحه اصلی بازی سنگ، کاغذ، قیچی
//**********************************************************************
class RockPaperScissorsGame extends StatefulWidget {
  final VoidCallback onBackToMenu;

  RockPaperScissorsGame({required this.onBackToMenu});

  @override
  _RockPaperScissorsGameState createState() => _RockPaperScissorsGameState();
}

class _RockPaperScissorsGameState extends State<RockPaperScissorsGame>
    with SingleTickerProviderStateMixin {
  String _playerChoiceEmoji = '';
  String _computerChoiceEmoji = '';
  String _resultText = '';

  late AnimationController _gameAnimationController;
  late Animation<double> _scaleAnimation; // برای انیمیشن دکمه‌ها و نتیجه
  late Animation<Offset> _slideAnimation; // برای نمایش انتخاب‌ها

  int _userWins = 0;
  int _computerWins = 0;
  int _draws = 0;

  final List<String> _history = [];

  final Map<String, String> _choices = {
    '🪨': 'سنگ',
    '📄': 'کاغذ',
    '✂️': 'قیچی',
  };

  // --- نمونه‌ای برای پلیر صدا ---
  // final _audioPlayerGame = AudioPlayer();
  // Future<void> _playGameSound(String assetName) async {
  //   // await _audioPlayerGame.play(AssetSource(assetName));
  // }

  @override
  void initState() {
    super.initState();
    _gameAnimationController = AnimationController(
      duration: const Duration(milliseconds: 450), // سرعت انیمیشن کمی بیشتر
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _gameAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _gameAnimationController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  void _playGame(String playerEmoji) {
    // --- بازخورد لمسی برای انتخاب ---
    // HapticFeedback.lightImpact();
    // --- پخش صدای انتخاب ---
    // _playGameSound('sounds/select_choice.mp3');

    final random = Random();
    final compEmoji = _choices.keys.toList()[random.nextInt(3)];

    String gameResult;
    Color resultColor;

    if (playerEmoji == compEmoji) {
      gameResult = 'مساوی شد!';
      _draws++;
      resultColor = CupertinoColors.systemOrange;
      // _playGameSound('sounds/draw.mp3');
    } else if ((playerEmoji == '🪨' && compEmoji == '✂️') ||
        (playerEmoji == '📄' && compEmoji == '🪨') ||
        (playerEmoji == '✂️' && compEmoji == '📄')) {
      gameResult = 'شما بردید 🎉';
      _userWins++;
      resultColor = CupertinoColors.systemGreen;
      // _playGameSound('sounds/win.mp3');
      // --- اینجا می‌توانید انیمیشن Lottie برای برد پخش کنید ---
    } else {
      gameResult = 'کامپیوتر برد 😢';
      _computerWins++;
      resultColor = CupertinoColors.systemRed;
      // _playGameSound('sounds/lose.mp3');
      // --- اینجا می‌توانید انیمیشن Lottie برای باخت پخش کنید ---
    }

    setState(() {
      _playerChoiceEmoji = playerEmoji;
      _computerChoiceEmoji = compEmoji;
      _resultText = gameResult;
      // افزودن به تاریخچه با جزئیات بیشتر
      final playerHand = _choices[playerEmoji];
      final computerHand = _choices[compEmoji];
      _history.insert(
        0,
        "شما: $playerHand ($playerEmoji) | کامپیوتر: $computerHand ($compEmoji) 👈 $gameResult",
      );
      if (_history.length > 7) {
        // محدود کردن تاریخچه به ۷ مورد اخیر
        _history.removeLast();
      }
    });

    _gameAnimationController.reset();
    _gameAnimationController.forward();
  }

  void _resetRound() {
    // HapticFeedback.selectionClick();
    setState(() {
      _playerChoiceEmoji = '';
      _computerChoiceEmoji = '';
      _resultText = '';
    });
  }

  void _resetGameStats() {
    // HapticFeedback.heavyImpact();
    // _playGameSound('sounds/reset_all.mp3');
    setState(() {
      _userWins = 0;
      _computerWins = 0;
      _draws = 0;
      _history.clear();
      _resetRound(); // همچنین دور فعلی را ریست کن
    });
  }

  Widget _buildChoiceButton(String emoji, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _playGame(emoji),
        child: ScaleTransition(
          // انیمیشن برای دکمه‌ها هنگام انتخاب
          scale:
              _scaleAnimation, // استفاده از انیمیشن موجود، یا یک انیمیشن جدید برای هاور
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 4,
            ), // فاصله کمتر
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ), // پدینگ داخلی
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(18), // گردی بیشتر
              border: Border.all(
                color: CupertinoColors.systemGrey4,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.12),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  emoji,
                  style: TextStyle(fontSize: 38),
                ), // اندازه ایموجی کمی کوچکتر
                SizedBox(height: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13, // فونت کمی کوچکتر
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.label,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ), // پدینگ کمی بیشتر
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // شفافیت کمتر برای خوانایی
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ), // فونت پررنگ‌تر
            ),
            SizedBox(height: 3),
            Text(
              '$count',
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ), // عدد بزرگتر
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerDisplay(String title, String emoji, Color bgColor) {
    if (emoji.isEmpty)
      return SizedBox(width: 80); // برای حفظ فضا حتی اگر خالی باشد
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        SizedBox(height: 8),
        ScaleTransition(
          // استفاده از انیمیشن موجود
          scale: _scaleAnimation,
          child: Container(
            padding: EdgeInsets.all(18), // پدینگ بیشتر برای دایره
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.25),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              emoji,
              style: TextStyle(fontSize: 38, color: CupertinoColors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color resultDisplayColor = CupertinoColors.label;
    if (_resultText.contains("بردید"))
      resultDisplayColor = CupertinoColors.systemGreen;
    else if (_resultText.contains("باخت"))
      resultDisplayColor = CupertinoColors.systemRed;
    else if (_resultText.contains("مساوی"))
      resultDisplayColor = CupertinoColors.systemOrange;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: CupertinoPageScaffold(
        backgroundColor: Color(0xFFF0F0F5), // همان پس زمینه صفحات قبل
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
            previousPageTitle: "منو",
            onPressed: widget.onBackToMenu,
            color: CupertinoColors.systemTeal,
          ),
          middle: Text(
            'بازی!',
            style: TextStyle(
              color: CupertinoColors.systemTeal,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: CupertinoColors.white.withOpacity(
            0.85,
          ), // کمی شفاف‌تر
          border: Border(
            bottom: BorderSide(color: CupertinoColors.systemGrey5, width: 0.5),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              16.0,
              10.0,
              16.0,
              16.0,
            ), // پدینگ متفاوت برای بالا
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // توزیع بهتر فضا
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // شمارنده‌ها
                Row(
                  children: [
                    _buildCounter(
                      "شما",
                      _userWins,
                      CupertinoColors.systemGreen,
                    ),
                    SizedBox(width: 10),
                    _buildCounter(
                      "مساوی",
                      _draws,
                      CupertinoColors.systemOrange,
                    ),
                    SizedBox(width: 10),
                    _buildCounter(
                      "کامپیوتر",
                      _computerWins,
                      CupertinoColors.systemRed,
                    ),
                  ],
                ),

                // نمایش نتیجه یا پیام انتخاب
                Container(
                  height: 150, // ارتفاع ثابت برای بخش میانی
                  child: Center(
                    child:
                        _resultText.isEmpty
                            ? Text(
                              'انتخاب کنید:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: CupertinoColors.systemTeal.withOpacity(
                                  0.8,
                                ),
                              ),
                            )
                            : Column(
                              // نمایش انتخاب‌ها و نتیجه
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SlideTransition(
                                  position: _slideAnimation,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildPlayerDisplay(
                                        'شما',
                                        _playerChoiceEmoji,
                                        CupertinoColors.systemTeal,
                                      ),
                                      Text(
                                        "VS",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: CupertinoColors.systemGrey2,
                                        ),
                                      ),
                                      _buildPlayerDisplay(
                                        'کامپیوتر',
                                        _computerChoiceEmoji,
                                        CupertinoColors.systemOrange,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                ScaleTransition(
                                  scale: _scaleAnimation,
                                  child: Text(
                                    _resultText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: resultDisplayColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),

                // دکمه‌های انتخاب یا دکمه "بازی مجدد"
                if (_resultText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: CupertinoButton.filled(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'بازی مجدد دور',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: _resetRound,
                      ),
                    ),
                  )
                else
                  Row(
                    // دکمه های انتخاب سنگ کاغذ قیچی
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        _choices.entries
                            .map((e) => _buildChoiceButton(e.key, e.value))
                            .toList(),
                  ),

                // تاریخچه بازی
                Expanded(
                  flex: 2, // فضای بیشتر برای تاریخچه
                  child:
                      _history.isEmpty
                          ? Center(
                            child: Text(
                              "تاریخچه بازی اینجا نمایش داده می‌شود.",
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 14,
                              ),
                            ),
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 8.0,
                                  right: 5.0,
                                ),
                                child: Text(
                                  "آخرین نتایج:",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoColors.secondaryLabel,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: CupertinoColors.systemGrey5,
                                    ),
                                  ),
                                  child: ListView.builder(
                                    itemCount: _history.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          border:
                                              index < _history.length - 1
                                                  ? Border(
                                                    bottom: BorderSide(
                                                      color:
                                                          CupertinoColors
                                                              .systemGrey5,
                                                      width: 0.5,
                                                    ),
                                                  )
                                                  : null,
                                        ),
                                        child: Text(
                                          _history[index],
                                          style: TextStyle(
                                            color: CupertinoColors.label
                                                .withOpacity(0.85),
                                            fontSize: 13.5,
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                ),

                SizedBox(height: 10),
                // دکمه ریست کلی
                CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  color: CupertinoColors.systemRed.withOpacity(0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.trash_circle,
                        color: CupertinoColors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'شروع مجدد کل بازی',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  onPressed: _resetGameStats,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _gameAnimationController.dispose();
    // _audioPlayerGame.dispose();
    super.dispose();
  }
}
