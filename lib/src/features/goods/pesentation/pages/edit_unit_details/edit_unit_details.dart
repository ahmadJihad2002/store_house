import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/edit_cubit/edit_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/edit_cubit/edit_states.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/pages/edit_unit_details/widgets/unit_details_appBar.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/build_svg_icon.dart';
import 'package:store_house/src/widgets/custom_button.dart';
import 'package:store_house/src/widgets/custom_progress_indicator.dart';
import 'package:store_house/src/widgets/custom_textfield.dart';
import 'package:store_house/src/widgets/show_dialog.dart';

class EditUnit extends StatefulWidget {
  EditUnit({Key? key, required this.unit}) : super(key: key);
  final UnitModel unit;

  @override
  State<EditUnit> createState() => _EditUnitState();
}

class _EditUnitState extends State<EditUnit> {
  final _formKey = GlobalKey<FormState>();
  bool disableButton = false;

  File? image;

  void uploadImage() async {
    // Step #1: Pick Image From Galler.
    await AppUtil.pickImageFromGallery().then((pickedFile) async {
      // Step #2: Check if we actually picked an image. Otherwise -> stop;
      if (pickedFile == null) return;

      // Step #3: Crop earlier selected image
      await AppUtil.cropSelectedImage(pickedFile.path).then((croppedFile) {
        // Step #4: Check if we actually cropped an image. Otherwise -> stop;
        if (croppedFile == null) return;

        setState(() {
          image = croppedFile;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    EditUnitCubit cubit = EditUnitCubit.get(context);
    cubit.quantity = widget.unit.quantity;

    return BlocConsumer<EditUnitCubit, EditUnitStates>(
        listener: (context, state) {
      if (state is EditChangeQuantityErrorState) {
        AppUtil.showSnackbar(
            context: context, message: 'العدد اقل من 0', color: AppColor.red);
      }

      if (state is EditUnitSuccessState) {
        Navigator.pop(context);
        context.read<GoodsCubit>().getAllGoods();
        AppUtil.showSnackbar(
            context: context,
            message: 'تم التعديل بنجاح',
            color: AppColor.successMsgColor);
      }
      if (state is DeleteUnitErrorState) {
        AppUtil.showSnackbar(
            context: context,
            message: state.error,
            color: AppColor.errorMsgColor);
      }
      if (state is DeleteUnitSuccessState) {
        AppUtil.showSnackbar(
            context: context,
            message: 'تم الحذف بنجاح',
            color: AppColor.successMsgColor);
        Navigator.pop(context);
        context.read<GoodsCubit>().getAllGoods();
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
                (context, index) => _buildBody(context, state, cubit),
                childCount: 1,
              ),
            )
          ],
        ),
      );
    });
  }

  _buildBody(BuildContext context, EditUnitStates state, EditUnitCubit cubit) {
    TextEditingController name = TextEditingController(text: widget.unit.name);
    TextEditingController description =
        TextEditingController(text: widget.unit.description);
    TextEditingController threshold =
        TextEditingController(text: widget.unit.threshold.toString());
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextBox(
                controller: name,
                label: 'إسم',
              ),
              CustomTextBox(
                controller: description,
                label: 'الوصف',
              ),
              CustomTextBox(
                keyboardType: TextInputType.number,
                controller: threshold,
                label: 'الحد الأدنى لتفعيل التنبيه',
              ),
              _buildPhoto(),
              _buildQuantity(cubit),
              Row(children: [
                Expanded(
                  flex: 1,
                  child: ConditionalBuilder(
                    condition: state is DeleteUnitLoadingState,
                    builder: (context) => const CustomProgressIndicator(),
                    fallback: (context) => CustomButton(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                                message: 'سيتم حذف العنصر بشكل نهائي',
                                title: 'تأكيد الحذف',
                                onTapAction: () {
                                  cubit.deleteUnit(id: widget.unit.id);
                                }),
                          );
                        },
                        title: 'حذف',
                        textColor: AppColor.secondary,
                        bgColor: AppColor.white),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: ConditionalBuilder(
                    condition: state is EditUnitLoadingState,
                    builder: (context) => const CustomProgressIndicator(),
                    fallback: (context) => CustomButton(
                        disableButton: disableButton,
                        radius: 10,
                        title: "تعديل",
                        onTap: () {
                          print(_formKey.currentState!.validate());
                          context.read<EditUnitCubit>().editUnit(
                              threshold: int.parse(threshold.text),
                              id: widget.unit.id,
                              name: name.text,
                              description: description.text,
                              image: image,
                              price: 0,
                              quantity: cubit.quantity);
                        }),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  _buildPhoto() {
    return Column(
      children: [
        if (image != null) ...[
          Container(
            height: 200,
            width: 200,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(image!),
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
        if (image == null) ...[
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.unit.image),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.shadowColor.withOpacity(0.05),
                  spreadRadius: .5,
                  blurRadius: .5,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => uploadImage(),
          child: const Text('إختيار صورة '),
        ),
      ],
    );
  }

  _buildQuantity(EditUnitCubit cubit) {


    TextEditingController quantityController =
        TextEditingController(text: widget.unit.quantity.toString());
    return CustomTextBox(
      readOnly: true,
      label: 'الكمية',
      onChange: (string) {
        cubit.quantity = int.parse(string);
      },
      controller: quantityController,
      keyboardType: TextInputType.number,
    );
  }
}
