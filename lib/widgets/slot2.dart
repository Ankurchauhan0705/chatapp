import 'package:flutter/material.dart';
import 'dart:math';

class SlotMachine {
  late List<List<int>> reels;
  late Map<String, int> wins;

  SlotMachine(int reelNum, Map<String, int> winDict) {
    reels = List.generate(reelNum, (index) => [for (int i = 0; i < 10; i++) i]);
    wins = winDict;
  }

  String spin() {
    String spinResult = '';
    for (List<int> reel in reels) {
      spinResult += reel[Random().nextInt(reel.length)].toString();
    }
    return spinResult;
  }

  String simulation(int spinCount, double potAmt, double betAmt) {
    int jackpots = 0;
    double startingPot = potAmt;
    double totalPaid = 0;
    int winningSpins = 0;

    for (int i = 0; i < spinCount; i++) {
      potAmt += betAmt;
      String currSpin = spin();
      List<String> hits = wins.keys.where((item) => currSpin.contains(item)).toList();
      if (hits.isNotEmpty) {
        int multiplier = wins[hits.reduce((a, b) => wins[a]! > wins[b]! ? a : b)]!;
        double payout = betAmt * multiplier;
        potAmt -= payout;
        totalPaid += payout;
        winningSpins++;
        if (multiplier == wins.values.reduce(max)) {
          jackpots++;
        }
      }
    }

    double returnToPlayer = totalPaid / (betAmt * spinCount);
    double profit = potAmt - startingPot;

    if (totalPaid == 0) {
      profit = -profit;
      return '$winningSpins wins/$spinCount spins.  Simulated profit: \$$profit. RTP: 0.0';
    } else {
      return '$winningSpins wins/$spinCount spins.  Simulated profit: \$${profit.toStringAsFixed(2)}. RTP: ${returnToPlayer.toStringAsFixed(2)}';
    }
  }
}

void main() {
  SlotMachine slot1 = SlotMachine(3, {"777": 300, "888": 300, "999": 300});
  SlotMachine slot2 = SlotMachine(4, {
    '7': 1,
    '77': 10,
    '777': 150,
    '7777': 1000
  });

  int spinCount1 = 100000;
  double potAmt1 = 20000;
  double betAmt1 = 2;

  int spinCount2 = 1000000;
  double potAmt2 = 20000;
  double betAmt2 = 2;

  String result1 = slot1.simulation(spinCount1, potAmt1, betAmt1);
  String result2 = slot2.simulation(spinCount2, potAmt2, betAmt2);

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Slot Machine Simulations'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(result1),
              SizedBox(height: 20),
              Text(result2),
            ],
          ),
        ),
      ),
    ),
  );
}
