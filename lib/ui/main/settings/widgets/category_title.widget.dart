import 'package:flutter/material.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/dimens.dart';

class CategoryTitleWidget extends StatelessWidget {
  const CategoryTitleWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: Margin.middle),
      child: Text(
        text,
        style: TextStyle(
          color: context.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: Dimens.text_normal,
        ),
      ),
    );
  }
}
