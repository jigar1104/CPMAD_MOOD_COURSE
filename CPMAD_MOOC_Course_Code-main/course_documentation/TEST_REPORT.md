# Test report

Verification used Flutter 3.44.5 and Dart 3.12.2 on Windows on 23 November 2026. Package resolution and formatting completed for all 22 examples. Final analyzer runs reported zero issues across all 21 Flutter apps and the Dart package. The Flutter suites passed 24 tests. The Dart package's runner executed all four topic scripts.

| Project | Pub get | Format | Analysis | Automated check |
| --- | --- | --- | --- | --- |
| [dart_basics](../01_Introduction_to_Flutter/dart_basics/README.md) | Pass | Pass | Clean | Runner passed · All four Dart topic scripts |
| [hello_world_app](../01_Introduction_to_Flutter/hello_world_app/README.md) | Pass | Pass | Clean | 1 passed · Widget render smoke test |
| [text_widget](../02_Basic_Widgets_and_Layouts/text_widget/README.md) | Pass | Pass | Clean | 1 passed · Widget render smoke test |
| [button_widget](../02_Basic_Widgets_and_Layouts/button_widget/README.md) | Pass | Pass | Clean | 1 passed · Widget render smoke test |
| [image_widget](../02_Basic_Widgets_and_Layouts/image_widget/README.md) | Pass | Pass | Clean | 1 passed · Widget render smoke test |
| [row_column_layout](../02_Basic_Widgets_and_Layouts/row_column_layout/README.md) | Pass | Pass | Clean | 1 passed · Widget render smoke test |
| [container_widget](../02_Basic_Widgets_and_Layouts/container_widget/README.md) | Pass | Pass | Clean | 1 passed · Widget render smoke test |
| [stateful_stateless](../03_State_Management/stateful_stateless/README.md) | Pass | Pass | Clean | 1 passed · Widget render smoke test |
| [setstate_example](../03_State_Management/setstate_example/README.md) | Pass | Pass | Clean | 1 passed · Counter increment and readable foreground after a color change |
| [basic_navigation](../04_Navigation_and_Routing/basic_navigation/README.md) | Pass | Pass | Clean | 1 passed · Push registration, pop, and replace login |
| [passing_data](../04_Navigation_and_Routing/passing_data/README.md) | Pass | Pass | Clean | 1 passed · Blank input feedback and trimmed username on the dashboard |
| [named_routes](../04_Navigation_and_Routing/named_routes/README.md) | Pass | Pass | Clean | 1 passed · Named arguments and back-stack behavior |
| [flutter_forms](../05_Forms_and_Input_Handling/flutter_forms/README.md) | Pass | Pass | Clean | 1 passed · Widget render smoke test |
| [input_validation](../05_Forms_and_Input_Handling/input_validation/README.md) | Pass | Pass | Clean | 1 passed · Invalid submission shows feedback |
| [getx_example](../06_Advanced_State_Management/getx_example/README.md) | Pass | Pass | Clean | 1 passed · Reactive counter changes after a tap |
| [sqlite_database](../07_Local_Storage/sqlite_database/README.md) | Pass | Pass | Clean | 1 passed · SQLite create, reopen, read, update and delete |
| [notes_app](../07_Local_Storage/notes_app/README.md) | Pass | Pass | Clean | 1 passed · SQLite create, reopen, read, update and delete |
| [quote_app](../08_Networking_and_APIs/quote_app/README.md) | Pass | Pass | Clean | 2 passed · HTTP GET and decoding plus failure handling |
| [json_parsing](../08_Networking_and_APIs/json_parsing/README.md) | Pass | Pass | Clean | 1 passed · Widget render smoke test |
| [todo_crud_api](../08_Networking_and_APIs/todo_crud_api/README.md) | Pass | Pass | Clean | 2 passed · HTTP CRUD methods, paths and payloads plus failure handling |
| [firebase_setup](../09_Firebase_Integration/firebase_setup/README.md) | Pass | Pass | Clean | 1 passed · Missing settings are displayed without an unhandled exception |
| [cloud_firestore](../09_Firebase_Integration/cloud_firestore/README.md) | Pass | Pass | Clean | 2 passed · Startup error state and document model serialization |

## Integration checks

- Both SQLite suites performed real file-backed database operations through SQLite FFI on Windows. They confirmed data survived closing and reopening the database. The Android and iOS plugin paths were not exercised on a device.
- Independent HTTPS requests to DummyJSON returned HTTP 200 for GET `/quotes/random` and GET `/todos?limit=8`, HTTP 201 for POST `/todos/add`, and HTTP 200 for PUT and DELETE on `/todos/1`. The response JSON had the expected fields. The Flutter HTTP tests used a mock client to verify request construction and decoding. [DummyJSON Todo API](https://dummyjson.com/docs/todos)
- Firebase live initialization and Firestore reads and writes were not tested. They require registered app settings and a development Firestore database. The app READMEs document the setup.
- No Android emulator, Android physical device, or iOS device was available. Android command-line tools and license status prevented a clean Android toolchain check. Browser verification is recorded below.

The existing starter in `course_all_codes` separately resolved dependencies, passed its formatting check and analysis, and passed its stock counter test. Its files and results are outside the curriculum totals.

## Browser checks

- Headless Chrome smoke launches connected to Flutter’s debug service and exited successfully for `hello_world_app`, `named_routes`, `getx_example`, `quote_app`, `todo_crud_api`, `firebase_setup`, and `cloud_firestore`. These checks exercised startup. Widget interactions were verified by the Flutter VM suites.
- Release web builds succeeded for `quote_app`, `todo_crud_api`, and `cloud_firestore`. Flutter emitted a Cupertino icon font notice during these builds. The examples use Material icons, which were packaged.
- A separate Chrome-mode widget test stalled while loading the Hello World test harness and was canceled. The Flutter VM suite and the direct Chrome smoke launch both passed.
