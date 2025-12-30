import 'package:flutter/material.dart';
import 'package:mtg_symbology/mtg_symbology.dart';
import 'package:scryfall_api/scryfall_api.dart';

/// Returns a visual representation of the [oracleText] using SVGs for valid
/// MTG symbols.
/// Returns `null` if [oracleText] is `null`.
TextSpan? _preparedOracleText(String? oracleText) {
  if (oracleText == null) {
    return null;
  }
  final matches = MtgSymbol.regex.allMatches(oracleText);
  if (matches.isEmpty) {
    return TextSpan(text: oracleText);
  }
  final children = <InlineSpan>[];
  var lastIndex = 0;
  for (final match in matches) {
    children.add(
      TextSpan(text: oracleText.substring(lastIndex, match.start)),
    );
    final matchedSymbol = match.group(0);
    final mtgSymbol = mtgSymbology[matchedSymbol];
    if (mtgSymbol == null) {
      throw ArgumentError.value(
        matchedSymbol,
        'matchedSymbol',
        'Unexpected MTG symbol',
      );
    }
    children.add(WidgetSpan(child: mtgSymbol.toSvg()));
    lastIndex = match.end;
  }
  children.add(TextSpan(text: oracleText.substring(lastIndex)));
  return TextSpan(children: children);
}

/// Grants the [preparedOracleText] method to [MtgCard] instances.
extension MtgCardPreparedOracleText on MtgCard {
  /// Returns a visual representation of the [oracleText] using SVGs wrapped in
  /// a [WidgetSpan] for valid MTG symbols.
  /// Returns `null` if [oracleText] is `null`. If it doesn't contain any valid
  /// MTG symbols, will return a [TextSpan] with the original [oracleText].
  TextSpan? preparedOracleText() => _preparedOracleText(oracleText);
}

/// Grants the [preparedOracleText] method to [CardFace] instances.
extension CardFacePreparedOracleText on CardFace {
  /// Returns a visual representation of the [oracleText] using SVGs wrapped in
  /// a [WidgetSpan] for valid MTG symbols.
  /// Returns `null` if [oracleText] is `null`. If it doesn't contain any valid
  /// MTG symbols, will return a [TextSpan] with the original [oracleText].
  TextSpan? preparedOracleText() => _preparedOracleText(oracleText);
}
