import 'package:final_meals/screens/categories.dart';
import 'package:final_meals/screens/meals.dart';
import 'package:flutter/material.dart';
import 'package:final_meals/models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favoriteMeals = [];

  void _toggleMealFavoriteStatus(Meal meal) {
    var isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }
  }

  int selectedPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activeScreenTitle = 'Categories';

    if (selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals:_favoriteMeals,
        onToggleFavorite1: _toggleMealFavoriteStatus,
      );
      activeScreenTitle = "Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(title: Text(activeScreenTitle)),

      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
