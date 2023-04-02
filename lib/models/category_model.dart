class CategoryModel{
  int? id;
  String? title;
  String? url;
  CategoryModel.fromJson({required Map<String,dynamic> data}){
    id=data['id'];
    title=data['name'];
    url=data['image'];
  }
}
