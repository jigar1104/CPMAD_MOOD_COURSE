import '01_variables_and_types.dart' as step1;
import '02_functions_and_control_flow.dart' as step2;
import '03_collections_and_null_safety.dart' as step3;
import '04_oop_classes_and_inheritance.dart' as step4;

void main() {
  print('==============================================');
  print('   MASTERING FLUTTER: DART BASICS RUNNER     ');
  print('==============================================\n');

  print('--- Step 1: Variables & Data Types ---');
  step1.runVariablesDemo();

  print('\n--- Step 2: Functions & Control Flow ---');
  step2.runFunctionsDemo();

  print('\n--- Step 3: Collections & Null Safety ---');
  step3.runCollectionsDemo();

  print('\n--- Step 4: OOP, Classes & Mixins ---');
  step4.runOopDemo();

  print('\nAll Dart fundamentals executed successfully!');
}
