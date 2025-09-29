import 'package:final_meals/screens/categories.dart';
import 'package:final_meals/screens/filters.dart';
import 'package:final_meals/screens/meals.dart';
import 'package:final_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:final_meals/models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favoriteMeals = [];

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    setState(() {
      var isExisting = _favoriteMeals.contains(meal);

      if (isExisting) {
        _favoriteMeals.remove(meal);
        showInfoMessage('Meal is no longer a favorite');
      } else {
        _favoriteMeals.add(meal);
        showInfoMessage('Meal is marked as favorite');
      }
    });
  }

  int selectedPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void selectScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activeScreenTitle = 'Categories';

    if (selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite1: _toggleMealFavoriteStatus,
      );
      activeScreenTitle = "Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(title: Text(activeScreenTitle)),
      drawer: MainDrawer(onSelectScreen: selectScreen),

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
