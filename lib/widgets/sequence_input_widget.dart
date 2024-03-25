import 'package:flutter/material.dart';

import 'package:mitosportz/constants/button_styles.dart';
import 'package:mitosportz/constants/colors.dart';

import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/constants/widget_styles.dart';

class SequenceInputWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<bool> initialValue;
  final ValueSetter<List<bool>> action;
  final String actionText;
  final Function()? altAction;
  final String? altActionText;
  final Color? themeColor;

  const SequenceInputWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.initialValue,
    required this.action,
    required this.actionText,
    this.altAction,
    this.altActionText,
    this.themeColor,
  }) : super(key: key);

  @override
  State<SequenceInputWidget> createState() => _SequenceInputWidgetState();
}

class _SequenceInputWidgetState extends State<SequenceInputWidget> {
  late List<bool> _value;

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = widget.initialValue.map((value) => value).toList();
    });
  }

  Widget sequencer() {
    List<Widget> children = [];

    for (var i = 0; i < _value.length; i++) {
      children.add(_ToggleButton(
          themeColor: widget.themeColor,
          initialValue: _value[i],
          onPressed: (value) {
            setState(() {
              _value[i] = value;
            });
          }));
    }
    return Column(
      children: children,
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
            Text(widget.title,
                style: TextStyles.title.copyWith(
                    color: (widget.themeColor != null)
                        ? widget.themeColor
                        : AppColors.labelPrimary)),
            Padding(
                padding: const EdgeInsets.only(
                    top: 48, bottom: 48, right: 16, left: 16),
                child: sequencer()),
            Text(widget.subtitle,
                style: TextStyles.body, textAlign: TextAlign.center),
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

class _ToggleButton extends StatefulWidget {
  final bool initialValue;
  final ValueSetter<bool> onPressed;
  final Color? themeColor;

  const _ToggleButton(
      {Key? key,
      required this.initialValue,
      required this.onPressed,
      this.themeColor})
      : super(key: key);

  @override
  State<_ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<_ToggleButton> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    setState(() {
      isActive = widget.initialValue;
    });
  }

  void toggle() {
    setState(() {
      isActive = !isActive;
    });
  }

  ButtonStyle buttonToggle() {
    if (!isActive) {
      return ButtonStyles.buttonPrimary.copyWith(
          backgroundColor:
              const MaterialStatePropertyAll<Color>(AppColors.background),
          elevation: const MaterialStatePropertyAll<double>(0),
          fixedSize:
              const MaterialStatePropertyAll<Size?>(Size.fromHeight(32)));
    } else {
      return ButtonStyles.buttonPrimary.copyWith(
          backgroundColor: MaterialStatePropertyAll<Color?>(widget.themeColor),
          fixedSize:
              const MaterialStatePropertyAll<Size?>(Size.fromHeight(32)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          toggle();
          widget.onPressed(isActive);
        },
        style: buttonToggle(),
        child: const SizedBox.expand());
  }
}
