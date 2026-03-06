import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PermissionService {
  Future<bool> requestLocationPermission(BuildContext context) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      if (!context.mounted) return false;

      final shouldRequest = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Permission'),
          content: const Text(
            'We need your location to find nearby places and point you in '
            'the right direction. Your location is never stored or shared.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Not now'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Allow'),
            ),
          ],
        ),
      );

      if (shouldRequest != true) return false;

      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      if (!context.mounted) return false;

      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Location permission has been permanently denied. '
            'Please enable it in your device settings.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Geolocator.openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );

      return false;
    }

    return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
  }
}
