import 'package:com_nicodevelop_dotmessenger/components/list_messages/bloc/get_list_message_bloc.dart';
import 'package:com_nicodevelop_dotmessenger/repositories/messages_repository.dart';
import 'package:com_nicodevelop_dotmessenger/screens/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_theme/json_theme.dart';

import 'package:flutter/services.dart';
import 'dart:convert';

Future<ThemeData?> _loadThemeFromAsset(String assetPath) async {
  final themeStr = await rootBundle.loadString(assetPath);

  final themeJson = jsonDecode(themeStr);

  return ThemeDecoder.decodeThemeData(themeJson)!;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ThemeData? theme = await _loadThemeFromAsset('assets/theme.json');

  runApp(App(
    theme: theme,
  ));
}

class App extends StatelessWidget {
  final ThemeData? theme;

  const App({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetListMessageBloc>(
          lazy: false,
          create: (context) => GetListMessageBloc(
            messageRepository: MessagesRepository(),
          )..add(OnGetListMessageEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dot Messenger',
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('fr', ''),
        ],
        home: MessagesScreen(),
      ),
    );
  }
}
