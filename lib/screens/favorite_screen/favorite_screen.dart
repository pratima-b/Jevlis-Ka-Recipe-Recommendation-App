import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app/models/food_type.dart';
import 'package:app/models/recipe.dart';
import 'package:app/screens/home_screen/widgets/list_items.dart';
import 'dart:convert';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Jevlis Ka?",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: ValueListenableBuilder<Box>(
            valueListenable: Hive.box('Favorite').listenable(),
            builder: (context, box, child) {
              if (box.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        CupertinoIcons.heart_fill,
                        size: 105,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          "You don't have any Favorite recipe yet.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                  itemBuilder: (context, i) {
                    final raw = box.getAt(i);

                    print("FAVORITE DATA: $raw");
                    print("FAVORITE TYPE: ${raw.runtimeType}");

                    if (raw is String) {
                      final data = Recipe.fromJson(
                        Map<String, dynamic>.from(jsonDecode(raw)),
                      );

                      print("FAVORITE TITLE: ${data.title}");
                      print("FAVORITE ID: ${data.id}");
                      print("FAVORITE IMAGE: ${data.image}");
                      print("SHOWING FAVORITE: ${data.title}");

                      return ListItem(
                        meal: FoodType(
                          id: data.id.toString(),
                          image: data.image!,
                          name: data.title!,
                          readyInMinutes: data.readyInMinutes.toString(),
                          servings: data.servings.toString(),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                  itemCount: box.length);
            }),
      ),
    );
  }
}
