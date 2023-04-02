

import 'dart:io';

import 'package:fashion/authentication_screen/layout/layout_cubit/layout_cubit.dart';
import 'package:fashion/authentication_screen/layout/layout_cubit/layout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context)..getUserData();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Fashion 👕👚'),
          ),
          body: cubit.userModel != null ?
          Column(
                  children: [
                    Text(cubit.userModel!.name!),
                     SizedBox(
                      height: 10,
                    ),
                    Text(cubit.userModel!.email!),

                  ],
                )
              :  Center(
                  child: CircularProgressIndicator(),
                ),

        );
      },
    );
  }
}
