import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/constants/assets.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/injection/injection_container.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_count_cubit.dart';
import 'package:task_sense/features/task_management/presentation/screens/task_screen.dart';
import 'package:task_sense/features/task_management/presentation/widgets/task_search_delegate.dart';
import 'package:task_sense/features/task_management/presentation/widgets/task_title_list_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String path = '/home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskCountCubit>()..taskCount(),
      child: Scaffold(
        body: _createBody(context),
        floatingActionButton: FloatingActionButton.small(
          backgroundColor: context.theme.primaryColor,
          onPressed: () {
            context.push(TaskScreen.path);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: const Icon(
            Icons.add,
            size: 24,
            color: Colors.white,
          ),
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
            color: secondaryBorderColor,
          ),
        ),
        const TaskTitleListWidget(),
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
              const SizedBox(
                height: 4,
              ),
              BlocBuilder<TaskCountCubit, TaskCount>(
                builder: (context, taskCount) {
                  return Text(
                    '${taskCount.incompleteCount} incomplete, ${taskCount.completeCount} completed',
                    style: context.textStyle.bodyMedium!
                        .copyWith(color: secondaryTextColor),
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
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
