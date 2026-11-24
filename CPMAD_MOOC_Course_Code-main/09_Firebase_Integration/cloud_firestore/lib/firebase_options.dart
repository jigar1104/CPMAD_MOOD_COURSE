import 'package:firebase_core/firebase_core.dart';

Future<FirebaseApp> initializeCourseFirebase() {
  const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  const appId = String.fromEnvironment('FIREBASE_APP_ID');
  const senderId = String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');

  if ([apiKey, appId, senderId, projectId].any((value) => value.isEmpty)) {
    throw StateError('Firebase setup required. See this project’s README.');
  }

  return Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: senderId,
      projectId: projectId,
    ),
  );
}
