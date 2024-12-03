import 'dart:io';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;

  const RecipeCard({
    Key? key,
    required this.image,
    required this.title,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Builder(
              builder: (context) {
                try {
                  if (image.startsWith('http') || image.startsWith('https')) {
                    return Image.network(
                      image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/Error Wallpaper.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  } else {
                    return Image.file(
                      File(image),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/Error Wallpaper.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }
                } catch (e) {
                  return Image.asset(
                    'assets/images/Error Wallpaper.jpg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  author,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}