import 'package:final_meals/providers/favorites_provider.dart';
import 'package:final_meals/providers/meals_provider.dart';
import 'package:final_meals/screens/categories.dart';
import 'package:final_meals/screens/filters.dart';
import 'package:final_meals/screens/meals.dart';
import 'package:final_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  Map<Filters, bool> _selectedFilters = kInitialFilters;

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
        MaterialPageRoute(builder: (ctx) => FiltersScreen( currentFilters:_selectedFilters )),
      );
      setState(() {
         _selectedFilters = result ?? kInitialFilters;
        
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals =ref.watch(mealsProvider);
   
    final availableMeals =meals.where((meal) {
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
      
    );
    var activeScreenTitle = 'Categories';

    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        meals:favoriteMeals,
       
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
