## 2.0.1 - December 30, 2025

* Use [very_good_analysis](https://pub.dev/packages/very_good_analysis) for the analysis options rather than defining custom rules
    * Address all lints raised from these new rules
* Update [license](https://pub.dev/packages/scryfall_api_symbols/license) copyright
* Make minimum supported [flutter_svg](https://pub.dev/packages/flutter_svg) version 2.2.3
* Make minimum supported SDK version Flutter 3.32/Dart 3.8 - in line with [flutter_svg](https://github.com/flutter/packages/blob/30dd810481e42642b8910503f4f45a4f81b5f31d/third_party/packages/flutter_svg/pubspec.yaml#L8-L9)
* Upgrade [test](https://pub.dev/packages/test) dev dependency version
* Update some of the android and ios files in the [example](https://github.com/zmuranaka/scryfall_api_symbols/tree/main/example)

## 2.0.0

* This package now depends on [mtg_symbology](https://pub.dev/packages/mtg_symbology)
    * **Breaking** - The SVG asset paths are `'packages/mtg_symbology/assets/ASSET_NAME.svg'` now instead of `'packages/scryfall_api_symbols/assets/ASSET_NAME.svg'`
    * This package re-exports [mtg_symbology](https://pub.dev/packages/mtg_symbology), so there should not be other breaking changes
* Bumps minimum flutter_svg version to `2.1.0`
* **Breaking** - Makes minimum Flutter version 3.27.0 - in line with [flutter_svg](https://github.com/flutter/packages/blob/c19f8399160d70cbcd874ec503aedc48aa9ce828/third_party/packages/flutter_svg/pubspec.yaml#L9)
* Adds tests for the extension methods

## 1.0.2

* Rename the incorrectly named `lib/magic_the_gathering_flutter.dart` to `lib/scryfall_api_symbols.dart` and add exports to it.
    * Despite being a rename to the main library file, this _should not_ be a breaking change for anyone since the file was not previously exporting any other files. Previously, nobody should have had reason to be importing `lib/magic_the_gathering_flutter.dart` directly.
* Update `README.md` to tell the user to import the library file directly now that it exports the other files.
* Update `README.md` with documentation for `mtgSymbology` and `MtgSymbol`.
* Update the example project to import the library file directly and bump the example's version to 1.0.1

## 1.0.1

* Add tests for `MtgSymbol` equality

## 1.0.0

Initial stable release.
