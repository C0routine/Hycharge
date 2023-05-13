import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<StatefulWidget> createState() => BookMarkState();
}

class BookMarkState extends State<BookMark> with AutomaticKeepAliveClientMixin {
  int index = 0;

  @override
  void initState() {
    super.initState();
    // print('init BookMark');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('BookMark Screen Render');
    return Center(
      child: Container(
        // color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            setState(() {
              index++;
            });
          },
          child: Text('current Tap : $index'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
