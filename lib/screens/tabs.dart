import 'package:final_meals/data/dummy_data.dart';
import 'package:final_meals/screens/categories.dart';
import 'package:final_meals/screens/filters.dart';
import 'package:final_meals/screens/meals.dart';
import 'package:final_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:final_meals/models/meal.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favoriteMeals = [];
  Map<Filters, bool> _selectedFilters = kInitialFilters;

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

  void selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      var result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersScreen()),
      );
      setState(() {
         _selectedFilters = result ?? kInitialFilters;
        
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filters.glutenFree]! && !(meal.isGlutenFree)) {
        return false;
      }
      if (_selectedFilters[Filters.lactoseFree]! && !(meal.isLactoseFree)) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarian]! && !(meal.isVegetarian)) {
        return false;
      }
      if (_selectedFilters[Filters.vegan]! && !(meal.isVegan)) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      totallyFilteredMeals: availableMeals,
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
