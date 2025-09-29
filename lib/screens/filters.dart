import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Favorites'),),
      body: Column(
        children: [
          SwitchListTile(
            value: _glutenFreeFilterState,
            onChanged: (isChecked) {
              setState(() {
                _glutenFreeFilterState= isChecked;
              });
            },
            title: Text(
              'Gluten-Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,

                
              ),
            ),
            subtitle: Text(
              'Only gluten-free meals available',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            contentPadding: EdgeInsets.only(left: 34, right: 22),
            activeThumbColor: Theme.of(context).colorScheme.onTertiary,
          ),
        ],
      ),
    );
  }
}
