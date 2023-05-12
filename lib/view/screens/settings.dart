import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _Settings();
}

class _Settings extends State<Settings>
    // with AutomaticKeepAliveClientMixin<Settings>
{
  // @override
  // bool get wantKeepAlive => true;


  @override
  void initState() {
    super.initState();
    print('init Settings');
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    print('Settings Screen Render');
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
