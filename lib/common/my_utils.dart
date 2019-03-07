import 'package:fourybyoffline/common/my_strings.dart';

class MyUtils {

  static String getCopyright() {
    var year = new DateTime.now().year;
    return '\u{00A9} $year ${Strings.appName}';
  }

  static String isEmail(String email) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(email)) {
      return null;
    }

    return Strings.emailInvalid;
  }

  static bool isValid(String answer) {
    return answer != null && answer.isNotEmpty;
  }
}