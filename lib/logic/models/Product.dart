class Product {
  String? id;
  String title, content;
  String featuredImage, price, oldPrice;

  int? userId, categoryId;

  Product(
    this.id,
    this.title,
    this.price,
    this.oldPrice, // this.categoryId

    this.content,
    this.featuredImage,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        json['id'].toString(),
        json['title'].toString(),
        json['price'].toString(),
        json['old_price'].toString(),
        json['description'].toString(),
        json['image'].toString(),
      );
}
