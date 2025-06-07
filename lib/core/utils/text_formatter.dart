import 'package:flutter/material.dart';

class TextFormatter {
  // Parse text and make text between ** bold
  static List<TextSpan> parseTextWithBold(String text, TextStyle baseStyle) {
    List<TextSpan> spans = [];
    RegExp regex = RegExp(r'\*\*(.*?)\*\*');
    int lastIndex = 0;

    for (Match match in regex.allMatches(text)) {
      // Add text before the match
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: baseStyle,
        ));
      }

      // Add bold text (content between **) with new line after
      spans.add(TextSpan(
        text: '${match.group(1)!}\n',
        style: baseStyle.copyWith(fontWeight: FontWeight.w800),
      ));

      lastIndex = match.end;
    }

    // Add remaining text after the last match
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: baseStyle,
      ));
    }

    return spans;
  }

  // Detect if text contains Arabic characters
  static bool isArabicText(String text) {
    final arabicRegex = RegExp(
        r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
    return arabicRegex.hasMatch(text);
  }

  // Get text direction based on content
  static TextDirection getTextDirection(String text) {
    return isArabicText(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  // Get text alignment based on content
  static TextAlign getTextAlignment(String text) {
    return isArabicText(text) ? TextAlign.right : TextAlign.left;
  }
}
