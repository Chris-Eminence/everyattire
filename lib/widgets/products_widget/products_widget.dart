import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_constants.dart';
import '../../model/product_model.dart';
import '../../providers/products_provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ProductProvider>(context, listen: false).fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            children: List.generate(6, (index) => _buildSkeletonItem()), // Placeholder UI
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error loading products'));
        }

        final productProvider = Provider.of<ProductProvider>(context);
        return GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 70,
          children: productProvider.products.map<Widget>((Product product) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.network(
                                  product.image ?? '',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -5,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: scaffoldBGColor,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: SvgPicture.asset(
                              'assets/add_to_cart_icon.svg',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: CircleAvatar(
                          backgroundColor: kWhiteShade3,
                          child: SvgPicture.asset('assets/heart.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  product.title ?? 'No Title',
                  style: GoogleFonts.poppins(
                    color: kBlackShade,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                  style: GoogleFonts.poppins(
                    color: kGreyShade,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  // Skeleton Placeholder for Loading State
  Widget _buildSkeletonItem() {
    return LoadingAnimationWidget.halfTriangleDot(
      color: kPrimaryColor,
      size: 50,
    );
  }
}
