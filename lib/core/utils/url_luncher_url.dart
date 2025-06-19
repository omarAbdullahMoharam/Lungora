import 'package:url_launcher/url_launcher.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';

class UrlLauncher {
  // الاتصال
  static void launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      SnackBarHandler.showError('Could not launch phone dialer.');
    }
  }

  static void launchEmail(String email) async {
    final String subject = Uri.encodeComponent('Inquiry from Lungora App');
    final String body = Uri.encodeComponent(
      'Dear Doctor,\n\nI hope this message finds you well.\n\n',
    );

    final Uri emailUri = Uri.parse('mailto:$email?subject=$subject&body=$body');

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      SnackBarHandler.showError(
        'Could not launch email client. Please check your device settings.',
      );
    }
  }

  // whatsApp
  static void launchWhatsApp(String phoneNumber) async {
    Uri whatsappUri;
    if (phoneNumber.startsWith('+20')) {
      whatsappUri = Uri.parse("https://wa.me/$phoneNumber");
    } else {
      whatsappUri = Uri.parse("https://wa.me/+20$phoneNumber");
    }
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      SnackBarHandler.showError('Could not launch WhatsApp.');
    }
  }

  static void launchGoogleMaps(double latitude, double longitude) async {
    final Uri mapsUri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    } else {
      SnackBarHandler.showError(
        'Could not open Google Maps. Please check your device settings.',
      );
    }
  }

//   open Google Maps from a link
  static void launchGoogleMapsFromLink(String link) async {
    final Uri mapUri = Uri.parse(link);
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri);
    } else {
      SnackBarHandler.showError(
        'Could not open Google Maps link. Please check the URL or device settings.',
      );
    }
  }
}
