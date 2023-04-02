import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fashion/shared/network/local_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:fashion/authentication_screen/auth_cubit/auth_state.dart';
import 'package:http/http.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  //Register http || Dio
  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/register'),
        headers: {
          'lang': 'en'
        },
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      //emit success
      print(responseBody);
      emit(RegisterSuccessState());
    } else {
      //emit failed
      print(responseBody);
      emit(FailedToRegisterState(message: responseBody['message']));
    }
  }

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      Response response = await http.post(
          Uri.parse('https://student.valuxapps.com/api/login'),
          headers: {'lang': 'en'},
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint('user login success and his data is : $data');
         await CacheNetwork.insertToCache(key: 'token', value: data['data']['token']);
          emit(LoginSuccessState());
        } else {
          debugPrint('failed is login, reason is :${data['message']}');
          emit(FailedToLoginState(message: data['message']));
        }
      }
    } on Exception catch (e) {
      emit(FailedToLoginState(message: e.toString()));
    }
  }

}

