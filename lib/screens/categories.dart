import 'package:final_meals/data/dummy_data.dart';
import 'package:final_meals/screens/meals.dart';
import 'package:final_meals/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:final_meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category1 in availableCategories)
            CategoryGridItem(
              category: category1,
              onSelectCategory: () {
                selectCategory(context,category1 );
              },
            ),
        ],
      ),
    );
  }
}
