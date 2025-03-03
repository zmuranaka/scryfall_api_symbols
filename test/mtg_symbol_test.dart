import 'package:scryfall_api_symbols/models/mtg_symbology.dart';
import 'package:test/test.dart';

void main() {
  group(
    'MtgSymbol equality tests',
    () {
      final String image = 'packages/magic_the_gathering_flutter/assets/T.svg';
      final String? looseVariant = null;
      final String english = 'tap this permanent';
      final double manaValue = 0.0;
      test('MtgSymbol is equal to itself', () {
        final tapSymbol = MtgSymbol(
          image: image,
          looseVariant: looseVariant,
          english: english,
          manaValue: manaValue,
        );
        expect(tapSymbol, equals(tapSymbol));
        expect(mtgSymbology['{A}'], equals(mtgSymbology['{A}']));
      });
      test('MtgSymbols with same properties are equal', () {
        final tapSymbol1 = MtgSymbol(
          image: image,
          looseVariant: looseVariant,
          english: english,
          manaValue: manaValue,
        );
        final tapSymbol2 = MtgSymbol(
          image: image,
          looseVariant: looseVariant,
          english: english,
          manaValue: manaValue,
        );
        expect(tapSymbol1, equals(tapSymbol2));
      });
      test('MtgSymbols with different properties are not equal', () {
        final tapSymbol1 = MtgSymbol(
          image: image,
          looseVariant: looseVariant,
          english: english,
          manaValue: manaValue,
        );
        final tapSymbol2 = MtgSymbol(
          image: 'different text $image',
          looseVariant: looseVariant,
          english: english,
          manaValue: manaValue,
        );
        final tapSymbol3 = MtgSymbol(
          image: image,
          looseVariant: 'different text',
          english: english,
          manaValue: manaValue,
        );
        final tapSymbol4 = MtgSymbol(
          image: image,
          looseVariant: looseVariant,
          english: 'different text $english',
          manaValue: manaValue,
        );
        final tapSymbol5 = MtgSymbol(
          image: image,
          looseVariant: looseVariant,
          english: english,
          manaValue: manaValue + 1.0,
        );
        expect(tapSymbol1, isNot(equals(tapSymbol2)));
        expect(tapSymbol1, isNot(equals(tapSymbol3)));
        expect(tapSymbol1, isNot(equals(tapSymbol4)));
        expect(tapSymbol1, isNot(equals(tapSymbol5)));
      });
    },
  );
}
