# Quote app

The app fetches a random quote from DummyJSON over HTTP, decodes it into a Dart model, and updates the screen using a GetX controller and `Obx`. The refresh button requests another quote. Failed requests display an error and a retry action.

Run `flutter pub get`, then `flutter run -d chrome`. [DummyJSON Quotes](https://dummyjson.com/docs/quotes)
