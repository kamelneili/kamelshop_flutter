class Category{
  String id;
  String title;
  String image;

  Category(this.id, this.title,this.image);


  factory Category.fromJson(Map<String, dynamic> json)
   => Category(json['id'].toString(),json['title'].toString(),
   json['cat_image'].toString()
    );
}