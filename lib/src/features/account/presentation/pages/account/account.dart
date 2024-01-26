import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/dummy_data.dart';
import 'package:store_house/src/features/account/data/models/user_model.dart';
import 'package:store_house/src/features/account/presentation/bloc/account_cubit.dart';
import 'package:store_house/src/features/account/presentation/pages/account/widgets/account_appbar.dart';
import 'package:store_house/src/features/account/presentation/pages/account/widgets/account_profile_block.dart';
import 'package:store_house/src/features/account/presentation/pages/account/widgets/account_record_block.dart';
import 'package:store_house/src/features/account/presentation/pages/account/widgets/account_section1.dart';
import 'package:store_house/src/features/account/presentation/pages/account/widgets/account_section2.dart';
import 'package:store_house/src/features/account/presentation/pages/account/widgets/account_section3.dart';
import 'package:store_house/src/theme/app_color.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  UserModel user=UserModel.empty();



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          backgroundColor: AppColor.appBgColor,
          pinned: true,
          snap: true,
          floating: true,
          title: AccountAppBar(),
        ),
        SliverToBoxAdapter(child: _buildBody())
      ],
    );
  }

  Widget _buildBody() {
    user = context.watch<AccountCubit>().user!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          AccountProfileBlock(  image: user.image,name: user.name,),
          const SizedBox(
            height: 20,
          ),
          const AccountRecordBlock(),
          // const SizedBox(
          //   height: 20,
          // ),
          // const AccountBlock1(),
          // const SizedBox(
          //   height: 20,
          // ),
          // const AccountBlock2(),
          // const SizedBox(
          //   height: 20,
          // ),
          // const AccountBlock3(),
        ],
      ),
    );
  }
}
