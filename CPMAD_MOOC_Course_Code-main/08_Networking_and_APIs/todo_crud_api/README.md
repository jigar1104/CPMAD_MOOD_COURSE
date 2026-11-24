# Todo REST API

This example uses a Dart model, an HTTP API class, and a Flutter screen with `setState`. Loading sends GET, adding sends POST, and changing or deleting an existing API todo sends PUT or DELETE. Failed requests leave the current list in place and show the error.

DummyJSON simulates writes. POST items receive unique session IDs so they can be edited and deleted in the UI without addressing another server resource. Reload fetches the original server list.

Run `flutter pub get`, then `flutter run -d chrome`. [DummyJSON Todos](https://dummyjson.com/docs/todos)
