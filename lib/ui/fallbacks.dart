import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GenericAvatar extends StatelessWidget {
  final String url;
  final double radius;

  const GenericAvatar({super.key, required this.url, this.radius = 24.0});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade300,
      backgroundImage: url.isNotEmpty ? CachedNetworkImageProvider(url) : null,
      child: url.isEmpty ? Icon(Icons.person, size: radius) : null,
    );
  }
}

class GenericSocietyLogo extends StatelessWidget {
  final String url;
  final double size;

  const GenericSocietyLogo({super.key, required this.url, this.size = 50.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: url.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.business),
              ),
            )
          : const Icon(Icons.business, color: Colors.blueGrey),
    );
  }
}
