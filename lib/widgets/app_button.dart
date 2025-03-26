import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.formKey,
    this.textColor,
    this.buttonColor,
    this.width,
    this.onPressed,
    this.isLoading = false,
    this.buttonText, this.buttonTextColor,
    this.buttonTextPadding = 0,
  });

  final GlobalKey<FormState>? formKey;
  final Color? textColor;
  final String? buttonText;
  final Color? buttonTextColor;
  final Color? buttonColor;
  final double? width;
  final double buttonTextPadding;
  final Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(buttonColor),
      ),
      onPressed: onPressed,

      child: SizedBox(
        height: 49,
        width: width,
        child: Center(child: isLoading ? LoadingAnimationWidget.halfTriangleDot(
          color: Colors.white, size: 24,)  :  Padding(
          padding: EdgeInsets.symmetric(horizontal: buttonTextPadding),
          child: Text(buttonText!, style: GoogleFonts.poppins(color: buttonTextColor, fontSize: 18)),
        )
      ),
    ));
  }
}
