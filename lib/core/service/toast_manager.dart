import 'dart:async';
import 'package:flutter/cupertino.dart';

import '../../features/shared/widgets/toast_card.dart';

class ToastManager{
  static final ToastManager _instance = ToastManager._internal();
  ToastManager._internal();

  factory ToastManager() => _instance;

  OverlayEntry? _currentEntry;
  Timer? _timer;

  void show(BuildContext context, String message){
    _clearCurrent();

    _currentEntry = OverlayEntry(builder: (context) => ToastCard(message: message));
    Overlay.of(context).insert(_currentEntry!);
    _timer = Timer(const Duration(milliseconds: 4000), () {
      _clearCurrent();
    });
  }

  void _clearCurrent(){
    _currentEntry?.remove();
    _currentEntry = null;
    _timer?.cancel();
    _timer = null;
  }
}