class ProductModel {
  int? id;
  int? discount;
  int? price;
  int? oldPrice;
  String? name;
  String? description;
  String? image;


  ProductModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'].toInt();
    discount = data['discount'].toInt();
    price = data['price'].toInt();
    oldPrice = data['old_price'].toInt();
    name = data['name'].toString();
    description = data['description'].toString();
    image=data['image'].toString();
  }
}
