abstract class TextUtils {
  TextUtils._();

  /// Turkish-aware search normalization.
  ///
  /// Normalizes both query and stored data so that:
  ///   "ilaç" == "İlaç" == "ILAÇ" == "ılaç"
  ///
  /// Special Turkish case rules applied before standard toLowerCase:
  ///   İ (U+0130) → i  (standard toLowerCase gives "i̇", two chars — wrong)
  ///   ı (U+0131) → i  (dotless i treated same as dotted i for search recall)
  static String normalize(String text) => text
      .replaceAll('İ', 'i')
      .replaceAll('ı', 'i')
      .toLowerCase();
}
