import 'package:flutter/material.dart';
import 'package:hycharge/view_model/station/bottom_sheet_vm.dart';
import 'package:provider/provider.dart';

class StationBottomSheet extends StatefulWidget {
  const StationBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _StationBottomSheet();
}

class _StationBottomSheet extends State<StationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final bottomVM = context.watch<BottomSheetVM>();

    print('Render BottomSheet');
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: bottomVM.bottomSheetInitSize,
      minChildSize: 0,
      // maxChildSize: widget.size,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            controller: scrollController,
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              title: Text('${bottomVM.stationData?.timeStamp} $index'),
            ),
          ),
        );
      },
    );
  }
}
