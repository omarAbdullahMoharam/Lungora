import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Settings/presentation/widgets/theme_dialog.dart';
import 'language_dialog.dart';

class ItemSettingListView extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget? screen;
  final bool hasSwitch;
  final String path;
  final String? comingSoonMessage;

  const ItemSettingListView({
    super.key,
    required this.title,
    required this.icon,
    this.screen,
    this.hasSwitch = false,
    required this.path,
    this.comingSoonMessage,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ItemSettingListViewState createState() => _ItemSettingListViewState();
}

class _ItemSettingListViewState extends State<ItemSettingListView> {
  bool isSwitched = true;
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: ListTile(
        leading: Icon(widget.icon, color: kSecondaryColor),
        title: Text(widget.title, style: Styles.textStyle16),
        trailing: widget.comingSoonMessage != null
            ? Text(
                widget.comingSoonMessage!,
                style: Styles.textStyle14.copyWith(
                    color: kPrimaryColor, fontStyle: FontStyle.italic),
              )
            : widget.hasSwitch
                ? Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: kSecondaryColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                    ),
                  )
                : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () async {
          if (widget.title == "Language") {
            final String? newLanguage = await showDialog(
              context: context,
              builder: (context) => const LanguageDialog(),
            );

            if (newLanguage != null && newLanguage != selectedLanguage) {
              setState(() {
                selectedLanguage = newLanguage;
              });
            }
          } else if (widget.title == "Theme") {
            showThemeDialog(context);
          } else if (widget.screen != null) {
            context.go(widget.path);
          }
        },
      ),
    );
  }
}
