import 'package:flutter/material.dart';
import 'package:fluttert_expense_tracker/Widgets/Expense.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.green);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
    seedColor: Colors.red);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData().copyWith(
        scaffoldBackgroundColor: kDarkColorScheme.background,
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
              backgroundColor: kDarkColorScheme.onPrimaryContainer,
              foregroundColor: kDarkColorScheme.primaryContainer
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primary,
                  textStyle: TextStyle(color: Colors.white,fontSize: 12),
                  elevation: 10
              )
          ),
        cardTheme: CardTheme().copyWith(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          color: kDarkColorScheme.onBackground
        ),
          textTheme: ThemeData().textTheme.copyWith(
            titleMedium:  TextStyle(
              fontWeight: FontWeight.w500,
              color: kColorScheme.onBackground,
              fontSize: 18,
            ),
            titleSmall:  TextStyle(
              fontWeight: FontWeight.w400,
              color: kColorScheme.onBackground,
              fontSize: 12,
            ),

          )
      ),
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: kColorScheme.background,
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.onBackground,
            textStyle: TextStyle(color: Colors.white,fontSize: 12),
            elevation: 10
          )
        ),
          cardTheme: CardTheme().copyWith(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              color: kColorScheme.onBackground
          ),
        textTheme: ThemeData().textTheme.copyWith(
          titleMedium:  TextStyle(
            fontWeight: FontWeight.w500,
            color: kColorScheme.primaryContainer,
            fontSize: 18,
          ),
          titleSmall:  TextStyle(
            fontWeight: FontWeight.w400,
            color: kColorScheme.primaryContainer,
            fontSize: 12,
          ),

        )
      ),
      home:  const Expenses(),
    );
  }
}


