import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';

class Helpers {
  Helpers._();

  static String getTimeDifference(DateTime startDate) {
    Duration difference = DateTime.now().difference(startDate);
    String timeDifference = '';
    if (difference.inDays > 0) {
      timeDifference = '${difference.inDays}DAYS AGO';
    } else if (difference.inHours > 0) {
      timeDifference = '${difference.inHours}HR AGO';
    } else if (difference.inMinutes > 0) {
      timeDifference = '${difference.inMinutes}MIN AGO';
    } else if (difference.inSeconds > 0) {
      timeDifference = '${difference.inSeconds}SEC AGO';
    }
    return timeDifference;
  }

  static String formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;
    return "${days}d ${hours}h ${minutes}m ${seconds}s";
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static Future<void> launchExternalUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Log.debug("Could not launch $url");
    }
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void copyToClipBoard({required String text}) {
    Clipboard.setData(ClipboardData(text: text));
  }

  static Future<void> launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  static Future<void> launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }
}
