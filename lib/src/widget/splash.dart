import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../function/size.dart';

class IntuitiveSplash extends StatelessWidget {
  final Widget icon;
  final String logoTitle;
  final Future<Widget> Function() function;

  final bool showFooter;
  final String? footerTitle;
  final Widget? footerIcon;

  const IntuitiveSplash(
      {Key? key,
      required this.function,
      this.showFooter = true,
      this.footerTitle,
      this.footerIcon,
      required this.icon,
      this.logoTitle = ''})
      : assert((footerTitle == null || footerIcon != null), "Need icon if use footer title"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // late String footerIconPath;
    // switch (footerIcon) {
    //   case SplashIcon.appleDeveloperAcademy:
    //     footerIconPath = 'assets/apple-developer-academy.png';
    //     break;
    //   case SplashIcon.empty:
    //     footerIconPath = '';
    //     break;
    // }

    return AnimatedSplashScreen.withScreenFunction(
      centered: true,
      backgroundColor: Colors.white,
      splashIconSize: IntuitiveSize.maxHeight(context),
      splash: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  if (logoTitle.isNotEmpty) ...[
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      logoTitle,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const SpinKitDualRing(
                color: Colors.black,
                size: 25,
                lineWidth: 1.5,
              ),
            ],
          ),
          if (showFooter)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (footerTitle != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        footerTitle!,
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (footerIcon != null) footerIcon!,
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
      screenFunction: function,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
