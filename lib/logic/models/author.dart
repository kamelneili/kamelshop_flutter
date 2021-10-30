class Author {
  String id;
  String first_name;
  String email;
  String mobile;
  Author(this.mobile, this.id, this.first_name, this.email);

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        json['mobile'].toString(),
        json['id'].toString(),
        json['first_name'].toString(),
        json['email'].toString(),
      );
}
