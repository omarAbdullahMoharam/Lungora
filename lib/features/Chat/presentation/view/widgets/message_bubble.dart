import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Chat/data/models/message_model.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == 'user';
    final timeFormat = DateFormat('hh:mm a , dd MMM');

    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 8.h,
            bottom: 4.h,
            left: isUser ? 50.w : 0,
            right: isUser ? 0 : 50.w,
          ),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: isUser
                ? const Color(0xFF1071B8)
                : const Color(0xFF1071B8).withValues(alpha: 0.1),
            borderRadius: isUser
                ? BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(16.r),
                    topLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
          ),
          child: RichText(
            overflow: TextOverflow.visible,
            maxLines: 900,
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: true,
            ),
            textAlign: _getTextAlignment(message.content),
            textDirection: _getTextDirection(message.content),
            text: TextSpan(
              style: isUser
                  ? Styles.textStyle12
                      .copyWith(color: Colors.white, fontSize: 16.sp)
                  : Styles.textStyle12.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16.sp),
              children: _parseTextWithBold(
                message.content,
                isUser
                    ? Styles.textStyle12
                        .copyWith(color: Colors.white, fontSize: 16.sp)
                    : Styles.textStyle12.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16.sp,
                      ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: isUser ? 0 : 8.w,
            right: isUser ? 8.w : 0,
            bottom: 8.h,
          ),
          child: Text(
            timeFormat.format(message.timestamp),
            style: Styles.textStyle14.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _parseTextWithBold(String text, TextStyle baseStyle) {
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
  bool _isArabicText(String text) {
    final arabicRegex = RegExp(
        r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
    return arabicRegex.hasMatch(text);
  }

  // Get text direction based on content
  TextDirection _getTextDirection(String text) {
    return _isArabicText(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  // Get text alignment based on content
  TextAlign _getTextAlignment(String text) {
    return _isArabicText(text) ? TextAlign.right : TextAlign.left;
  }
}
