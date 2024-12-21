import 'package:byte_budget/presentation/colors.dart';
import 'package:byte_budget/presentation/pages/subscriptions_page.dart';
import 'package:byte_budget/presentation/widget/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.jpg'),
          fit: BoxFit.cover,
          // repeat: ImageRepeat.repeat,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.primaryTransparent,
        body: const OperationsPage(),
        floatingActionButton: GlassmorphicBorder(
          style: GlassmorphicBorderStyle(
            strokeWidth: 2,
            gradient: AppColors.borderGradient,
            boxShape: GlassmorphicShape.circle,
          ),
          child: NeumorphicButton(
            onPressed: () {
              // Действие при нажатии
            },
            style: const NeumorphicStyle(
              depth: 0,
              intensity: 0.8,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              lightSource: LightSource.topLeft,
              color: Colors.transparent,
            ),
            padding: EdgeInsets.zero,
            minDistance: -4,
            provideHapticFeedback: true,
            child: Glassmorphic(
              blur: 2,
              bodyGradient: AppColors.greenGradient60,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.account_balance_rounded, size: 32),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: GlassmorphicBottomAppBar(
          blur: 2,
          notchMargin: 10,
          borderWidth: 4,
          borderGradient: AppColors.borderGradient,
          shape: const CircularNotchedRectangle(),
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Переход на экран "Домой"
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Переход на экран "Поиск"
              },
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Переход на экран "Уведомления"
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Переход на экран "Профиль"
              },
            ),
          ],
        ),
      ),
    );
  }
}
