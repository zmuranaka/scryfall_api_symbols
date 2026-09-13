import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart' show MtgCard, ScryfallApiClient;
import 'package:scryfall_api_symbols/scryfall_api_symbols.dart';

void main() {
  runApp(const MyApp());
}

/// A simple example app for demonstrating the scryfall_api_symbols package.
class MyApp extends StatelessWidget {
  /// Construct a [MyApp], optionally passing [key].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scryfall API Symbols Example App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2b253a)),
      ),
      home: const MyHomePage(),
    );
  }
}

/// The home page for [MyApp].
class MyHomePage extends StatefulWidget {
  /// Construct a [MyHomePage], optionally passing [key].
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _cards = <MtgCard>[];
  final _apiClient = ScryfallApiClient();

  @override
  void initState() {
    super.initState();
    unawaited(_loadMagicCards());
  }

  @override
  void dispose() {
    _apiClient.close();
    super.dispose();
  }

  Future<void> _loadMagicCards() async {
    final cards = await Future.wait([
      _apiClient.getCardByName('Draco'),
      _apiClient.getCardByName('Cromat'),
      _apiClient.getCardByName('Crackleburr'),
      _apiClient.getCardByName('Boulder Jockey'),
      _apiClient.getCardByName('Ascendant Spirit'),
      _apiClient.getCardByName('Experiment Five'),
      _apiClient.getCardByName("Mons's Goblin Waiters"),
      _apiClient.getCardByName('Rush of Inspiration'),
      _apiClient.getCardByName('Drowner of Truth'),
      _apiClient.getCardByName('Esika, God of the Tree'),
    ]);
    _cards.addAll(cards);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Scryfall API Symbols Example App'),
      ),
      body: SafeArea(
        child: Center(
          child: _cards.isEmpty
              ? const CircularProgressIndicator()
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _cards.length,
                  itemBuilder: (context, index) {
                    final card = _cards[index];
                    return card.cardFaces?.isNotEmpty ?? false
                        ? DoubleFacedMtgCardTile(card: card)
                        : MtgCardTile(card: card);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(thickness: 2);
                  },
                ),
        ),
      ),
    );
  }
}

/// Shows info about a single-faced [MtgCard].
class MtgCardTile extends StatelessWidget {
  /// Construct a [MtgCardTile], requiring [card] and optionally passing [key].
  const MtgCardTile({required this.card, super.key});

  /// The [MtgCard] that this [MtgCardTile] shows info for.
  final MtgCard card;

  @override
  Widget build(BuildContext context) {
    final cardImage = card.imageUris?.artCrop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(card.name),
            const Spacer(),
            ...?card.preparedManaCost(),
          ],
        ),
        const SizedBox(height: 8),
        if (cardImage != null) Image.network(cardImage.toString()),
        const SizedBox(height: 8),
        Text(card.typeLine),
        Text.rich(card.preparedOracleText() ?? TextSpan(text: card.oracleText)),
      ],
    );
  }
}

/// Shows info about a double-faced [MtgCard].
class DoubleFacedMtgCardTile extends StatefulWidget {
  /// Construct a [DoubleFacedMtgCardTile], requiring [card] and optionally
  /// passing [key].
  DoubleFacedMtgCardTile({required this.card, super.key})
    : assert(
        card.cardFaces?.isNotEmpty ?? false,
        'A double faced card must have non-empty faces',
      );

  /// The [MtgCard] that this [DoubleFacedMtgCardTile] shows info for.
  final MtgCard card;

  @override
  State<DoubleFacedMtgCardTile> createState() => _DoubleFacedMtgCardTileState();
}

class _DoubleFacedMtgCardTileState extends State<DoubleFacedMtgCardTile> {
  int _faceIndex = 0;

  @override
  Widget build(BuildContext context) {
    final activeFace = widget.card.cardFaces![_faceIndex];
    final activeFaceImage = activeFace.imageUris?.artCrop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(activeFace.name),
            const Spacer(),
            ...?activeFace.preparedManaCost(),
          ],
        ),
        const SizedBox(height: 8),
        if (activeFaceImage != null) Image.network(activeFaceImage.toString()),
        const SizedBox(height: 8),
        if (activeFace.typeLine != null) Text(activeFace.typeLine!),
        Text.rich(
          activeFace.preparedOracleText() ??
              TextSpan(text: activeFace.oracleText),
        ),
        Center(
          child: TextButton(
            onPressed: _flipCard,
            child: const Text('Flip Card'),
          ),
        ),
      ],
    );
  }

  void _flipCard() => setState(() => _faceIndex = _faceIndex == 0 ? 1 : 0);
}
