import 'dart:developer';
import 'package:cine_bot/l10n/app_localizations.dart';
import 'package:cine_bot/screens/chat_screen.dart';
import 'package:cine_bot/screens/movie_screen.dart';
import 'package:cine_bot/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  try {
    await dotenv.load();
  } on Exception catch (e) {
    log(e.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('es'),
      title: 'CineBot',
      debugShowCheckedModeBanner: false,
      theme: theme,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('es')],
      initialRoute: ChatScreen.route,
      routes: {
        ChatScreen.route: (context) => ChatScreen(),
        MovieScreen.route: (context) => MovieScreen(),
      },
    );
  }
}
