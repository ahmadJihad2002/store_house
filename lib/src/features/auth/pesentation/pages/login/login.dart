import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/auth/pesentation/bloc/login/login_cubit.dart';
import 'package:store_house/src/features/auth/pesentation/bloc/login/states.dart';
import 'package:store_house/src/features/goods/pesentation/pages/add_type/widgets/addTypeAppBar.dart';
import 'package:store_house/src/root_app.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/custom_button.dart';
import 'package:store_house/src/widgets/custom_progress_indicator.dart';
import 'package:store_house/src/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController image = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
      if (state is AppLoginErrorStates) {
        AppUtil.showSnackbar(
            context: context,
            message: state.error,
            color: AppColor.errorMsgColor);
      }
      if (state is AppLoginSuccessStates) {
        AppUtil.showSnackbar(
            context: context,
            message: 'تم تسجيل الدخول بنجاح',
            color: AppColor.successMsgColor);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const RootApp()));
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.appBgColor,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: AddTypeAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                addRepaintBoundaries: false,
                addAutomaticKeepAlives: false,
                (context, index) => _buildBody(cubit, context, state),
                childCount: 1,
              ),
            )
          ],
        ),
      );
    });
  }

  _buildBody(LoginCubit cubit, BuildContext context, LoginStates state) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextBox(
                controller: name,
                hint: 'إسم',
                validate: (value) {
                  if (value!.isEmpty) {
                    return "قم بإدخال الاسم بالأول";
                  }
                },
              ),
              CustomTextBox(
                controller: email,
                hint: 'عنوان البريد الإلكتروني',
                validate: (value) {
                  if (value!.isEmpty) {
                    return "قم بإدخال الاسم بالأول";
                  }
                },
              ),
              CustomTextBox(
                validate: (value) {
                  if (value!.isEmpty) {
                    return "قم بإدخال كلمة السر بالأول";
                  }
                },
                keyboardType: TextInputType.visiblePassword,
                hint: 'كلمة السر',
                controller: password,
              ),
              _buildPhoto(cubit),
              ConditionalBuilder(
                condition: state is AppLoginLoadingStates,
                builder: (context) => const CustomProgressIndicator(),
                fallback: (context) => CustomButton(
                    radius: 10,
                    title: "تسجيل الدخول",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.login(
                          name: name.text,
                          image: cubit.image!,
                          email: email.text,
                          password: password.text,
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildPhoto(LoginCubit cubit) {
    return Column(
      children: [
        if (cubit.image != null) ...[
          Container(
            height: 200,
            width: 200,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(cubit.image!),
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 10,
                  spreadRadius: -5,
                )
              ],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
        TextButton(
          onPressed: () => cubit.uploadImage(),
          child: const Text('Select image'),
        ),
      ],
    );
  }
}
