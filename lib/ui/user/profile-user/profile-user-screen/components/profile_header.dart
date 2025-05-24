import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String email;
  final double size;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: size,
          backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
              ? NetworkImage(imageUrl!)
              : const AssetImage('assets/images/default_profile.jpg') as ImageProvider,
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 2),
        Text(
          email,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }
}
