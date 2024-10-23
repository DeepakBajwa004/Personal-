import 'package:flutter/material.dart';
import 'package:my_personal_project/utils/images/image_strings.dart';

class InfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String photoUrl;

  const InfoCard({
    super.key,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Colors.blue,       // First color of the gradient
                  Colors.green,      // Second color of the gradient
                  Colors.lightBlue,  // Third color of the gradient
                ],
                stops: [0.0, 0.5, 1.0], // Control the gradient stops
              ),
              border: Border.all(
                color: Colors.transparent, // Set border color to transparent
                width: 4,                  // Border width
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade300,
              child: ClipOval(
                child: _buildProfileImage(photoUrl),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded( // Ensure the column takes only available space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  maxLines: 1, // Limit to one line to avoid wrapping
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  maxLines: 1, // Limit to one line
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildProfileImage(String photoUrl) {
    return photoUrl.isNotEmpty
        ? Image.network(
      photoUrl,
      fit: BoxFit.cover,
      width: 60,
      height: 60,
      errorBuilder: (context, error, stackTrace) {
        // If the network image fails, show the default avatar
        return Image.asset(
          defaultDp,
          fit: BoxFit.cover,
          width: 60,
          height: 60,
        );
      },
    )
        : Image.asset(
      defaultDp,
      fit: BoxFit.cover,
      width: 60,
      height: 60,
    );
  }
}
