import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

ToastFuture toast({
  required BuildContext context,
  required String message,
  required Color color,
}) =>
    showToast(
      message,
      context: context,
      animation: StyledToastAnimation.slideFromLeftFade,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      backgroundColor: color,
      borderRadius: BorderRadius.circular(10),
      textStyle: const TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastLinearToSlowEaseIn,
    );