import 'package:flutter/material.dart';

import 'package:mitosportz/constants/button_styles.dart';
import 'package:mitosportz/constants/colors.dart';
import 'package:mitosportz/constants/text_styles.dart';
import 'package:mitosportz/constants/widget_styles.dart';

class TextInputWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final String hintText;
  final ValueSetter<String> action;
  final String actionText;
  final Function()? altAction;
  final String? altActionText;
  final String? errorText;
  final TextInputType? keyboardType;
  final Color? themeColor;

  const TextInputWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.hintText,
    required this.action,
    required this.actionText,
    this.errorText,
    this.altAction,
    this.altActionText,
    this.keyboardType,
    this.themeColor,
  }) : super(key: key);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget textInputField() {
    return TextFormField(
      controller: _textEditingController,
      style: TextStyles.largeTitle,
      textAlign: TextAlign.center,
      autofocus: true,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          error: (widget.errorText != null)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.errorText!,
                      style:
                          TextStyles.smallBody.copyWith(color: AppColors.red),
                    )
                  ],
                )
              : null,
          hintStyle:
              TextStyles.largeTitle.copyWith(color: AppColors.labelTertiary)),
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
                padding: const EdgeInsets.only(top: 48, bottom: 48),
                child: textInputField()),
            Text(widget.subtitle,
                style: TextStyles.body, textAlign: TextAlign.center),
          ]),
    ));
  }

  Widget submitButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          widget.action(_textEditingController.text);
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
