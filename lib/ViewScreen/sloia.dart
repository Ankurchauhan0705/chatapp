import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SlotMachineController {
  const SlotMachineController({
    required this.start,
    required this.stop,
  });

  final Function({required int? hitRollItemIndex}) start;
  final Function({required int reelIndex}) stop;
}

class SlotMachine extends StatefulWidget {
  const SlotMachine({
    Key? key,
    required this.rollItems,
    this.multiplyNumberOfSlotItems = 2,
    this.shuffle = true,
    this.width = 232,
    this.height = 96,
    this.reelWidth = 72,
    this.reelHeight = 96,
    this.reelItemExtent = 48,
    this.reelSpacing = 8,
    required this.onCreated,
    required this.onFinished,
  }) : super(key: key);

  final List<RollItem> rollItems;
  final int multiplyNumberOfSlotItems;
  final bool shuffle;
  final double width;
  final double height;
  final double reelWidth;
  final double reelHeight;
  final double reelItemExtent;
  final double reelSpacing;
  final Function(SlotMachineController) onCreated;
  final Function(List<int> resultIndexes) onFinished;

  @override
  State<SlotMachine> createState() => _SlotMachineState();
}

class _SlotMachineState extends State<SlotMachine> {
  late SlotMachineController _slotMachineController;
  Map<int, _ReelController> _reelControllers = {};
  List<RollItem> _actualRollItems = [];
  List<int> _resultIndexes = [];
  int _stopCounter = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.multiplyNumberOfSlotItems; i++) {
      _actualRollItems.addAll([...widget.rollItems]);
    }

    _slotMachineController = SlotMachineController(
      start: _start,
      stop: _stop,
    );

    widget.onCreated(_slotMachineController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (index) {
              return _Reel(
                reelWidth: widget.reelWidth,
                reelHeight: widget.reelHeight,
                itemExtent: widget.reelItemExtent,
                rollItems: _actualRollItems,
                shuffle: widget.shuffle,
                onCreated: (lc) => _reelControllers[index] = lc,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  _start({required int? hitRollItemIndex}) {
    _stopCounter = 0;
    _resultIndexes = [];

    if (hitRollItemIndex != null) {
      _resultIndexes.addAll([hitRollItemIndex, hitRollItemIndex, hitRollItemIndex]);
    } else {
      _resultIndexes = _randomResultIndexes(widget.rollItems.length);
    }
    _reelControllers.values.forEach((lc) => lc.start());
  }

  _stop({required int reelIndex}) {
    assert(reelIndex >= 0 && reelIndex <= 2);

    final lc = _reelControllers[reelIndex];
    if (lc == null) return;

    lc.stop(to: _resultIndexes[reelIndex]);

    _stopCounter++;
    if (_stopCounter == 3) {
      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onFinished(_resultIndexes);
      });
    }
  }

  List<int> _randomResultIndexes(int length) {
    final indexes = <int>{};
    while (indexes.length < 3) {
      indexes.add(Random().nextInt(length));
    }
    return indexes.toList();
  }
}

class _ReelController {
  const _ReelController({
    required this.start,
    required this.stop,
  });

  final Function start;
  final Function({required int to}) stop;
}

class _Reel extends StatefulWidget {
  const _Reel({
    Key? key,
    required this.rollItems,
    required this.reelWidth,
    required this.reelHeight,
    required this.itemExtent,
    this.shuffle = true,
    required this.onCreated,
  }) : super(key: key);

  final List<RollItem> rollItems;
  final double reelWidth;
  final double reelHeight;
  final double itemExtent;
  final bool shuffle;
  final Function(_ReelController) onCreated;

  @override
  State<_Reel> createState() => _ReelState();
}

class _ReelState extends State<_Reel> {
  late Timer timer;
  late _ReelController _reelController;
  final _scrollController = FixedExtentScrollController(initialItem: 0);

  @override
  void initState() {
    super.initState();
    _reelController = _ReelController(
      start: _start,
      stop: _stop,
    );
    widget.onCreated(_reelController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.reelWidth,
      height: widget.reelHeight,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: widget.itemExtent,
        physics: FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildLoopingListDelegate(
          children: widget.rollItems.map<Widget>((item) {
            return SizedBox(
              width: widget.reelWidth,
              height: widget.itemExtent*0.1,
              child: item.child,
            );
          }).toList(),
        ),
      ),
    );
  }

  _start() {
    int counter = 0;
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _scrollController.animateToItem(
        counter,
        duration: Duration(milliseconds: 50),
        curve: Curves.linear,
      );
      counter--;
    });
  }

  _stop({required int to}) {
    timer.cancel();
    final hitItemIndex =
    widget.rollItems.indexWhere((item) => item.index == to);

    final mod = (-_scrollController.selectedItem!) % widget.rollItems.length - 1;
    final addCount = (widget.rollItems.length - mod) +
        (widget.rollItems.length - hitItemIndex) -
        1;

    _scrollController.animateToItem(
      _scrollController.selectedItem! - addCount,
      duration: const Duration(milliseconds: 750),
      curve: Curves.decelerate,
    );
  }
}

class RollItem {
  const RollItem({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;
}
