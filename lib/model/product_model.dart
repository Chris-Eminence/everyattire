// product model with id, title, price, category, image, and description

class Product {
  int? id;
  String? title;
  double? price;
  String? category;
  String? image;
  String? description;

  Product({this.id, this.title, this.price, this.category, this.image, this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      category: json['category'],
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'category': category,
        'image': image,
        'description': description,
      };
}