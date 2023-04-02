import 'package:fashion/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:fashion/authentication_screen/auth_cubit/auth_state.dart';
import 'package:fashion/authentication_screen/layout/layout_screen.dart';
import 'package:fashion/constant/color.dart';
import 'package:fashion/modules/screen/home_page_screen.dart';
import 'package:fashion/modules/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/img.png",), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 50),
                child: const Text(
                  'Login to continue process',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 35),
                decoration: const BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if(state is LoginSuccessState)
                      {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LayoutScreen()),);
                      }
                      else if(state is FailedToLoginState)
                      {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.red,
                              content: Text(
                                state.message,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ));
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          _textFailedItem(
                              controller: emailController, hintText: 'Email'),
                          const SizedBox(
                            height: 15,
                          ),
                          _textFailedItem(
                              isSecure: true,
                              controller: passwordController,
                              hintText: 'Password'),
                          const SizedBox(
                            height: 25,
                          ),
                          MaterialButton(
                              minWidth: double.infinity,
                              color: mainColor,
                              textColor: Colors.white,
                              child:  Text(
                                state is LoginLoadingState
                                    ? 'Loading...'
                                    : 'Login',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: ()
                              {
                                if (formKey.currentState!.validate() == true) {
                                  BlocProvider.of<AuthCubit>(context).login(
                                      email: emailController.text,
                                      password: passwordController.text);
                                } else {}
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have any account? ',
                                  style: TextStyle(color: Colors.black)),
                              SizedBox(
                                width: 4,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));
                                },
                                child: const Text('sign up',
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _textFailedItem(
    {bool? isSecure,
    required TextEditingController controller,
    required String hintText}) {
  return TextFormField(
    controller: controller,
    validator: (input) {
      if (controller.text.isEmpty) {
        return '$hintText must not be empty';
      } else {
        return null;
      }
    },
    obscureText: isSecure ?? false,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
    ),
  );
}
