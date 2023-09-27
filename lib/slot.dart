import 'package:flutter/material.dart';
import 'package:chatapp/ViewScreen/sloia.dart';

class slot extends StatefulWidget {
  const slot({Key? key}) : super(key: key);

  @override
  State<slot> createState() => _slotState();
}

class _slotState extends State<slot> {
  late SlotMachineController _slotMachineController;

  @override
  void initState() {
    super.initState();
    _slotMachineController = SlotMachineController(
      start: _startSlot,
      stop: _stopSlot,
    );
  }

  void _startSlot({required int? hitRollItemIndex}) {
    _slotMachineController.start(hitRollItemIndex: hitRollItemIndex);
  }

  void _stopSlot({required int reelIndex}) {
    _slotMachineController.stop(reelIndex: reelIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
          Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlotMachine(
                rollItems: [
                  RollItem(index: 0, child:Container
                    (height: 100,width: 50,decoration:BoxDecoration(
                        shape: BoxShape.rectangle, image: DecorationImage(fit: BoxFit.fill,
                            image: AssetImage("assets/water.jpg"),),),),),
                  RollItem(index: 1, child:Container
                    (height: 100,width: 50,decoration:BoxDecoration(
                    shape: BoxShape.rectangle, image: DecorationImage( fit: BoxFit.fill,
                    image: AssetImage("assets/badal.jpg"),),),),),
                  RollItem(index: 2, child: Container(height: 100,width: 50,color: Colors.green),),
                  RollItem(index: 3, child:Container(height: 100,width: 50,color: Colors.brown,),),
                  RollItem(index: 4, child:Container(height: 100,width: 50,color: Colors.yellow,),),
                  RollItem(index: 5, child:Container(height: 100,width: 50,color: Colors.blue,),),
                  RollItem(index: 6, child:Container(height: 100,width: 50,color: Colors.blue,),),

                ], // Replace with your list of RollItems
                onCreated: (controller) {
                  _slotMachineController = controller;
                },
                onFinished: (resultIndexes) {
                  // Handle the finished result here
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _startSlot(hitRollItemIndex: null); // Replace null with the index to hit if needed
                },
                child: Text("Start"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Stop each reel here
                  _stopSlot(reelIndex: 0); // Stop the first reel
                  _stopSlot(reelIndex: 1); // Stop the second reel
                  _stopSlot(reelIndex: 2); // Stop the third reel
                },
                child: Text("Stop"),
              ),
            ],
          ),  )

    );
  }
}
