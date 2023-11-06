import 'dart:typed_data';

import 'package:flutter/material.dart';

class ContactAvatar extends StatelessWidget {
  const ContactAvatar({
    super.key,
    required this.photo,
     this.radius = 18,
  });

  final Uint8List? photo;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return photo != null
        ? CircleAvatar(
            backgroundImage: MemoryImage(photo!),
            radius: radius!,
          )
        :  CircleAvatar(
            radius: radius!,
            child: const Icon(Icons.person),
          );
  }
}
