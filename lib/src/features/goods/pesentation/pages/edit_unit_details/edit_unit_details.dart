import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_states.dart';
import 'package:store_house/src/features/goods/pesentation/pages/edit_unit_details/widgets/unit_details_appBar.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/build_svg_icon.dart';
import 'package:store_house/src/widgets/custom_button.dart';
import 'package:store_house/src/widgets/custom_progress_indicator.dart';
import 'package:store_house/src/widgets/custom_textfield.dart';

class EditUnit extends StatelessWidget {
  EditUnit({Key? key, required this.unit}) : super(key: key);
  final UnitModel unit;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppChangeQuantityErrorState) {
        AppUtil.showSnackbar(
            context: context, message: 'العدد اقل من 0', color: AppColor.red);
      }
      if (state is AppAddNewTypeErrorState) {
        AppUtil.showSnackbar(
            context: context, message: state.error, color: AppColor.red);
      }
      if (state is AppAddNewTypeSuccessState) {
        AppUtil.showSnackbar(
            context: context,
            message: 'تم الاضافة بنجاح',
            color: AppColor.blue);
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
              title: EditUnitDetailsAppbar(),
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
    TextEditingController name = TextEditingController(text: unit.name);
    TextEditingController description =
        TextEditingController(text: unit.description);

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
            Container(
              height: 200,
              width: 200,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(unit.image),
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
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => cubit.uploadImage(),
              child: const Text('Select image'),
            ),
            const SizedBox(height: 30),
            _buildQuantity(cubit),
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

  _buildQuantity(AppCubit cubit) {
    TextEditingController quantityController =
        TextEditingController(text: unit.quantity.toString());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              cubit.changeQuantity(state: true);
            },
            icon: const BuildSVGIcon(
              height: 40,
              icon: "assets/icons/increment.svg",
            )),
        SizedBox(
          width: 100,
          child: CustomTextBox(
            label: 'الكمية',
            onChange: (string) {
              cubit.quantity = int.parse(string);
            },
            controller: quantityController,
            keyboardType: TextInputType.number,
          ),
        ),
        IconButton(
            onPressed: () {
              cubit.changeQuantity(state: false);
            },
            icon: const BuildSVGIcon(
              icon: "assets/icons/minus.svg",
              height: 30,
            )),
      ],
    );
  }
}
