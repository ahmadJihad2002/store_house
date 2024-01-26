import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/account/presentation/bloc/account_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/root_cubit/root_app_cubit.dart';
import 'package:store_house/src/theme/app_color.dart';

class HomeAppBar extends StatefulWidget {
  HomeAppBar({required this.profile, super.key});

  final Map profile;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;

    late String timeOfDay;

    if (hour >= 0 && hour < 12) {
      setState(() {
        timeOfDay = 'صباح الخير';
      });
    } else if (hour >= 12 && hour < 24) {
      setState(() {
        timeOfDay = 'مساء الخير';
      });
    } else {}
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.watch<AccountCubit>().user?.name ?? '',
                style: const TextStyle(
                  color: AppColor.labelColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "! $timeOfDay ",
                style: const TextStyle(
                  color: AppColor.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        ConditionalBuilder(
            condition: context.watch<RootAppCubit>().isConnected,
            builder: (context) => Icon(
                  Icons.online_prediction,
                  color: AppColor.primary,
                ),
            fallback: (context) => Icon(
                  Icons.online_prediction,
                  color: AppColor.labelColor,
                )),
      ],
    );
  }
}
