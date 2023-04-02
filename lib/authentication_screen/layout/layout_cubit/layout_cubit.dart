import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:fashion/authentication_screen/layout/layout_cubit/layout_state.dart';
import 'package:fashion/constant/constanc.dart';
import 'package:fashion/models/banner_model.dart';
import 'package:fashion/models/category_model.dart';
import 'package:fashion/models/product_model.dart';
import 'package:fashion/models/user_model.dart';
import 'package:fashion/modules/screen/cart_screen.dart';
import 'package:fashion/modules/screen/category_screen.dart';
import 'package:fashion/modules/screen/favorites_screen.dart';
import 'package:fashion/modules/screen/home_page_screen.dart';
import 'package:fashion/modules/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitialState());

  //
  // bottom navigation bar
  int bottomNavIndex = 0;
  List<Widget> layoutScreen = [
    HomePages(),
    CategoryScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void changeButtonNav({required int index}) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  //
  // get data to profile
  UserModel? userModel;

  void getUserData() async {
    emit(GetUserDataLoadingState());
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/profile"),
        headers: {'Authorization': token!, "lang": "en"});
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      userModel = UserModel.fromJson(data: responseData['data']);
      print("response is : $responseData");
      emit(GetUserDataSuccessState());
    } else {
      print("response is : $responseData");
      emit(FailedToGetUserDataState(error: responseData['message']));
    }
  }

  //
  // get Banner data
  List<BannerModel> bannerModel = [];

  void getBannerData() async {
    emit(GetBannerLoadingState());
    Response response =
        await http.get(Uri.parse('https://student.valuxapps.com/api/banners'));

    final responseBody = jsonDecode(response.body);
    print('Banner is $responseBody');
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']) {
        bannerModel.add(BannerModel.fromJson(data: item));
      }
      emit(GetBannerSuccessState());
    } else {
      emit(FailedToGetBannerState());
    }
  }

  //
  // get Category data
  List<CategoryModel> categoryModel = [];

  void getCategoryData() async {
    emit(GetCategoryLoadingState());
    Response response = await http
        .get(Uri.parse('https://student.valuxapps.com/api/categories'));

    final responseBody = jsonDecode(response.body);
    print('Category is $responseBody');
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        categoryModel.add(CategoryModel.fromJson(data: item));
      }
      emit(GetCategorySuccessState());
    } else {
      emit(FailedToGetCategoryState());
    }
  }


  //
  // Search data Category
  List<CategoryModel> filteredCategory=[];

  void filterCategory({required String input}){
    filteredCategory =categoryModel.
    where((element) =>
    element.title!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterCategorySuccessState());

  }

  //
  // get Product data
  List<ProductModel> productModel = [];

  void getProductData() async {
    emit(GetProductLoadingState());
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/home'),
        headers: {'Authorization': token!, "lang": "en"});
    final responseBody = jsonDecode(response.body);
    print('Product is $responseBody');
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        productModel.add(ProductModel.fromJson(data: item));
      }

      emit(GetProductSuccessState());
    } else {
      emit(FailedToGetProductState());
    }
  }

  //
  // Search data Product
  List<ProductModel> filteredProduct = [];

  void filterProduct({required String input}) {
      filteredProduct = productModel
          .where((element) =>
          element.name!.toLowerCase().startsWith(input.toLowerCase()))
          .toList();
      emit(FilterProductSuccessState());

  }


  //
  // get Favorites data
  List<ProductModel> favorites = [];
  Set<String> favoriteID =
      {}; // ليه استخدمنا سيت عشان اللي بيتخزن فيها مش بيتكرر
  Future<void> getFavorites() async {
    emit(GetFavoritesLoadingState());
    favorites.clear();
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {'Authorization': token!, "lang": "en"});
    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        favorites.add(ProductModel.fromJson(data: item['product']));
        favoriteID.add(item['product']['id']
            .toString()); // مسؤله عن معرفة id بتاع كل عنصر عشان تستحدمة لما تيجي تضيف او تمسح عن عنصر من favorites
      }
      print("favorites is ${favorites.length}");
      emit(GetFavoritesSuccessState());
    } else {
      emit(FailedToGetFavoritesState());
    }
  }

  //
  // add or remove Favorites data
  void addOrRemoveFavorites({required String productID}) async {
    emit(AddOrRemoveFavoritesLoadingState());
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {
          'Authorization': token!,
          "lang": "en"
        },
        body: {
          'product_id': productID,
        });

    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      if (favoriteID.contains(productID) == true) {
        // delete
        favoriteID.remove(productID);
      } else {
        // s
        // add
        favoriteID.add(productID);
      }
      await getFavorites();
      emit(AddOrRemoveFavoritesSuccessState());
    } else {
      emit(FailedToAddOrRemoveFavoritesState());
    }
  }

  //
  // Search data favorites

  List<ProductModel> filteredFavorite=[];
  void filterFavorite({required String input}){
    filteredFavorite = favorites
        .where((element) =>
        element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterFavoriteSuccessState());
  }


  //
  // get Cart data
  List<ProductModel> cartModel = [];
  Set<String> cartID = {}; // ليه استخدمنا سيت عشان اللي بيتخزن فيها مش بيتكرر
  int totalPrice = 0;

  Future<void> getCartsData() async {
    emit(GetCartsLoadingState());
    cartModel.clear();
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        headers: {'Authorization': token!, "lang": "en"});
    final responseBody = jsonDecode(response.body);
    totalPrice = responseBody['data']['total'].toInt();
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['cart_items']) {
        cartID.add(item['product']['id'].toString());
        cartModel.add(ProductModel.fromJson(data: item['product']));
      }
      print('Cart length is ${cartModel.length}');
      emit(GetCartsSuccessState());
    } else {
      emit(FailedToGetCartsState());
    }
  }

  //
  // add or remove Carts data
  void addOrRemoveCartItem({required String id}) async {
    emit(AddOrRemoveCartsLoadingState());
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        body: {'product_id': id},
        headers: {'Authorization': token!, "lang": "en"});
    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      cartID.contains(id) == true ? cartID.remove(id) : cartID.add(id);
      await getCartsData();
      emit(AddOrRemoveCartsSuccessState());
    } else {
      emit(FailedToAddOrRemoveCartsState());
    }
  }


  //
  // Search data Cart
  List<ProductModel> filteredCart=[];
  void filterCart({required String input}){
    filteredCart = cartModel
        .where((element) =>
        element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterCartSuccessState());
  }
}
