import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';
import 'package:scryfall_api_symbols/models/mtg_symbology.dart';

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
  final List<InlineSpan> children = [];
  int lastIndex = 0;
  for (final match in matches) {
    children.add(
      TextSpan(text: oracleText.substring(lastIndex, match.start)),
    );
    final matchedSymbol = match.group(0);
    final MtgSymbol? mtgSymbol = mtgSymbology[matchedSymbol];
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
extension MtgCardSymbology on MtgCard {
  TextSpan? preparedOracleText() => _preparedOracleText(oracleText);
}

/// Grants the [preparedOracleText] method to [CardFace] instances.
extension CardFaceSymbology on CardFace {
  TextSpan? preparedOracleText() => _preparedOracleText(oracleText);
}
