# Mastering Flutter: From Basics to Advanced by Building Apps

Local course code collection for the CPMAD MOOC assignment. The Udemy course is by **Shamsaagazarzoo Alam**. The numbered folders follow the nine public curriculum sections. [Udemy course](https://www.udemy.com/course/mastering-flutter-from-basics-to-advanced-by-building-apps/)

## Section index

| Section | Examples |
| --- | --- |
| 1. [Introduction to Flutter](01_Introduction_to_Flutter/README.md) | [Dart fundamentals](01_Introduction_to_Flutter/dart_basics/README.md), [Hello World](01_Introduction_to_Flutter/hello_world_app/README.md) |
| 2. [Basic widgets and layouts](02_Basic_Widgets_and_Layouts/README.md) | [Text](02_Basic_Widgets_and_Layouts/text_widget/README.md), [Buttons](02_Basic_Widgets_and_Layouts/button_widget/README.md), [Image and network fallback](02_Basic_Widgets_and_Layouts/image_widget/README.md), [Row and Column](02_Basic_Widgets_and_Layouts/row_column_layout/README.md), [Container and spacing](02_Basic_Widgets_and_Layouts/container_widget/README.md) |
| 3. [State management](03_State_Management/README.md) | [Stateless and stateful widgets](03_State_Management/stateful_stateless/README.md), [Counter, random colors and text contrast](03_State_Management/setstate_example/README.md) |
| 4. [Navigation and routing](04_Navigation_and_Routing/README.md) | [Push, pop and replace routes](04_Navigation_and_Routing/basic_navigation/README.md), [Pass a username and return a typed result](04_Navigation_and_Routing/passing_data/README.md), [Named routes and arguments](04_Navigation_and_Routing/named_routes/README.md) |
| 5. [Forms and input handling](05_Forms_and_Input_Handling/README.md) | [Forms and controllers](05_Forms_and_Input_Handling/flutter_forms/README.md), [Input validation and submission](05_Forms_and_Input_Handling/input_validation/README.md) |
| 6. [Advanced state management](06_Advanced_State_Management/README.md) | [GetX controllers and reactive state](06_Advanced_State_Management/getx_example/README.md) |
| 7. [Local storage](07_Local_Storage/README.md) | [SQLite user table and CRUD](07_Local_Storage/sqlite_database/README.md), [SQLite notes and file location](07_Local_Storage/notes_app/README.md) |
| 8. [Networking and APIs](08_Networking_and_APIs/README.md) | [HTTP quotes and GetX](08_Networking_and_APIs/quote_app/README.md), [JSON model exercise](08_Networking_and_APIs/json_parsing/README.md), [HTTP Todo CRUD with setState](08_Networking_and_APIs/todo_crud_api/README.md) |
| 9. [Firebase integration](09_Firebase_Integration/README.md) | [Firebase initialization](09_Firebase_Integration/firebase_setup/README.md), [Firestore CRUD and snapshot listeners](09_Firebase_Integration/cloud_firestore/README.md) |

## Running the examples

"https://github.com/jigar1104"

Open an individual example folder containing `pubspec.yaml`. Use Flutter 3.44.5 and Dart 3.12.2, the versions used for this collection.

```powershell
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
```

Use an Android or iOS device for the SQLite examples. Use `flutter devices` to find its ID and pass it to `flutter run -d`. The Firebase examples require a registered app and local settings. Their READMEs show the exact setup. For [Dart basics](01_Introduction_to_Flutter/dart_basics/README.md), run `dart pub get` and `dart run bin/main.dart` instead.

## Technologies and status

Material widgets, Flutter navigation, forms, Dart models, and `setState` are implemented with the SDK. GetX provides reactive state. SQLite examples use `sqflite`, with `path_provider` in the notes app. Networking uses `http` and DummyJSON. Firebase examples use `firebase_core` and `cloud_firestore`.

The numbered folders contain existing local examples and independently written additions aligned with the public syllabus. Instructor file provenance and the enrolled resources remain unverified. `course_all_codes` is the pre-existing Flutter starter and is outside the mapped collection.

- [Project index](course_documentation/PROJECT_INDEX.md)
- [Lecture mapping](course_documentation/LECTURE_CODE_MAPPING.md)
- [Environment report](course_documentation/ENVIRONMENT_REPORT.md)
- [Test report](course_documentation/TEST_REPORT.md)
- [Completion report](course_documentation/COURSE_COMPLETION_REPORT.md)
