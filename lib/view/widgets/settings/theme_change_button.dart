import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hycharge/view_model/dark_theme.dart';

/// 추후 User Custom Theme 지원을 위한 버튼, 일단 System Theme 를 따라가는게 좋아보임.
class ThemeChangeButton extends StatefulWidget {
  const ThemeChangeButton({super.key});

  @override
  State<StatefulWidget> createState() => _ThemeChangeButton();
}

class _ThemeChangeButton extends State<ThemeChangeButton> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<DarkTheme>().isDark;
    return Container(
      width: 50,
      height: 50,
      color: Colors.white,
      child: Material(
        child: InkWell(
          onTap: () {
            context.read<DarkTheme>().changeDarkMode(!isDarkMode);
            // TODO 바꾼 모드에 대해서 내부 저장소에 저장이 필요.
          },
          child: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
        ),
      ),
    );
  }
}
