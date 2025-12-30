import 'package:flutter/material.dart';
import 'package:mtg_symbology/mtg_symbology.dart';
import 'package:scryfall_api/scryfall_api.dart';

/// Returns a visual representation of the [manaCost] using SVGs for valid
/// MTG symbols.
/// Returns `null` if [manaCost] is `null` or it doesn't contain any valid MTG
/// symbols.
///
/// Padding can be added to each symbol by passing a non-null [padding].
List<Widget>? _preparedManaCost(String? manaCost, {EdgeInsets? padding}) {
  if (manaCost == null) {
    return null;
  }
  final matches = MtgSymbol.regex.allMatches(manaCost);
  if (matches.isEmpty) {
    return null;
  }
  final manaCostSymbols = <Widget>[];
  for (final match in matches) {
    final matchedSymbol = match.group(0);
    final mtgSymbol = mtgSymbology[matchedSymbol];
    if (mtgSymbol == null) {
      throw ArgumentError.value(
        matchedSymbol,
        'matchedSymbol',
        'Unexpected MTG symbol',
      );
    }
    final svg = mtgSymbol.toSvg();
    manaCostSymbols.add(
      padding == null ? svg : Padding(padding: padding, child: svg),
    );
  }
  return manaCostSymbols;
}

/// Grants the [preparedManaCost] method to [MtgCard] instances.
extension MtgCardPreparedManaCost on MtgCard {
  /// Returns a visual representation of the [manaCost] using SVGs for valid
  /// MTG symbols.
  /// Returns `null` if [manaCost] is `null` or it doesn't contain any valid MTG
  /// symbols.
  ///
  /// Pass `null` to [padding] to avoid using any padding - otherwise the
  /// padding will default 1.5 on each horizontal side.
  List<Widget>? preparedManaCost({
    EdgeInsets? padding = const EdgeInsets.symmetric(horizontal: 1.5),
  }) {
    return _preparedManaCost(manaCost, padding: padding);
  }
}

/// Grants the [preparedManaCost] method to [CardFace] instances.
extension CardFacePreparedManaCost on CardFace {
  /// Returns a visual representation of the [manaCost] using SVGs for valid
  /// MTG symbols.
  /// Returns `null` if [manaCost] is `null` or it doesn't contain any valid MTG
  /// symbols.
  ///
  /// Pass `null` to [padding] to avoid using any padding - otherwise the
  /// padding will default 1.5 on each horizontal side.
  List<Widget>? preparedManaCost({
    EdgeInsets? padding = const EdgeInsets.symmetric(horizontal: 1.5),
  }) {
    return _preparedManaCost(manaCost, padding: padding);
  }
}
