import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../functions/size.dart';

class IntuitiveSplash extends StatelessWidget {
  final Widget icon;
  final Widget darkIcon;
  final String logoTitle;
  final Future<Widget> Function() function;

  final bool showFooter;
  final String? footerTitle;
  final Widget? footerIcon;
  final Widget? darkFooterIcon;

  const IntuitiveSplash(
      {Key? key,
      required this.function,
      this.showFooter = true,
      this.footerTitle,
      this.footerIcon,
      required this.icon,
      Widget? darkIcon,
      this.logoTitle = '',
      Widget? darkFooterIcon})
      : darkIcon = darkIcon ?? icon,
        darkFooterIcon = darkFooterIcon ?? footerIcon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final brightness = MediaQuery.of(context).platformBrightness;
    final isLightMode = brightness == Brightness.light;

    return AnimatedSplashScreen.withScreenFunction(
      centered: true,
      backgroundColor: colorScheme.background,
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
                  isLightMode ? icon : darkIcon,
                  if (logoTitle.isNotEmpty) ...[
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      logoTitle,
                      style: textTheme.titleSmall,
                    ),
                  ],
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SpinKitDualRing(
                color: isLightMode ? Colors.black : Colors.white,
                size: 25,
                lineWidth: 1.75,
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
                        style: textTheme.bodySmall,
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (footerIcon != null)
                        isLightMode ? footerIcon! : darkFooterIcon!,
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
