import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/injection/injection_container.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';
import 'package:task_sense/core/widgets/error_widget.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/enums/axis_type.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/gyro_cubit.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/sensor_state.dart';

class GyroscopeChartWidget extends StatelessWidget {
  const GyroscopeChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GyroCubit>()..listenSensorData(),
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2)),
        child: BlocConsumer<GyroCubit, SensorState>(
          listener: (context, state) {
            if (state is SensorLoaded && state.highMovement) {
              _highMovementAlert(context);
            }
          },
          builder: (context, state) {
            if (state is SensorLoaded) {
              return _chartBody(context, state);
            } else if (state is SensorError) {
              return ErrorMessage(error: state.error);
            }
            return const Center(
                child: SpinKitWave(
              color: primaryColor,
              size: 24.0,
            ));
          },
        ),
      ),
    );
  }

  Column _chartBody(BuildContext context, SensorLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            LocaleKeys.gyroTitle.tr(),
            style: context.textStyle.bodyLarge!.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        const Divider(
          height: 2,
          color: borderColor,
        ),
        Expanded(
          child: _createChart(context, state.sensorData),
        ),
      ],
    );
  }

  SfCartesianChart _createChart(BuildContext context, List<SensorEntity> data) {
    return SfCartesianChart(
      plotAreaBorderColor: Colors.black,
      primaryYAxis: NumericAxis(
        title: AxisTitle(
            text: LocaleKeys.gyroYAxisTitle.tr(),
            textStyle: context.textStyle.bodySmall),
      ),
      legend: const Legend(
          isVisible: true,
          position: LegendPosition.right,
          offset: Offset(10, -100)),
      series: <LineSeries<SensorEntity, double>>[
        // X-axis data
        _createLineSeries(name: 'gyro x axis', data: data, axis: AxisType.x),
        // Y-axis data
        _createLineSeries(name: 'gyro y axis', data: data, axis: AxisType.y),
        // Z-axis data
        _createLineSeries(name: 'gyro z axis', data: data, axis: AxisType.z)
      ],
    );
  }

  _createLineSeries(
      {required String name,
      required List<SensorEntity> data,
      required AxisType axis}) {
    return LineSeries<SensorEntity, double>(
      width: 2,
      dataSource: data,
      xValueMapper: (SensorEntity data, int index) => index.toDouble(),
      yValueMapper: (SensorEntity data, _) {
        switch (axis) {
          case AxisType.x:
            return data.x;
          case AxisType.y:
            return data.y;
          case AxisType.z:
            return data.z;
        }
      },
      name: name,
      color: axis.color,
      //markerSettings: const MarkerSettings(isVisible: true),
    );
  }

  void _highMovementAlert(BuildContext parentContext) {
    if (parentContext.read<GyroCubit>().isOnAlert) return;

    parentContext.read<GyroCubit>().isOnAlert = true;
    FlutterRingtonePlayer().playNotification();

    showDialog(
      barrierDismissible: false,
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.warning,
                size: 28,
                color: Colors.red,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(LocaleKeys.alert.tr()),
            ],
          ),
          titleTextStyle: context.textStyle.titleLarge!.copyWith(
            color: Colors.red,
          ),
          content: Text(LocaleKeys.alertContent.tr()),
          contentTextStyle: context.textStyle.titleSmall,
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                parentContext.read<GyroCubit>().isOnAlert = false;
              },
              child: Text(LocaleKeys.ok.tr()),
            ),
          ],
        );
      },
    );
  }
}
