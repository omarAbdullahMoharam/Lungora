import 'package:flutter/material.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/providers/theme_provider.dart';
import 'package:lungora/core/utils/custom_elevated_button.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:provider/provider.dart';

void showThemeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ThemeDialog();
    },
  );
}

class ThemeDialog extends StatefulWidget {
  const ThemeDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThemeDialogState createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  String _selectedTheme = "Light";

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.color_lens, color: kSecondaryColor),
          const SizedBox(width: 8),
          Text("Theme",
              style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRadioOption("Light"),
          _buildRadioOption("Dark"),
          _buildRadioOption("Use system settings"),
        ],
      ),
      actions: [
        CustomElevatedButton(
          text: 'Confirm',
          onPressed: () {
            themeProvider.setTheme(_selectedTheme);
            Navigator.of(context).pop();
          },
          backgroundColor: kSecondaryColor,
        ),
      ],
    );
  }

  Widget _buildRadioOption(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<String>(
          value: title,
          groupValue: _selectedTheme,
          activeColor: kSecondaryColor,
          onChanged: (value) {
            setState(() => _selectedTheme = value!);
          },
        ),
        Text(title, style: Styles.textStyle16),
      ],
    );
  }
}
