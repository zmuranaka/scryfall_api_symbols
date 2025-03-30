import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart' show MtgCard, ScryfallApiClient;
import 'package:scryfall_api_symbols/scryfall_api_symbols.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scryfall API Symbols Example App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff2b253a)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
    _loadMagicCards();
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
      _apiClient.getCardByName('Mons\'s Goblin Waiters'),
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
        title: Text('Scryfall API Symbols Example App'),
      ),
      body: SafeArea(
        child: Center(
          child: _cards.isEmpty
              ? const CircularProgressIndicator()
              : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: _cards.length,
                  itemBuilder: (context, index) {
                    final card = _cards[index];
                    return card.cardFaces?.isNotEmpty == true
                        ? DoubleFacedMtgCardTile(card: card)
                        : MtgCardTile(card: card);
                  },
                  separatorBuilder: (context, index) => Divider(thickness: 2.0),
                ),
        ),
      ),
    );
  }
}

class MtgCardTile extends StatelessWidget {
  const MtgCardTile({super.key, required this.card});

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
        const SizedBox(height: 8.0),
        if (cardImage != null) Image.network(cardImage.toString()),
        const SizedBox(height: 8.0),
        Text(card.typeLine),
        Text.rich(card.preparedOracleText() ?? TextSpan(text: card.oracleText)),
      ],
    );
  }
}

class DoubleFacedMtgCardTile extends StatefulWidget {
  DoubleFacedMtgCardTile({super.key, required this.card})
      : assert(card.cardFaces?.isNotEmpty == true);

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
        const SizedBox(height: 8.0),
        if (activeFaceImage != null) Image.network(activeFaceImage.toString()),
        const SizedBox(height: 8.0),
        if (activeFace.typeLine != null) Text(activeFace.typeLine!),
        Text.rich(activeFace.preparedOracleText() ??
            TextSpan(text: activeFace.oracleText)),
        Center(
          child: TextButton(
            onPressed: _flipCard,
            child: Text('Flip Card'),
          ),
        ),
      ],
    );
  }

  void _flipCard() => setState(() => _faceIndex = _faceIndex == 0 ? 1 : 0);
}
