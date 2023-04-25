import 'package:flutter/material.dart';
import 'package:instagram_clone/extensions/string/remove_all.dart';

// Convert 0xrrggbb or #rrggbb to Flutter color, i.e ffrrggbb
extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
        int.parse(
          //Remove any String with 0x or #, then make the String 8 values with ff to the left
          removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}
