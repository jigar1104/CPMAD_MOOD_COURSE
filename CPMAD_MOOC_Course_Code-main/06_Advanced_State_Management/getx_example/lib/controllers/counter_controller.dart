import 'package:get/get.dart';

class CounterController extends GetxController {
  // Reactive counter variable using .obs
  var count = 0.obs;

  // Reactive theme mode toggle
  var isDarkTheme = false.obs;

  void increment() {
    count++;
  }

  void decrement() {
    if (count > 0) {
      count--;
    }
  }

  void reset() {
    count.value = 0;
  }

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
  }
}
