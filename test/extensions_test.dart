import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';
import 'package:scryfall_api_symbols/scryfall_api_symbols.dart';
import 'package:test/test.dart';

void main() {
  final id = '1ebf9dea-b4f8-4955-9824-7da5bbba91e9';
  final langStr = 'en';
  final oracleId = '7d6c4290-d46d-4b98-805c-3f537462c4c8';
  final printsSearchUriStr = '';
  final rulingsUriStr = '';
  final scryfallUriStr = '';
  final uriStr = '';
  final cmc = 4;
  final colorIdentityStr = ['W'];
  final keywords = [];
  final layoutStr = 'normal';
  final legalities = {
    'standard': 'not_legal',
    'future': 'not_legal',
    'historic': 'not_legal',
    'timeless': 'not_legal',
    'gladiator': 'not_legal',
    'pioneer': 'not_legal',
    'explorer': 'not_legal',
    'modern': 'not_legal',
    'legacy': 'legal',
    'pauper': 'not_legal',
    'vintage': 'legal',
    'penny': 'not_legal',
    'commander': 'legal',
    'oathbreaker': 'legal',
    'standardbrawl': 'not_legal',
    'brawl': 'not_legal',
    'alchemy': 'not_legal',
    'paupercommander': 'not_legal',
    'duel': 'legal',
    'oldschool': 'not_legal',
    'premodern': 'not_legal',
    'predh': 'legal'
  };
  final name = 'Huang Zhong, Shu General';
  final oversized = false;
  final reserved = false;
  final typeLine = 'Legendary Creature — Human Soldier';
  final booster = false;
  final borderColorStr = 'black';
  final cardBackId = '0aeebaf5-8c7d-4636-9e82-8c27447861f7';
  final collectorNumber = '65801';
  final digital = true;
  final foil = true;
  final nonfoil = true;
  final finishesStr = ['nonfoil', 'foil'];
  final frameStr = '2015';
  final fullArt = false;
  final gamesStr = ['mtgo'];
  final highresImage = false;
  final imageStatusStr = 'lowres';
  final prices = {
    'usd': null,
    'usd_foil': null,
    'usd_etched': null,
    'eur': null,
    'eur_foil': null,
    'tix': '1.10'
  };
  final promo = false;
  final purchaseUris = {'tcgplayer': '', 'cardmarket': '', 'cardhoarder': ''};
  final rarityStr = 'rare';
  final relatedUris = {
    'tcgplayer_infinite_articles': '',
    'tcgplayer_infinite_decks': '',
    'edhrec': 'https://edhrec.com/route/?cc=Huang+Zhong%2C+Shu+General',
    'mtgtop8': ''
  };
  final releasedAtStr = '2016-11-16';
  final reprint = true;
  final scryfallSetUriStr = 'https://scryfall.com/sets/pz2?utm_source=api';
  final setName = 'Treasure Chest';
  final setSearchUriStr = '';
  final setTypeStr = 'treasure_chest';
  final setUriStr = '';
  final set = 'pz2';
  final setId = '2661b143-8eac-4c73-9d93-549fe928bd96';
  final storySpotlight = false;
  final textless = false;
  final variation = false;
  final manaCost = '{2}{W}{W}';
  final oracleText = 'This card costs {2}{W}{W}';

  final json = <String, dynamic>{
    'object': 'card',
    'id': id,
    'oracle_id': oracleId,
    'name': name,
    'lang': langStr,
    'released_at': releasedAtStr,
    'uri': uriStr,
    'scryfall_uri': scryfallUriStr,
    'layout': layoutStr,
    'highres_image': highresImage,
    'image_status': imageStatusStr,
    'mana_cost': manaCost,
    'cmc': cmc,
    'type_line': typeLine,
    'oracle_text': oracleText,
    'color_identity': colorIdentityStr,
    'keywords': keywords,
    'legalities': legalities,
    'games': gamesStr,
    'reserved': reserved,
    'foil': foil,
    'nonfoil': nonfoil,
    'finishes': finishesStr,
    'oversized': oversized,
    'promo': promo,
    'reprint': reprint,
    'variation': variation,
    'set_id': setId,
    'set': set,
    'set_name': setName,
    'set_type': setTypeStr,
    'set_uri': setUriStr,
    'set_search_uri': setSearchUriStr,
    'scryfall_set_uri': scryfallSetUriStr,
    'rulings_uri': rulingsUriStr,
    'prints_search_uri': printsSearchUriStr,
    'collector_number': collectorNumber,
    'digital': digital,
    'rarity': rarityStr,
    'card_back_id': cardBackId,
    'border_color': borderColorStr,
    'frame': frameStr,
    'full_art': fullArt,
    'textless': textless,
    'booster': booster,
    'story_spotlight': storySpotlight,
    'prices': prices,
    'related_uris': relatedUris,
    'purchase_uris': purchaseUris,
    'flavor_name': name,
    'printed_name': name,
    'printed_text': oracleText,
    'printed_type_line': typeLine,
  };

  group('MtgCard', () {
    final mtgCard = MtgCard.fromJson(json);

    test('MtgCardPreparedManaCost', () {
      final preparedManaCost = mtgCard.preparedManaCost();
      expect(preparedManaCost, isNotNull);
      expect(preparedManaCost, isA<List<Widget>>());
      expect(preparedManaCost!.length, equals(3));
    });

    test('MtgCardPreparedOracleText', () {
      final preparedOracleText = mtgCard.preparedOracleText();
      expect(preparedOracleText, isNotNull);
      expect(preparedOracleText, isA<TextSpan>());
      expect(preparedOracleText!.children!.length, greaterThan(0));
    });
  });

  group('CardFace', () {
    final cardFace = CardFace.fromJson(json);

    test('CardFacePreparedManaCost', () {
      final preparedManaCost = cardFace.preparedManaCost();
      expect(preparedManaCost, isNotNull);
      expect(preparedManaCost, isA<List<Widget>>());
      expect(preparedManaCost!.length, equals(3));
    });

    test('MtgCardPreparedOracleText', () {
      final preparedOracleText = cardFace.preparedOracleText();
      expect(preparedOracleText, isNotNull);
      expect(preparedOracleText, isA<TextSpan>());
      expect(preparedOracleText!.children!.length, greaterThan(0));
    });
  });
}
