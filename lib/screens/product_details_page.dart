import 'package:everyattire/constants/color_constants.dart';
import 'package:everyattire/providers/cart_provider.dart';
import 'package:everyattire/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../widgets/app_button.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(product.image!)),
              ),
            ),
          ),

          const SizedBox(height: 30),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: kPrimaryColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white,

                      ),
                    ),
                    Text(
                        "\$${product.price!.toString()}",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Product details",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      product.description!,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(height: 25),
                    AppButton(
                      buttonText: "Add to Cart",
                      buttonColor: Colors.white,
                      buttonTextColor: kPrimaryColor,
                      onPressed: (){
                        Provider.of<CartProvider>(context, listen: false).addToCart(product);
                        Navigator.pop(context);
                        SnackBar(
                          content: Text("Product added to cart"),
                          duration: Duration(seconds: 2),
                        );
                      },

                    )
                  ],
                ),
              ),
            ),
          ),

          // Name TextField
        ],
      ),
    );
  }
}
