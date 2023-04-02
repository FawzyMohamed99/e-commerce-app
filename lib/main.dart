import 'package:fashion/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:fashion/authentication_screen/layout/layout_cubit/layout_cubit.dart';
import 'package:fashion/constant/constanc.dart';
import 'package:fashion/modules/screen/splash_screen.dart';
import 'package:fashion/shared/network/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
  token = CacheNetwork.getCacheData(key: 'token');
  print('token is : $token');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LayoutCubit()..getBannerData()..getCategoryData()..getProductData()..getFavorites()..getCartsData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fashion',
        home:SplashScreen(),
      ),
    );
  }
}
