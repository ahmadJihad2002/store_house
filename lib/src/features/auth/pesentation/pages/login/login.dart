import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/services/util.dart';
import 'package:store_house/src/features/auth/pesentation/bloc/login/cubit.dart';
import 'package:store_house/src/features/auth/pesentation/bloc/login/states.dart';
import 'package:store_house/src/features/auth/pesentation/pages/login/widgets/defaultButton.dart';
import 'package:store_house/src/root_app.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppLoginCubit, AppLoginStates>(
      listener: (BuildContext context, Object? state) {
        if (state is AppLoginSuccessStates) {
          showToast(
            text: 'تمت التسجيل بنجاح',
            state: ToastStates.success,
          );
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const RootApp()));
        }
        if (state is AppLoginErrorStates) {
          showToast(
            text: state.error,
            state: ToastStates.error,
          );
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.grey,
                            fontSize: 30),
                      ),
                      const Text(
                        " قم بتسجيل الدخول لتصفح المنتجات ",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.grey,
                            fontSize: 10),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        icon: Icons.person,
                        label: 'gmail',
                        controller: name,
                        inputType: TextInputType.emailAddress,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "قم بإدخال الاسم بالأول";
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      defaultFormField(
                          validate: (value) {
                            if (value.isEmpty) {
                              return "قم بإدخال الاسم بالأول";
                            }
                          },
                          isPassword: AppLoginCubit.get(context).isPassword,
                          icon: Icons.lock,
                          label: 'password',
                          controller: password,
                          inputType: TextInputType.visiblePassword,
                          suffix: AppLoginCubit.get(context).suffix,
                          suffixOnTap: () => AppLoginCubit.get(context)
                              .changePasswordVisibility()),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! AppLoginLoadingStates,
                        builder: (BuildContext context) {
                          return defaultButton(
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  AppLoginCubit.get(context).userLogin(
                                      email: name.text,
                                      password: password.text);
                                }
                              },
                              text: "text");
                        },
                        fallback: (BuildContext context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
