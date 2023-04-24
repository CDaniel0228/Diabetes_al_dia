// ignore: file_names
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:diabetes_al_dia/Vista/Navegatior/Navs.dart';
import 'package:diabetes_al_dia/Vista/Wizart.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen {
  Widget animacion(wiz) {
    return AnimatedSplashScreen(
        splashIconSize: 350,
        duration: 1000,
        splash: 'asset/bienvenida.jpg',
        nextScreen: wiz != 0 ? const FormPage() : const Navs(),
        //splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        backgroundColor: Colors.white);
  }
}
