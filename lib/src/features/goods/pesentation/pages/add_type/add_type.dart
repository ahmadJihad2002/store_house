import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_states.dart';
import 'package:store_house/src/features/goods/pesentation/pages/add_type/widgets/addTypeAppBar.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/custom_button.dart';
import 'package:store_house/src/widgets/custom_progress_indicator.dart';
import 'package:store_house/src/widgets/custom_textfield.dart';

class AddType extends StatelessWidget {
  AddType({Key? key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {

      if (state is AppChangeQuantityErrorState) {
        AppUtil.showSnackbar(context: context, message: 'العدد اقل من 0');
      }
      if (state is AppAddNewTypeErrorState) {
        AppUtil.showSnackbar(context: context, message: state.error);
      }
      if (state is AppAddNewTypeSuccessState) {
        AppUtil.showSnackbar(context: context, message: 'تم الاضافة بنجاح');
        // cubit.screenIndex=
      }
    }, builder: (context, state) {

      return Scaffold(
        backgroundColor: AppColor.appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: const AddTypeAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
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

  _buildBody(AppCubit cubit, BuildContext context, AppStates state) {
    TextEditingController quantityController =
        TextEditingController(text: cubit.quantity.toString());
    TextEditingController dateController =
        TextEditingController(text: cubit.selectedDate);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextBox(
              controller: name,
              hint: 'إسم',
            ),
            const SizedBox(height: 30),
            CustomTextBox(
              controller: description,
              label: 'الوصف',
              hint: 'الوصف',
            ),
            const SizedBox(height: 30),
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
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => cubit.uploadImage(),
              child: const Text('Select image'),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      cubit.changeQuantity(state: true);
                    },
                    icon: AppUtil.customIcon(
                        imagePath: "assets/icons/increment.svg", high: 40)),
                IconButton(
                    onPressed: () {
                      cubit.changeQuantity(state: false);
                    },
                    icon: AppUtil.customIcon(
                        imagePath: "assets/icons/minus.svg", high: 30)),
                Expanded(
                    child: CustomTextBox(
                  label: 'الكمية',
                  // hint: 'الكمية',
                  onChange: (string) {
                    cubit.quantity = int.parse(string);
                  },
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                ))
              ],
            ),
            const SizedBox(height: 30),
            CustomTextBox(
              readOnly: true,
              keyboardType: TextInputType.datetime,
              hint: 'تاريخ المستند',
              controller: dateController,
              onTap: () => cubit.selectDate(context),
            ),
            const SizedBox(height: 30),
            ConditionalBuilder(
              condition: state is AppAddNewTypeLoadingState,
              builder: (context) => const CustomProgressIndicator(),
              fallback: (context) => CustomButton(
                  radius: 10,
                  title: "إضافة",
                  onTap: () {
                    print(_formKey.currentState!.validate());

                    cubit.addNewType(
                      name: name.text,
                      description: description.text,
                      image: cubit.image!,
                      quantity: cubit.quantity,
                      price: 0,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
