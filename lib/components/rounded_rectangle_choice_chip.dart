import 'package:flutter/material.dart';

class RoundedRectangleChoiceChip extends StatelessWidget {
  RoundedRectangleChoiceChip({
    required this.selected,
    required this.label,
    this.selectedColor,
    this.onSelected,
  });

  final bool selected;
  final Widget label;
  final Color? selectedColor;
  final void Function(bool value)? onSelected;

  @override
  Widget build(BuildContext context) {
    final ChipThemeData chipTheme = ChipTheme.of(context);
    return ChoiceChip(
      labelStyle: selected && selectedColor != null
          ? chipTheme.secondaryLabelStyle?.copyWith(color: selectedColor)
          : null,
      selectedColor:
          selectedColor != null ? selectedColor!.withOpacity(0.2) : null,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color: selected && selectedColor != null
                  ? selectedColor!
                  : chipTheme.backgroundColor ?? Color.fromRGBO(0, 0, 0, 0.2)),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      label: label,
      selected: selected,
      onSelected: onSelected,
    );
  }
}
