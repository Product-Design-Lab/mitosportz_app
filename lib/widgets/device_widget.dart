import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/constants/widget_styles.dart';

import 'package:mitosportz/widgets/progress_widget.dart';

class DeviceWidget extends StatefulWidget {
  final String name;
  final BluetoothDevice? device;

  const DeviceWidget({Key? key, required this.name, this.device})
      : super(key: key);

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  @override
  void initState() {
    super.initState();
  }

  bool _hasDevice() => widget.device != null;

  Widget _title() {
    return Text("Title",
        style: TextStyles.body.copyWith(
            color: _hasDevice() ? AppColors.green : AppColors.labelTertiary));
  }

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text("Not Connected",
              style: TextStyles.smallBody
                  .copyWith(color: AppColors.labelTertiary)),
        ),
        const ProgressWidget(color: AppColors.green, progress: 0)
      ],
    );
  }

  Widget _status() {
    if (!_hasDevice()) {
      return _empty();
    }

    return StreamBuilder<BluetoothConnectionState>(
      stream: widget.device!.connectionState,
      initialData: BluetoothConnectionState.disconnected,
      builder: ((context, snapshot) {
        if (snapshot.data == BluetoothConnectionState.disconnected) {
          return _empty();
        }
        return _battery();
      }),
    );
  }

  Widget _battery() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text("Connected",
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
