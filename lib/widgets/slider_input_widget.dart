import 'package:flutter/material.dart';

import 'package:mitosportz/constants/button_styles.dart';
import 'package:mitosportz/constants/colors.dart';

import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/constants/widget_styles.dart';

class SliderInputWidget extends StatefulWidget {
  final String title;
  final String label;
  final double initialValue;
  final ValueSetter<double> action;
  final String actionText;
  final Function()? altAction;
  final String? altActionText;

  const SliderInputWidget({
    Key? key,
    required this.title,
    required this.label,
    required this.initialValue,
    required this.action,
    required this.actionText,
    this.altAction,
    this.altActionText,
  }) : super(key: key);

  @override
  State<SliderInputWidget> createState() => _SliderInputWidgetState();
}

class _SliderInputWidgetState extends State<SliderInputWidget> {
  double _value = 0;
  bool _updated = false;

  @override
  void initState() {
    super.initState();
  }

  Widget slider() {
    return Slider(
      min: 0,
      max: 100,
      value: _updated ? _value : widget.initialValue,
      inactiveColor: AppColors.background,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
      onChangeStart: (_) {
        setState(() {
          _updated = true;
        });
      },
    );
  }

  Widget inputCard() {
    return Expanded(
        child: Container(
      decoration: WidgetStyles.elevatedCard,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title, style: TextStyles.title),
            Padding(
                padding: const EdgeInsets.only(
                    top: 48, bottom: 48, right: 16, left: 16),
                child: slider()),
            Text(
                "${(_updated ? _value : widget.initialValue).round()}${widget.label}",
                style: TextStyles.body,
                textAlign: TextAlign.center),
          ]),
    ));
  }

  Widget submitButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          widget.action(_value);
        },
        style: ButtonStyles.buttonPrimary,
        child: Text(widget.actionText),
      ),
    );
  }

  Widget altButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: ElevatedButton(
            onPressed: widget.altAction,
            style: ButtonStyles.buttonSecondary,
            child: Text("${widget.altActionText}")),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          inputCard(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(children: [
              submitButton(),
              if (widget.altAction != null) altButton()
            ]),
          )
        ],
      ),
    );
  }
}
