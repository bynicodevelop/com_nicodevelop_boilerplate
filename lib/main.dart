import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:cloud_functions/cloud_functions.dart";
import "package:com_nicodevelop_dotmessenger/bootstrap.dart";
import "package:com_nicodevelop_dotmessenger/screens/authentication/code_screen.dart";
import "package:com_nicodevelop_dotmessenger/screens/authentication/signin_screen.dart";
import "package:com_nicodevelop_dotmessenger/services/service_factory.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:json_theme/json_theme.dart";
import "package:firebase_core/firebase_core.dart";
import "firebase_options.dart";

import "package:flutter/services.dart";
import "dart:convert";

Future<ThemeData?> _loadThemeFromAsset(String assetPath) async {
  final themeStr = await rootBundle.loadString(assetPath);

  final themeJson = jsonDecode(themeStr);

  return ThemeDecoder.decodeThemeData(themeJson)!;
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );

  final ThemeData? theme = await _loadThemeFromAsset("assets/theme.json");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    final String host = Platform.isAndroid ? "10.0.2.2" : "localhost";

    await FirebaseAuth.instance.useAuthEmulator(
      host,
      9099,
    );

    FirebaseFirestore.instance.useFirestoreEmulator(
      host,
      8080,
    );

    FirebaseStorage.instance.useStorageEmulator(
      host,
      9199,
    );

    FirebaseFunctions.instance.useFunctionsEmulator(
      host,
      5001,
    );
  }

  await FirebaseFirestore.instance.terminate();
  await FirebaseFirestore.instance.clearPersistence();

  runApp(App(
    theme: theme,
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
    firebaseFunctions: FirebaseFunctions.instance,
  ));
}

class App extends StatelessWidget {
  final ThemeData? theme;

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseFunctions firebaseFunctions;

  const App({
    super.key,
    required this.theme,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.firebaseFunctions,
  });

  @override
  Widget build(BuildContext context) {
    return ServiceFactory(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      firebaseStorage: firebaseStorage,
      firebaseFunctions: firebaseFunctions,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Dot Messenger",
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("en", ""),
          Locale("fr", ""),
        ],
        home: Bootstrap(
          child: CodeScreen(),
        ),
      ),
    );
  }
}
