import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<({double latitude, double longitude})?>
      getUserCoordinates() async {
    // Check if location services are enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log("❌ Location services are disabled.");
      return null;
    }

    // Check permission using permission_handler
    final status = await Permission.location.status;

    if (status.isDenied) {
      final result = await Permission.location.request();
      if (!result.isGranted) {
        log("❌ Location permission denied.");
        return null;
      }
    }

    if (status.isPermanentlyDenied) {
      log("❌ Location permission permanently denied.");
      // Open app settings for the user to enable manually
      await openAppSettings();
      return null;
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      log("📍 Got position: lat=${position.latitude}, long=${position.longitude}");
      return (latitude: position.latitude, longitude: position.longitude);
    } catch (e) {
      log("❌ Failed to get position: $e");
      return null;
    }
  }
}
