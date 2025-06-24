import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<({double latitude, double longitude})?> getUserCoordinates(
      BuildContext context) async {
    // 1. Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      log("❌ Location services are disabled.");

      // Ask user if they want to open location settings
      final shouldOpenSettings = await _showLocationDisabledDialog(context);

      if (shouldOpenSettings) {
        // Open location settings and wait for user to return
        await Geolocator.openLocationSettings();

        // Wait for user to return from settings and check again
        final locationEnabledAfterSettings = await _waitForLocationEnabled();

        if (!locationEnabledAfterSettings) {
          Fluttertoast.showToast(
            msg: "Location is still disabled. Showing all doctors.",
            toastLength: Toast.LENGTH_LONG,
          );
          return null;
        }

        log("✅ Location enabled after settings.");

        // After enabling location services, handle permissions
        return await _handleLocationPermissions(context);
      } else {
        // User chose to ignore location
        Fluttertoast.showToast(
          msg: "Location disabled. You'll get general results.",
        );
        return null;
      }
    }

    // 2. Handle location permissions
    return await _handleLocationPermissions(context);
  }

  static Future<bool> _showLocationDisabledDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Force user to make a choice
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.location_off, color: kPrimaryColor, size: 24),
            SizedBox(width: 8),
            Text("Location is Off"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "To find nearby doctors, please enable location from your device settings.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Without location, you'll see all doctors instead of nearby ones.",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text("Skip", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text("Open Settings"),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  static Future<bool> _waitForLocationEnabled() async {
    // Use AppLifecycleListener to detect when user returns from settings
    bool locationEnabled = false;
    int maxRetries = 30; // Wait up to 30 seconds
    int currentRetry = 0;

    while (currentRetry < maxRetries && !locationEnabled) {
      await Future.delayed(const Duration(milliseconds: 15));
      locationEnabled = await Geolocator.isLocationServiceEnabled();
      currentRetry++;

      if (locationEnabled) {
        log("✅ Location service enabled after $currentRetry seconds");
        break;
      }
    }

    return locationEnabled;
  }

  static Future<({double latitude, double longitude})?>
      _handleLocationPermissions(BuildContext context) async {
    // Always check and request permission using permission_handler
    // This ensures we go through the proper permission flow every time
    PermissionStatus status = await Permission.location.status;
    log("📱 Current location permission status: $status");

    // Handle different permission states
    switch (status) {
      case PermissionStatus.granted:
        log("✅ Location permission already granted, but double-checking...");
        // Even if granted, let's verify by trying to get location
        // If it fails, we'll request permission again
        final location = await _tryGetLocationWithFallback(context);
        return location;

      case PermissionStatus.denied:
        log("⚠️ Location permission denied, requesting...");
        return await _requestLocationPermission(context);

      case PermissionStatus.restricted:
        log("⚠️ Location permission restricted, requesting...");
        return await _requestLocationPermission(context);

      case PermissionStatus.permanentlyDenied:
        log("❌ Location permission permanently denied");
        await _showPermanentlyDeniedDialog(context);
        return null;

      case PermissionStatus.provisional:
        log("⚠️ Location permission provisional, requesting full access...");
        return await _requestLocationPermission(context);

      case PermissionStatus.limited:
        log("⚠️ Location permission limited, requesting full access...");
        return await _requestLocationPermission(context);
    }
  }

  static Future<({double latitude, double longitude})?>
      _requestLocationPermission(BuildContext context) async {
    // Show permission dialog first
    final shouldRequest = await _showPermissionRequestDialog(context);

    if (!shouldRequest) {
      Fluttertoast.showToast(
        msg: "Location permission declined. Showing all doctors.",
        toastLength: Toast.LENGTH_LONG,
      );
      return null;
    }

    // Request permission using permission_handler
    final result =
        await Permission.locationWhenInUse.request(); // or locationAlways
    log("📱 Permission request result: $result");

    switch (result) {
      case PermissionStatus.granted:
        log("✅ Location permission granted after request");
        Fluttertoast.showToast(
          msg: "Location permission granted!",
          backgroundColor: Colors.green,
        );
        return await _getCurrentLocationAfterPermission();

      case PermissionStatus.denied:
        log("❌ Location permission denied by user");
        Fluttertoast.showToast(
          msg: "Location permission denied. Showing all doctors.",
          toastLength: Toast.LENGTH_LONG,
        );
        return null;

      case PermissionStatus.permanentlyDenied:
        log("❌ Location permission permanently denied");
        await _showPermanentlyDeniedDialog(context);
        return null;

      case PermissionStatus.restricted:
        log("❌ Location permission restricted");
        Fluttertoast.showToast(
          msg: "Location access is restricted. Showing all doctors.",
          toastLength: Toast.LENGTH_LONG,
        );
        return null;

      case PermissionStatus.provisional:
      case PermissionStatus.limited:
        log("⚠️ Location permission limited, but proceeding");
        return await _getCurrentLocationAfterPermission();
    }
  }

  static Future<bool> _showPermissionRequestDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        log("📍 Showing location permission dialog");
        log("Location permission dialog required");
        return AlertDialog(
          iconPadding: EdgeInsets.all(0),
          title: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 24,
              ),
              SizedBox(width: 8),
              Expanded(
                // Wrap long title in Expanded to avoid overflow
                child: Text(
                  "Location Permission Required",
                  style: Styles.textStyle12.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          content: Text(
            "To find nearby doctors, please enable location access in your settings.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text("Skip", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text("Settings"),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await openAppSettings();
    }

    return result ?? false;
  }

  static Future<void> _showPermanentlyDeniedDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text("Permission Denied"),
          ],
        ),
        content: Text(
          "Location permission is permanently denied. Please enable it in your app settings to use location features.",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Skip", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await openAppSettings();
            },
            child: Text("Settings"),
          ),
        ],
      ),
    );
  }

  static Future<({double latitude, double longitude})?>
      _tryGetLocationWithFallback(BuildContext context) async {
    try {
      log("📍 Attempting to get location with existing permissions...");

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 5), // Shorter timeout for this check
      );

      log("✅ Got position with existing permissions: lat=${position.latitude}, long=${position.longitude}");

      Fluttertoast.showToast(
        msg: "Location found! Showing nearby doctors.",
        backgroundColor: Colors.green,
      );

      return (latitude: position.latitude, longitude: position.longitude);
    } catch (e) {
      log("⚠️ Failed to get location with existing permissions: $e");
      log("🔄 Requesting fresh permission...");

      // If we can't get location even with "granted" permission,
      // request permission again to show the system dialog
      return await _requestLocationPermission(context);
    }
  }

  static Future<({double latitude, double longitude})?>
      _getCurrentLocationAfterPermission() async {
    try {
      log("📍 Getting current position after permission granted...");

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      );

      log("✅ Got position after permission: lat=${position.latitude}, long=${position.longitude}");

      Fluttertoast.showToast(
        msg: "Location found! Showing nearby doctors.",
        backgroundColor: Colors.green,
      );

      return (latitude: position.latitude, longitude: position.longitude);
    } catch (e) {
      log("❌ Failed to get position after permission: $e");
      Fluttertoast.showToast(
        msg: "Couldn't get your location. Showing all doctors.",
        toastLength: Toast.LENGTH_LONG,
      );
      return null;
    }
  }

  static Future<bool> hasLocationPermission() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }

  // Helper method to check if location services are enabled
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Helper method to get detailed permission status
  static Future<String> getLocationPermissionStatus() async {
    final status = await Permission.location.status;
    switch (status) {
      case PermissionStatus.granted:
        return "Granted";
      case PermissionStatus.denied:
        return "Denied";
      case PermissionStatus.restricted:
        return "Restricted";
      case PermissionStatus.permanentlyDenied:
        return "Permanently Denied";
      case PermissionStatus.provisional:
        return "Provisional";
      case PermissionStatus.limited:
        return "Limited";
    }
  }

  // Method to request specific permission types (for advanced use)
  static Future<bool> requestLocationWhenInUse() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  static Future<bool> requestLocationAlways() async {
    final status = await Permission.locationAlways.request();
    return status.isGranted;
  }
}
