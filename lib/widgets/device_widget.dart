import 'package:flutter/material.dart';
import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/constants/widget_styles.dart';
import 'package:mitosportz/widgets/progress_widget.dart';

class DeviceWidget extends StatefulWidget {
  const DeviceWidget({Key? key}) : super(key: key);

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  Widget _title() {
    return Text("Title",
        style: TextStyles.body.copyWith(color: AppColors.green));
  }

  Widget _status() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text("Status",
              style: TextStyles.smallBody
                  .copyWith(color: AppColors.labelTertiary)),
        ),
        const ProgressWidget(color: AppColors.green, progress: 0.5)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 168,
        decoration: WidgetStyles.elevatedCard,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _title(),
                _status(),
              ]),
        ),
      ),
    );
  }
}
