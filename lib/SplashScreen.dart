// ignore: file_names
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:diabetes_al_dia/Vista/Navegatior/Navs.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';


class SplashScreen {
  Widget animacion() {
    return AnimatedSplashScreen(
        splashIconSize: 350,
        duration: 1000,
        splash: 'asset/bienvenida.jpg',
        nextScreen: const Navs(),
        //splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        backgroundColor: Colors.white);
  }
}