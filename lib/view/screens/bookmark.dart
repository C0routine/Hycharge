import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<StatefulWidget> createState() => _BookMark();
}

class _BookMark extends State<BookMark>
    with AutomaticKeepAliveClientMixin<BookMark>
{
  int click = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('init BookMark');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('BookMark Screen Render');
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('BookMark Page'),
            TextButton(onPressed: (){
              setState(() {
                click++;
              });
            }, child: Text('click $click'))
          ],
        ),
      ),
    );
  }
}
