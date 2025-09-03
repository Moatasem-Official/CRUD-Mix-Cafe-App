import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WhenLoadingLogInWidget extends StatelessWidget {
  const WhenLoadingLogInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: Lottie.asset(
              'assets/animations/Animation - 1751639954708.json',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}

class WhenLoadingCategoriesWidget extends StatelessWidget {
  const WhenLoadingCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 165, 101, 56),
            ),
          ),
        ),
      ),
    );
  }
}
