import 'package:everyattire/providers/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Screen"),
      ),
      body: favouriteProvider.favouriteItems.isEmpty
          ? Center(child: Text("No Favourites"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favouriteProvider.favouriteItems.length,
              itemBuilder: (context, index) {
                var favouriteItem = favouriteProvider.favouriteItems.values.toList()[index];
                return ListTile(
                  leading: Image.network(favouriteItem.imageUrl),
                  title: Text(favouriteItem.title),
                  subtitle: Text("\$${favouriteItem.price.toStringAsFixed(2)}"),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite_outline_sharp),
                    onPressed: () {
                      favouriteProvider.removeFromFavourite(favouriteItem.id.toString());
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
