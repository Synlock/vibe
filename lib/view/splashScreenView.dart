import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/audioRecorderViewModel.dart';
import 'package:vibe/viewmodel/initApplicationViewModel.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

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
        setState(() {});
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, "/home");
        });
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

class InitApplication extends StatefulWidget {
  final AnimationController animationController;
  const InitApplication({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  State<InitApplication> createState() => _InitApplicationState();
}

class _InitApplicationState extends State<InitApplication> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await getPermissions();
      await setRecordingsDirectory();
      initCategoryList();

      Directory recordingsDir = Directory(getPathToRecordings());
      if (recordingsDir.listSync().isEmpty) return;

      await populateAlertsList("temp");
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.animationController.isCompleted
        ? CircularProgressIndicator.adaptive(
            backgroundColor: yellowColor,
          )
        : Container();
  }
}
