import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app/models/recipe.dart';
import 'dart:convert';

class FavoriteButton extends StatelessWidget {
  final Recipe info;

  const FavoriteButton({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('Favorite').listenable(),
      builder: (context, box, child) {
        final isFavorite =
            info.id != null && box.containsKey(info.id);

        return FloatingActionButton(
          heroTag: 'favorite_${info.id}',
          backgroundColor: isFavorite
              ? Theme.of(context).primaryColor
              : Colors.grey,
          onPressed: info.id == null
              ? null
              : () async {
            if (isFavorite) {
              await box.delete(info.id);
            } else {
              await box.put(
                  info.id,
                  jsonEncode(info.toJson())
              );
            }
          },
          child: Icon(
            isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
          ),
        );
      },
    );
  }
}