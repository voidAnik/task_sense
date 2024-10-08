import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/injection/injection_container.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';
import 'package:task_sense/core/widgets/error_widget.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/enums/axis_type.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/accelerometer_cubit.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/sensor_state.dart';

class AccelerometerChartWidget extends StatelessWidget {
  const AccelerometerChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccelerometerCubit>()..listenSensorData(),
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor)),
        child: BlocBuilder<AccelerometerCubit, SensorState>(
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
            LocaleKeys.accelTitle.tr(),
            style: context.textStyle.bodyLarge!.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        const Divider(
          height: 2,
          color: borderColor,
        ),
        _createChart(context, state.sensorData, AxisType.z),
        _createChart(context, state.sensorData, AxisType.y),
        _createChart(context, state.sensorData, AxisType.x),
      ],
    );
  }

  Widget _createChart(
      BuildContext context, List<SensorEntity> data, AxisType axis) {
    return SizedBox(
      height: context.height * 0.15,
      child: Stack(children: [
        SfCartesianChart(
          plotAreaBorderColor: Colors.black,
          title: ChartTitle(
              text: axis.value,
              textStyle: context.textStyle.titleSmall!.copyWith(
                fontSize: 12,
              )),
          series: <LineSeries<SensorEntity, double>>[
            LineSeries<SensorEntity, double>(
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
              name: axis.value,
              color: axis.color,
              /*gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    axis.color.withOpacity(0.2),
                    axis.color.withOpacity(0.2)
                  ]),*/
            )
          ],
        ),
        // Overlay box with opacity
        Positioned(
          bottom: 38,
          left: context.width * 0.22,
          child: Container(
            width: context.width * 0.5, // Width of the box
            height: context.height * 0.05, // Height of the box
            color: axis.color.withOpacity(0.15), // Box color with opacity
          ),
        ),
      ]),
    );
  }
}
