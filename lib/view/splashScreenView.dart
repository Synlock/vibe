import 'package:flutter/material.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/initApplicationViewModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )
    ..forward()
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!Navigator.of(context).mounted) return;
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).popAndPushNamed(HOME_ROUTE);
        });
        setState(() {});
      }
    });
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 0.5),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: indigoColor,
      body: VibeLogo(
        offsetAnimation: _offsetAnimation,
        animationController: _controller,
      ),
    );
  }
}

class VibeLogo extends StatelessWidget {
  final Animation<Offset> offsetAnimation;
  final AnimationController animationController;
  const VibeLogo({
    Key? key,
    required this.offsetAnimation,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 75.0),
          child: Transform.scale(
            scale: 3.0,
            child: SlideTransition(
              position: offsetAnimation,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0.0, 350.0),
          child: InitApplication(
            animationController: animationController,
          ),
        ),
      ],
    );
  }
}
