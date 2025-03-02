import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
            color: isUser ? const Color(0xFF1071B8) : const Color(0xFFEDF2F7),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            message.content,
            style: isUser
                ? Styles.textStyle12
                    .copyWith(color: Colors.white, fontSize: 16.sp)
                : Styles.textStyle12
                    .copyWith(color: Colors.black, fontSize: 16.sp),
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
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
