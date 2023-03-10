import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/network/repositories/user_repository.dart';
import 'package:crypto_tracker/services/asset_observer.dart';
import 'package:crypto_tracker/services/crypto_service.dart';
import 'package:crypto_tracker/services/liability_observer.dart';
import 'package:crypto_tracker/services/net_worth_observer.dart';
import 'package:crypto_tracker/services/service_locator.dart';
import 'package:crypto_tracker/views/home/authentification_screen.dart';
import 'package:crypto_tracker/views/home/history.dart';
import 'package:crypto_tracker/views/home/tips.dart';
import 'package:crypto_tracker/widgets/shared/custom_app_bar_rank.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../services/tips_service.dart';
import 'home/portfolio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // test comment
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    CryptoService.instance.getCryptoAssets();
    NetWorthObserver.instance.getNetWorthAndRank();
    AssetObserver.instance.getAssets();
    LiabilityObserver.instance.getLiabilities();
    TipsService.instance.getTips();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 1,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _bellController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _screensList = [const PortfolioScreen(), const TipsScreen(), const HistoryScreen()];
    _bottomIcons = [Icons.account_balance_wallet, Icons.lightbulb, Icons.history];
    _runAnimation();
    serviceLocator<UserRepository>().getUserId();
    super.initState();
  }

  late AnimationController _bellController;
  late List<Widget> _screensList;
  late List<IconData> _bottomIcons;
  int _selectedBottomIndex = 0;

  void _runAnimation() async {
    for (int i = 0; i < 5; i++) {
      await _bellController.forward();
      await _bellController.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _bellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(

              appBar: const PreferredSize(preferredSize: Size.fromHeight(55.0), child: CustomAppBar()),
              body: _screensList[_selectedBottomIndex],
              bottomNavigationBar: Container(
                height: kBottomNavigationBarHeight + 10,
                width: 100.w,
                decoration: BoxDecoration(
                  color: AppColors.bgColor.withOpacity(0.8),
                ),
                child: ListView.builder(
                  itemCount: _bottomIcons.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _selectedBottomIndex = index;
                        setState(() {});
                      },
                      child: SizedBox(
                        width: 100.w / _bottomIcons.length,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: _selectedBottomIndex == index ? AppColors.getLinearGradient(Colors.indigo) : null,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _bottomIcons[index],
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return SignInScreen();
          }
        });
  }
}

class PositionedCircle extends StatelessWidget {
  final double? top, bottom, left, right;
  final double size;

  const PositionedCircle({
    Key? key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 40,
            )
          ],
          color: const Color(0xFf6d9bdd).withOpacity(0.05),
        ),
      ),
    );
  }
}
