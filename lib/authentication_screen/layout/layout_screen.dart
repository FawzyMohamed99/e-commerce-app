import 'package:fashion/authentication_screen/layout/layout_cubit/layout_cubit.dart';
import 'package:fashion/authentication_screen/layout/layout_cubit/layout_state.dart';
import 'package:fashion/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.bottomNavIndex,
            mouseCursor: SystemMouseCursors.grab,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            backgroundColor: navColor,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.changeButtonNav(index: index);
            },
            items:  [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Icon(Icons.category),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            cubit.categoryModel.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Icon(Icons.favorite),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            cubit.favorites.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ), label: "Favorites"),
              BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Icon(Icons.shopping_cart),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            cubit.cartModel.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                  , label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),


            ],
          ),
          body: cubit.layoutScreen[cubit.bottomNavIndex],
        );
      },
    );
  }
}
