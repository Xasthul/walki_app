abstract class AppRegExp {
  ///     [\w-.]+ - Matches one or more characters. This represents the local part of the email address before the "@" symbol.
  ///     @ - Matches the "@" symbol.
  ///     ([\w-]+\.)+ - Matches one or more occurrences of one or more characters. This represents the domain name part of the email address, which consists of one or more subdomains separated by periods.
  ///     [\w-]{2,4} - Matches between 2 and 4 characters. This represents the top-level domain (TLD), such as .com, .net, or .org.
  static final emailValidationRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// (?=.*[a-zA-Z]) positive lookahead to ensure that the string contains at least one letter.
  /// (?=.*\d) positive lookahead to ensure that the string contains at least one number.
  /// (?=.*[!@#$%^&*()_=]) positive lookahead to ensure that the string contains at least one special character.
  /// (?!.*[\r\n]) negative lookahead to ensure that the string does not contain any new lines (\r or \n).
  /// (?=.{8,30}$) positive lookahead to ensure that the string has a length between 8 and 30 characters.
  /// [a-zA-Z\d!@#$%^&*()_=]+ matches any combination of letters, digits, or the allowed special characters.
  static final passwordValidationRegExp =
      RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!?@#$%^&*()_=])(?!.*[\r\n])(?=.{8,30}$)[a-zA-Z\d!?@#$%^&*()_=]+$');
}
