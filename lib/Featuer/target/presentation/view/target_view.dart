import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../data/target_model.dart';
import '../manager/target_state.dart';
import '../manager/targetcubit.dart';

class TrargetView extends StatelessWidget {
  const TrargetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xffE32020),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          ' الأهداف',
          style: Styles.textStyle24(context).copyWith(color: Colors.white),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.wechat_sharp, color: Colors.white),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: const Icon(
        //       Icons.phone_outlined,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: BlocProvider(
        create: (context) => GoalCubit()..getGoals(),
        child: const TargetViewBody(),
      ),
    );
  }
}

class TargetViewBody extends StatelessWidget {
  const TargetViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalCubit, GoalState>(builder: (context, state) {
      if (state is GoalLoading) {
        return buildLoadingIndicator();
      } else if (state is GoalLoaded) {
        return ListView.builder(
          itemCount: state.goals.length,
          itemBuilder: (context, index) {
            final goal = state.goals[index];
            return TargetViewItem(
              goal: goal,
            );
          },
        );
      } else if (state is GoalError) {
        return builError(state.message);
      } else {
        return Center(
            child: SvgPicture.asset('assets/images/No data-pana (2).svg'));
      } // Empty container for initial or unknown states
    });
  }
}

class TargetViewItem extends StatelessWidget {
  final Goal goal;
  const TargetViewItem({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('الأهداف', style: Styles.textStyle24(context)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.person, color: Color(0xffE32020)),
              Expanded(
                child: Text('اسم التاجر: ${goal.supplierstorename}',
                    style: Styles.textStyle24(context)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.crisis_alert_outlined,
                color: Color(0xffE32020),
              ),
              Expanded(
                child: Text('الهدف', style: Styles.textStyle20(context)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'قيمة الفاتورة: ${goal.minPrice}',
                  style: Styles.textStyle18(context),
                ),
              ),
              Text('خصم: ${goal.discountPrice}',
                  style: Styles.textStyle18(context)),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'تم تحقيق الهدف',
                  style: Styles.textStyle18(context),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
