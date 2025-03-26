import 'package:everyattire/constants/color_constants.dart';
import 'package:everyattire/widgets/category_buttons.dart';
import 'package:everyattire/widgets/products_widget/products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back',
                          style: GoogleFonts.poppins(
                            color: kGreyShade,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'User Name',
                          style: GoogleFonts.poppins(
                            color: kBlackShade,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(child: SvgPicture.asset('assets/cart_icon.svg')),
                  ],
                ),
                SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    fillColor: kWhiteShade,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'What are you looking for...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SvgPicture.asset('assets/search_icon.svg'),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kWhiteShade2,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Shop with us',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Get 40% off for \nall items',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w900,
                                fontSize: 29,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Shop now →',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Image.asset('assets/banner_image.png')),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryButtons(
                        textColor: Colors.black,
                        buttonColor: Colors.white,
                        buttonText: 'All',
                      ),
                      SizedBox(width: 5),
                      CategoryButtons(
                        textColor: Colors.black,
                        buttonColor: kWhiteShade2,
                        buttonText: 'Jacket',
                      ),
                      SizedBox(width: 5),
                      CategoryButtons(
                        textColor: Colors.black,
                        buttonColor: kWhiteShade2,
                        buttonText: 'Shoes',
                      ),
                      SizedBox(width: 5),
                      CategoryButtons(
                        textColor: Colors.black,
                        buttonColor: kWhiteShade2,
                        buttonText: 'Trousers',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ProductGrid()
              ],
            ),
          ),
        ),
      ),
    );
  }
}