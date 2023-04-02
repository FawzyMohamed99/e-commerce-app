import 'package:fashion/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:fashion/authentication_screen/auth_cubit/auth_state.dart';
import 'package:fashion/authentication_screen/layout/layout_screen.dart';
import 'package:fashion/constant/color.dart';
import 'package:fashion/modules/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState)
        {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LayoutScreen()));
        }
        else if (state is FailedToRegisterState)
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
        return Form(
          key: formKey,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _textFailedItem(
                      controller: nameController, hintText: 'User Name'),
                  const SizedBox(
                    height: 15,
                  ),
                  _textFailedItem(
                      controller: emailController, hintText: 'Email'),
                  const SizedBox(
                    height: 15,
                  ),
                  _textFailedItem(
                      controller: phoneController, hintText: 'Phone'),
                  const SizedBox(
                    height: 15,
                  ),
                  _textFailedItem(
                      isSecure: true,
                      controller: passwordController,
                      hintText: 'Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() == true) {
                        BlocProvider.of<AuthCubit>(context).register(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text);
                      } else {}
                    },
                    child: Text(
                      state is RegisterLoadingState ? 'Loading...' : 'Register',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: mainColor,
                    textColor: Colors.white,
                    minWidth: double.infinity,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? ',
                          style: TextStyle(color: Colors.black)),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: const Text('login in',
                            style: TextStyle(
                                color: mainColor, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
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
