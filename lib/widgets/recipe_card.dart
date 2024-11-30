import 'dart:io';

import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;

  const RecipeCard(
      {super.key,
      required this.image,
      required this.title,
      required this.author});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: image.startsWith('http') || image.startsWith('https')
                    ? Image.network(image,
                        width: 80, height: 80, fit: BoxFit.cover)
                    : Image.file(File(image),
                        width: 80, height: 80, fit: BoxFit.cover),
              ),
              const SizedBox(width: 10),
              Expanded(
                // Esto hará que el texto ocupe el espacio restante
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1, // Evita que el título se desborde
                      overflow: TextOverflow
                          .ellipsis, // Muestra '...' si el texto es demasiado largo
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16),
                        const SizedBox(width: 5),
                        Text(author),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.favorite, color: Colors.red),
            ],
          )),
    );
  }
}
