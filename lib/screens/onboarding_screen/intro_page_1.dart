import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstIntroPage extends StatefulWidget {
  const FirstIntroPage({super.key});

  @override
  State<FirstIntroPage> createState() => _FirstIntroPageState();
}

class _FirstIntroPageState extends State<FirstIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/intro1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your style tell \nabout you',
                    style: GoogleFonts.zenDots(fontSize: 32, color: Colors.white),
                  ),
                  Text(
                    'There are many clothes with designs that are suitable \nfor you today',
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
