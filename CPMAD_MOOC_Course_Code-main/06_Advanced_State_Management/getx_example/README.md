# GetX State Management Example
A clean, modular Flutter application illustrating GetX reactivity.

## Architecture
- `lib/controllers/counter_controller.dart`: Reactive counter controller with `.obs` variables and business logic methods.
- `lib/controllers/task_controller.dart`: Reactive task list controller demonstrating list reactivity and snackbars.
- `lib/views/home_view.dart`: Primary UI utilizing `Obx` widgets to reactively re-render components.
- `lib/main.dart`: Application initialization using `GetMaterialApp`.
