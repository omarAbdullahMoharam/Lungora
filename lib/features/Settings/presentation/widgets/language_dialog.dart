import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/custom_elevated_button.dart';
import 'package:lungora/core/utils/styles.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String _selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.w),
      ),
      contentPadding: EdgeInsets.all(24.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.language, color: kSecondaryColor, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                "Language",
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildLanguageOption("English"),
          _buildLanguageOption("Arabic"),
          CustomElevatedButton(
            text: 'Confirm',
            height: 40,
            onPressed: () {
              Navigator.pop(context, _selectedLanguage);
            },
            backgroundColor: kSecondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Radio(
            value: language,
            groupValue: _selectedLanguage,
            activeColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          Text(
            language,
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
