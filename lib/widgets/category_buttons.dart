import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryButtons extends StatelessWidget {
  const CategoryButtons({
    super.key,
    this.textColor,
    this.buttonColor,
    this.width,
    this.onPressed,
    this.buttonText,
    this.buttonTextColor,
    this.buttonTextPadding = 0,
  });

  final Color? textColor;
  final String? buttonText;
  final Color? buttonTextColor;
  final Color? buttonColor;
  final double? width;
  final double buttonTextPadding;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(buttonColor),
      ),
      onPressed: onPressed,

      child: SizedBox(
        width: width,
        child: Center(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: buttonTextPadding),
          child: Text(buttonText!, style: GoogleFonts.poppins(color: buttonTextColor, fontSize: 16)),
        )),
      ),
    );
  }
}
