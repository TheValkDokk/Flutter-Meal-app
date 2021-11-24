// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/settings_screen.dart';
import 'package:meals_app/screens/tab_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _settings = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _listofMeal = DUMMY_MEALS;

  void _setSettings(Map<String, bool> settingsData) {
    setState(() {
      _settings = settingsData;

      _listofMeal = DUMMY_MEALS.where((e) {
        if (_settings['gluten'] && !e.isGlutenFree) {
          return false;
        }
        if (_settings['lactose'] && !e.isLactoseFree) {
          return false;
        }
        if (_settings['vegan'] && !e.isVegan) {
          return false;
        }
        if (_settings['vegetarian'] && !e.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: const TextStyle(
              fontSize: 24,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => MyHomePage(),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_listofMeal),
        MealDetail.routeName: (ctx) => MealDetail(),
        SettingsScreen.routeName: (ctx) =>
            SettingsScreen(_settings, _setSettings),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return TabScreenState();
  }
}
