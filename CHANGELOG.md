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
