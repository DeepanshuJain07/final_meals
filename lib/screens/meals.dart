import 'package:final_meals/screens/meal_details_screen.dart';
import 'package:final_meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:final_meals/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite1,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite1;

  void selectMeal(BuildContext context, Meal meal1) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealDetailsScreen(meal: meal1, onToggleFavorite: onToggleFavorite1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        children: [
          Text(
            'Uh Oh....nothing here',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Try Selecting A Different Category',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals
            .length, // iski vajah se hi hume melas Text screen pe dikhga otherwise nahi dikhega.
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),

      body: content,
    );
  }
}
