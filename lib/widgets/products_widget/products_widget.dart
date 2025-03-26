import 'package:everyattire/providers/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_constants.dart';
import '../../model/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../screens/product_details_page.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<ProductProvider>(context, listen: false).fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            children: List.generate(
              6,
              (index) => _buildSkeletonItem(),
            ), // Placeholder UI
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
          children:
              productProvider.products.map<Widget>((Product product) {
                return _ProductItem(product: product);
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

class _ProductItem extends StatelessWidget {
  final Product product;

  _ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favouriteProvider = Provider.of<FavouriteProvider>(
      context,
      listen: false,
    );
    final ValueNotifier<bool> isInCart = ValueNotifier(
      cartProvider.isInCart(product.id!.toString()),
    );
    final ValueNotifier<bool> isInFavourite = ValueNotifier(
      favouriteProvider.isInFavourite(product.id!.toString()),
    );

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
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(product: product),
                      ),
                    );
                  },
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
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: -5,
                child: ValueListenableBuilder<bool>(
                  valueListenable: isInCart,
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () {
                        if (value) {
                          cartProvider.removeFromCart(product.id!.toString());
                        } else {
                          cartProvider.addToCart(product);
                        }
                        isInCart.value = !value;
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: value ? Colors.grey : scaffoldBGColor,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: SvgPicture.asset(
                            'assets/add_to_cart_icon.svg',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: ValueListenableBuilder<bool>(
                  valueListenable: isInFavourite,
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () {
                        if (value) {
                          favouriteProvider.removeFromFavourite(product.id!.toString());
                        } else {
                          favouriteProvider.addToCart(product);
                        }
                        isInFavourite.value = !value;
                      },

                      child: InkWell(
                        child: CircleAvatar(
                          backgroundColor: value ? Colors.redAccent : kWhiteShade3,
                          child: SvgPicture.asset('assets/heart.svg'),
                        ),
                      ),
                    );
                  },
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
  }
}
