import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sense/app/flavors.dart';
import 'package:task_sense/config/routes/navigator_observer.dart';
import 'package:task_sense/features/sensor_tracker/presentation/screens/sensor_tracker_screen.dart';
import 'package:task_sense/features/startup/presentation/screens/selection_screen.dart';
import 'package:task_sense/features/startup/presentation/screens/splash_screen.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/presentation/screens/home_screen.dart';
import 'package:task_sense/features/task_management/presentation/screens/task_details_screen.dart';
import 'package:task_sense/features/task_management/presentation/screens/task_screen.dart';

class RouterManager {
  static final config = GoRouter(
      observers: [
        CustomNavigatorObserver(),
      ],
      initialLocation: SelectionScreen.path,
      routes: [
        GoRoute(
          path: SelectionScreen.path,
          builder: (context, state) =>
              const FlavorBanner(show: kDebugMode, child: SelectionScreen()),
        ),
        GoRoute(
          path: SplashScreen.path,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: SensorTrackerScreen.path,
          builder: (context, state) => const SensorTrackerScreen(),
        ),
        GoRoute(
          path: HomeScreen.path,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: TaskScreen.path,
          builder: (context, state) => TaskScreen(
            taskList: state.extra != null ? state.extra as TaskListModel : null,
          ),
        ),
        GoRoute(
            path: TaskDetailsScreen.path,
            builder: (context, state) {
              final int id = int.parse(state.uri.queryParameters['id']!);
              return TaskDetailsScreen(
                task: state.extra as TaskModel,
                taskListId: id,
              );
            }),
      ]);
}

class FlavorBanner extends StatelessWidget {
  final Widget child;
  final bool show;

  const FlavorBanner({super.key, required this.child, required this.show});

  @override
  Widget build(BuildContext context) {
    return show
        ? Banner(
            location: BannerLocation.topEnd,
            message:
                Flavor.appFlavor == FlavorType.development ? 'dev' : 'prod',
            color: Colors.green.withOpacity(0.6),
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0),
            textDirection: TextDirection.ltr,
            child: child,
          )
        : Container(
            child: child,
          );
  }
}
