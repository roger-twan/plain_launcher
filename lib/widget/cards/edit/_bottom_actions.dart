import 'package:flutter/material.dart';

class BottomActions extends StatefulWidget {
  final Function? onPrimaryTaped;
  final Function? onSecondaryTaped;
  final String? primaryTitle;
  final String? secondaryTitle;
  const BottomActions({
    super.key,
    this.onPrimaryTaped,
    this.onSecondaryTaped,
    this.primaryTitle,
    this.secondaryTitle,
  });

  @override
  State<BottomActions> createState() => _BottomActionsState();
}

class _BottomActionsState extends State<BottomActions> {
  @override
  Widget build(BuildContext context) {
    final double basicFontSize =
        Theme.of(context).textTheme.bodyMedium!.fontSize!;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.green,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                if (widget.onPrimaryTaped != null) {
                  widget.onPrimaryTaped!();
                }
              },
              child: Text(widget.primaryTitle ?? '保存',
                  style: TextStyle(fontSize: basicFontSize))),
        ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.red,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                if (widget.onSecondaryTaped != null) {
                  widget.onSecondaryTaped!();
                }
              },
              child: Text(widget.secondaryTitle ?? '取消',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium!.fontSize))),
        )
      ],
    );
  }
}
