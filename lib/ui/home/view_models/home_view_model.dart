import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  void play() {
    print("play");
  }
}
