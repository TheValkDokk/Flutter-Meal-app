// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  final Function saveSettings;
  final Map<String, bool> settings;

  SettingsScreen(this.settings, this.saveSettings);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.settings['gluten'];
    _vegetarian = widget.settings['vegetarian'];
    _vegan = widget.settings['vegan'];
    _lactoseFree = widget.settings['lactose'];
    super.initState();
  }

  Widget _buildSwitchList(
      String title, String des, bool currenValue, Function update) {
    return SwitchListTile(
      title: Text(title),
      value: currenValue,
      subtitle: Text(des),
      onChanged: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedSettings = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveSettings(selectedSettings);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchList(
                'Gluten-free',
                'Only include gluten-free meals',
                _glutenFree,
                (val) {
                  setState(() {
                    _glutenFree = val;
                  });
                },
              ),
              _buildSwitchList(
                'Vegan-free',
                'Only include Vegan-free meals',
                _vegan,
                (val) {
                  setState(() {
                    _vegan = val;
                  });
                },
              ),
              _buildSwitchList(
                'Vegetarian',
                'Only include Vegetarianmeals',
                _vegetarian,
                (val) {
                  setState(() {
                    _vegetarian = val;
                  });
                },
              ),
              _buildSwitchList(
                'Lactose-free',
                'Only include Lactose-free meals',
                _lactoseFree,
                (val) {
                  setState(() {
                    _lactoseFree = val;
                  });
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
