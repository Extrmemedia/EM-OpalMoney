import 'package:intl/intl.dart';

String trimHtmlContent(String htmlContent){


  return  Bidi.stripHtmlIfNeeded(htmlContent)
      .trim();
}