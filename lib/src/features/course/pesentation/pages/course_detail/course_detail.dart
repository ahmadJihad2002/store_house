import 'package:flutter/material.dart';
import 'package:store_house/src/features/course/pesentation/pages/course_detail/widgets/course_detail_bottom_block.dart';
import 'package:store_house/src/features/course/pesentation/pages/course_detail/widgets/course_detail_image.dart';
import 'package:store_house/src/features/course/pesentation/pages/course_detail/widgets/course_detail_info.dart';
import 'package:store_house/src/features/course/pesentation/pages/course_detail/widgets/course_detail_tabbar.dart';
import 'package:store_house/src/theme/app_color.dart';

import '../../../domain/entities/course.dart';

// ignore: must_be_immutable
class CourseDetailPage extends StatelessWidget {
  CourseDetailPage({required this.course, this.isHero = false, Key? key})
      : super(key: key);
  Course course;
  bool isHero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: CourseDetailBottomBlock(course: course),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseDetailImage(
            course: course,
            isHero: isHero,
          ),
          const SizedBox(
            height: 15,
          ),
          CourseDetailInfo(
            course: course,
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const CourseDetailTabBar()
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColor.darker),
      backgroundColor: AppColor.appBarColor,
      title: const Text(
        "Detail",
        style: TextStyle(color: AppColor.textColor),
      ),
    );
  }
}
