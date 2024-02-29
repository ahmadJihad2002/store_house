import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_states.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/pages/add_type/widgets/addTypeAppBar.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/build_svg_icon.dart';
import 'package:store_house/src/widgets/custom_button.dart';
import 'package:store_house/src/widgets/custom_progress_indicator.dart';
import 'package:store_house/src/widgets/custom_textfield.dart';

class AddNewType extends StatelessWidget {
  AddNewType({Key? key}) : super(key: key);

  TextEditingController name = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController threshold = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AddTypeStates>(listener: (context, state) {
      if (state is AppChangeQuantityErrorState) {
        AppUtil.showSnackbar(
          context: context,
          message: 'العدد اقل من 0',
          color: AppColor.errorMsgColor,
        );
      }
      if (state is AppAddNewTypeErrorState) {
        AppUtil.showSnackbar(
            context: context,
            message: state.error,
            color: AppColor.errorMsgColor);
      }
      if (state is AppAddNewTypeSuccessState) {
        AppUtil.showSnackbar(
            context: context,
            message: 'تم الاضافة بنجاح',
            color: AppColor.successMsgColor);

        context.read<GoodsCubit>().getAllGoods();
        cubit.image = null;
        cubit.quantity = 0;
        Navigator.pop(context);
      }
      if (state is AppAddNewTypeLoadingState) {

        context.read<AppCubit>().disableButton = true;
      } else {
        context.read<AppCubit>().disableButton = false;
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

  _buildBody(AppCubit cubit, BuildContext context, AddTypeStates state) {
    TextEditingController dateController =
        TextEditingController(text: cubit.selectedDate);
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextBox(
              validate: (string) {
                if (string == null || string.isEmpty) {
                  return 'أضف اسم';
                } else {
                  return null;
                }
              },
              controller: name,
              hint: 'إسم',
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              controller: description,
              hint: 'الوصف',
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              readOnly: true,
              keyboardType: TextInputType.datetime,
              hint: 'تاريخ المستند',
              controller: dateController,
              onTap: () => cubit.selectDate(context),
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              keyboardType: TextInputType.number,
              hint: 'العدد الأدنى لتفعيل التنبيه (إختياري)',
              controller: threshold,
            ),
            const SizedBox(height: 30),
            _buildPhoto(cubit),
            const SizedBox(height: 30),
            _buildQuantity(cubit),
            const SizedBox(height: 30),
            _buildButton(cubit, state,context)
          ],
        ),
      ),
    );
  }

  _buildButton(AppCubit cubit, AddTypeStates state,BuildContext context) {
    return ConditionalBuilder(
      condition: state is AppAddNewTypeLoadingState,
      builder: (context) => const CustomProgressIndicator(),
      fallback: (context) => CustomButton(


          disableButton:  context.watch<AppCubit>().disableButton ,
          radius: 10,
          title: "إضافة",
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (cubit.image != null) {
                cubit.addNewType(
                  name: name.text,
                  description: description.text,
                  image: cubit.image!,
                  quantity: cubit.quantity,
                  price: 0,
                  threshold: int.tryParse(threshold.text),
                );
                cubit.image != null;
              } else {
                AppUtil.showSnackbar(
                    context: context,
                    message: 'قم بإضافة صورة',
                    color: AppColor.warningMsgColor);
              }
            }

            cubit.disableButton = true;
          }),
    );
  }

  _buildQuantity(AppCubit cubit) {
    TextEditingController quantityController =
        TextEditingController(text: cubit.quantity.toString());
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

  _buildPhoto(AppCubit cubit) {
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
        if (cubit.image == null) ...[
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(0.05),
                spreadRadius: .5,
                blurRadius: .5,
                offset: const Offset(0, 1),
              ),
            ], border: Border.all(style: BorderStyle.solid)),
            child: GestureDetector(
                onTap: () => cubit.uploadImage(),
                child: const Center(
                  child: BuildSVGIcon(
                    height: 50,
                    icon: 'assets/icons/addPhoto.svg',
                  ),
                )),
          ),
        ],
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => cubit.uploadImage(),
          child: const Text('إختيار صورة '),
        ),
      ],
    );
  }
}
