import 'package:flutter/material.dart';
import 'package:flutter_river_project/layout/default_layout.dart';
import 'package:flutter_river_project/screen/auto_dispose_modifier_screen.dart';
import 'package:flutter_river_project/screen/family_modifier_provider_screen.dart';
import 'package:flutter_river_project/screen/future_provider_screen.dart';
import 'package:flutter_river_project/screen/state_notifier_provider_screen.dart';
import 'package:flutter_river_project/screen/state_provider_screen.dart';
import 'package:flutter_river_project/screen/stram_provider.screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "HomeScreen",
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => StateProviderScreen())
                );
              },
              child: Text('StateProviderScreen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => StateNotifierProviderScreen())
                );
              },
              child: Text('StateNotifierProviderScreen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => FutureProviderScreen())
                );
              },
              child: Text('FutureProviderScreen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => StreamProviderScreen())
                );
              },
              child: Text('StreamProviderScreen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => FamilyModifierScreen())
                );
              },
              child: Text('FamilyModifierScreen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => AutoDisposeModifierScreen())
                );
              },
              child: Text('AutoDisposeModifierScreen'),
            ),
          ],
        ));
  }
}
