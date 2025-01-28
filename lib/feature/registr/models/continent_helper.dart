import 'package:dunkingclub/feature/registr/repositories/countries.dart';

class ContinentHelper {
  static List<MapEntry<String, String>> getCountriesForContinent(
      String continent) {
    switch (continent) {
      case "AF":
        return countryMapAF.entries.toList();
      case "AS":
        return countryMapAS.entries.toList();
      case "EU":
        return countryMapEU.entries.toList();
      case "NA":
        return countryMapNA.entries.toList();
      case "OC":
        return countryMapOC.entries.toList();
      case "SA":
        return countryMapSA.entries.toList();
      default:
        return [];
    }
  }

  static int getMaxCityCodeLengthForContinent(
      String continent, String? country) {
    if (country == null) return 1; // Default value for no country selected
    switch (continent) {
      case "AF":
        return countryMaxCityCodeLengthAF[country] ?? 4;
      case "AS":
        return countryMaxCityCodeLengthAS[country] ?? 6;
      case "EU":
        return countryMaxCityCodeLengthEU[country] ?? 5;
      case "NA":
        return countryMaxCityCodeLengthNA[country] ?? 5;
      case "OC":
        return countryMaxCityCodeLengthOC[country] ?? 4;
      case "SA":
        return countryMaxCityCodeLengthSA[country] ?? 4;
      default:
        return 1; // Default if no matching continent or country
    }
  }
}
