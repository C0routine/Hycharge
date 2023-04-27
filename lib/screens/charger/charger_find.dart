import 'package:flutter/material.dart';
import 'package:hycharge/widgets/charger/naver_map_widget.dart';
import 'package:hycharge/widgets/charger/custom_navigation_bar.dart';

class ChargerFind extends StatefulWidget {
  const ChargerFind({super.key});

  @override
  State<ChargerFind> createState() => _ChargerFindState();
}

class _ChargerFindState extends State<ChargerFind> {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      body: NaverMapWidget(bottom: bottom),
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
