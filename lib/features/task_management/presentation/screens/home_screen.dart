import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/constants/assets.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/features/task_management/presentation/widgets/task_search_delegate.dart';

class HomeScreen extends StatelessWidget {
  static const String path = '/home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondarySurfaceColor,
      body: _createBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: const Icon(
          Icons.add,
          size: 42,
          color: Colors.white,
        ),
      ),
    );
  }

  _createBody(BuildContext context) {
    return Column(
      children: [
        _createHeader(context),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            height: 2,
            color: borderColor,
          ),
        ),
      ],
    );
  }

  Widget _createHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 24, left: 16, right: 16),
      child: Row(
        children: [
          Image.asset(
            Assets.imagesProfile,
            height: 42,
            width: 42,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Zoyeb Ahmed',
                style: context.textStyle.titleLarge,
              ),
              Text(
                '5 incomplete, 5 completed',
                style: context.textStyle.bodyMedium!
                    .copyWith(color: secondaryTextColor),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                log('on pressed');
                showSearch(context: context, delegate: TaskSearchDelegate());
              },
              icon: Image.asset(
                Assets.iconsSearch,
                height: 24,
                width: 24,
              ))
        ],
      ),
    );
  }
}
