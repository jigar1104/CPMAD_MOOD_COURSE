# Firebase setup

Select **Initialize Firebase** to see the result of the SDK call. The app reports a setup error when the options are missing.

Use the settings for an app you registered in Firebase. For Chrome, select the web app registration. For Android or iOS, register the app ID in the platform launcher and use that registration's settings.

Create an ignored `firebase.env.json` file in this example's root. Fill it with values from **Project settings → Your apps**.

```json
{
  "FIREBASE_API_KEY": "",
  "FIREBASE_APP_ID": "",
  "FIREBASE_MESSAGING_SENDER_ID": "",
  "FIREBASE_PROJECT_ID": ""
}
```

```powershell
flutter pub get
flutter run -d chrome --dart-define-from-file=firebase.env.json
```

The app passes those values to `Firebase.initializeApp`. You can also use FlutterFire CLI to register and inspect apps, but this example reads settings from the file above.

[Official Firebase setup guide](https://firebase.google.com/docs/flutter/setup)
