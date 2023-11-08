class ProductModel {
  String title;
  String description;
  num productPrice;
  String productImgUrl;
  int productQuantity;
  ProductModel({
    required this.title,
    required this.description,
    required this.productPrice,
    required this.productImgUrl,
    required this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'productPrice': productPrice,
      'productImgUrl': productImgUrl,
      'productQuantity': productQuantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'] as String,
      description: map['description'] as String,
      productPrice: map['productPrice'] as num,
      productImgUrl: map['productImgUrl'] as String,
      productQuantity: map['productQuantity'] as int,
    );
  }
}
