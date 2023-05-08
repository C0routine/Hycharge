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
      expand: true,
      snap: true,
      snapSizes: const [.32],
      controller: bottomVM.dragController,
      minChildSize: 0,
      initialChildSize: 0,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            controller: scrollController,
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              title: Text('${bottomVM.stationData?.timeStamp} $index'),
              subtitle: Text('${bottomVM.stationData?.name} $index'),
            ),
          ),
        );
      },
    );
  }
}
