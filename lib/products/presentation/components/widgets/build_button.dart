import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  const BuildButton({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
