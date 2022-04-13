import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/alertBehaviorViewModel.dart';

class AlertBanner extends StatefulWidget {
  final AlertData alert;
  const AlertBanner({Key? key, required this.alert}) : super(key: key);

  @override
  State<AlertBanner> createState() => _AlertBannerState();
}

class _AlertBannerState extends State<AlertBanner> {
  AudioPlayer audioPlayer = AudioPlayer();
  Color bgColor = Colors.red;

  @override
  void initState() {
    super.initState();
    if (widget.alert.alertBehavior.isSilent) return;

    alertBehaviorHandler(
      widget.alert.alertBehavior,
      audioPlayer,
      1,
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: bgColor,
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: AlertInfo(data: widget.alert),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PopBannerTarget(
                          bgColor: bgColor,
                          audioPlayer: audioPlayer,
                        ),
                      ),
                      const PointerIcons(isRight: false),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Draggable(
                          child: DragIcon(data: Icons.check_rounded),
                          feedback: DragIcon(data: Icons.check_rounded),
                          childWhenDragging: DragIcon(
                            data: null,
                          ),
                          data: 1,
                        ),
                      ),
                      const PointerIcons(isRight: true),
                      Expanded(
                        child: PopBannerTarget(
                          bgColor: bgColor,
                          audioPlayer: audioPlayer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlertPopup extends StatefulWidget {
  final AlertData alert;
  const AlertPopup({Key? key, required this.alert}) : super(key: key);

  @override
  State<AlertPopup> createState() => _AlertPopupState();
}

class _AlertPopupState extends State<AlertPopup> {
  AudioPlayer audioPlayer = AudioPlayer();
  Color bgColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: bgColor,
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlertInfo(data: widget.alert),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      PopBannerTarget(
                        bgColor: bgColor,
                        audioPlayer: audioPlayer,
                      ),
                      const Positioned(
                        left: 40,
                        child: PointerIcons(isRight: false),
                      ),
                    ],
                  ),
                ),
                const Draggable(
                  child: DragIcon(
                    containerSize: 50,
                    iconSize: 25,
                  ),
                  feedback: DragIcon(
                    containerSize: 50,
                    iconSize: 25,
                  ),
                  childWhenDragging: DragIcon(data: null, containerSize: 50),
                  data: 1,
                ),
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      PopBannerTarget(
                        bgColor: bgColor,
                        audioPlayer: audioPlayer,
                      ),
                      const Positioned(
                        left: 15,
                        child: PointerIcons(isRight: true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class DragIcon extends StatelessWidget {
  final IconData? data;
  final double containerSize;
  final double iconSize;

  const DragIcon({
    Key? key,
    this.data = Icons.check_rounded,
    this.containerSize = 75,
    this.iconSize = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: data != null
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            )
          : null,
      child: Icon(
        data != null ? Icons.check_rounded : null,
        size: iconSize,
      ),
    );
  }
}

class AlertInfo extends StatelessWidget {
  final AlertData data;
  const AlertInfo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          IconData(data.alertIcon, fontFamily: "MaterialIcons"),
          size: 100,
        ),
        Text(
          data.alertName,
          style: alertButtonTextStyle(),
        ),
      ],
    );
  }
}

class PointerIcons extends StatelessWidget {
  final bool isRight;
  const PointerIcons({Key? key, required this.isRight}) : super(key: key);

  static const Icon iconLeft = Icon(
    Icons.arrow_back_ios_new_rounded,
    size: 17,
    color: Colors.white,
  );
  static const Icon iconRight = Icon(
    Icons.arrow_forward_ios_rounded,
    size: 17,
    color: Colors.white,
  );

  Widget setDirection(BuildContext context) {
    DragTarget dragTarget = DragTarget(
      builder: (context, candidateData, rejectedData) {
        return Container();
      },
      onAccept: (data) {
        if (data != 1) return;

        turnOffAllTimers();
        Navigator.pop(context);
      },
    );

    List<Widget> rightChildren = [iconRight, iconRight, iconRight];
    List<Widget> leftChildren = [iconLeft, iconLeft, iconLeft];

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Row(
          children: isRight ? rightChildren : leftChildren,
        ),
        SizedBox(width: 50, height: 50, child: dragTarget),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return setDirection(context);
  }
}

class PopBannerTarget extends StatelessWidget {
  final Color bgColor;
  final AudioPlayer audioPlayer;
  const PopBannerTarget({
    Key? key,
    required this.bgColor,
    required this.audioPlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 200,
      color: bgColor,
      child: DragTarget(
        builder: (context, candidateData, rejectedData) {
          return Container();
        },
        onAccept: (data) {
          if (data != 1) return;

          turnOffAllTimers();
          Navigator.pop(context);
        },
      ),
    );
  }
}
