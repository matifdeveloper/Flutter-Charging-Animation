/*
********************************************************************************

    _____/\\\\\\\\\_____/\\\\\\\\\\\\\\\__/\\\\\\\\\\\__/\\\\\\\\\\\\\\\_
    ___/\\\\\\\\\\\\\__\///////\\\/////__\/////\\\///__\/\\\///////////__
    __/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\\\\\\\\\_____
    _\/\\\\\\\\\\\\\\\_______\/\\\___________\/\\\_____\/\\\///////______
    _\/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\________/\\\\\\\\\\\_\/\\\_____________
    _\///________\///________\///________\///////////__\///______________

    Created by Muhammad Atif on 2/20/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

import 'dart:developer';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              final status = await FlutterOverlayWindow.isPermissionGranted();
              log("Is Permission Granted: $status");
            },
            child: const Text("Check Permission"),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: () async {
              final bool? res = await FlutterOverlayWindow.requestPermission();
              log("status: $res");
            },
            child: const Text("Request Permission"),
          ),
          const SizedBox(height: 10.0),

          TextButton(
            onPressed: () async {

              startForegroundService();
            },
            child: const Text("Start animation"),
          ),
          // Load a Lottie file from your assets
          //Lottie.asset('assets/animation.json'),
        ],
      ),
    );
  }

  void startForegroundService() async {
    ForegroundService().start();
    debugPrint("Started service");
    try{
      var battery = Battery();
      log('message ----- 2');
      // Be informed when the state (full, charging, discharging) changes
      battery.onBatteryStateChanged.listen((BatteryState state) async{
        log('message ----- 3');
        log("Battery state: ${state.name}");

        if(state == BatteryState.charging){
          if (await FlutterOverlayWindow.isActive()) return;
          await FlutterOverlayWindow.showOverlay(
            enableDrag: false,
            overlayTitle: "Animation",
            overlayContent: 'Animation Enabled',
            flag: OverlayFlag.defaultFlag,
            visibility: NotificationVisibility.visibilitySecret,
            positionGravity: PositionGravity.auto,
            height: WindowSize.fullCover,
            width: WindowSize.fullCover,
          );
        } else{
          await FlutterOverlayWindow.closeOverlay();
        }
      });

      // Check if device in battery save mode
      // Currently available on Android, iOS and Windows platforms only
      log((await battery.isInBatterySaveMode).toString());
    } catch (e){
      log('Background error ----> $e');
    }
  }

}
