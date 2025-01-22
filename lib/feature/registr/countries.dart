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

Map<String, String> continentMap = {
  "AF": "Africa",
  "AS": "Asia",
  "EU": "Europe",
  "NA": "North America",
  "OC": "Oceania",
  "SA": "South America"
};

// "Africa",
Map<String, String> countryMapAF = {
  "DZ": "Algeria",
  "NG": "Nigeria",
  "ZA": "South Africa",
  "KE": "Kenya",
  "EG": "Egypt",
  "GH": "Ghana",
  "MA": "Morocco",
  "ET": "Ethiopia",
  "UG": "Uganda",
  "ZM": "Zambia"
};
Map<String, int> countryMaxCityCodeLengthAF = {
  "DZ": 4, // Algeria
  "NG": 4, // Nigeria
  "ZA": 5, // South Africa
  "KE": 4, // Kenya
  "EG": 5, // Egypt
  "GH": 4, // Ghana
  "MA": 4, // Morocco
  "ET": 4, // Ethiopia
  "UG": 4, // Uganda
  "ZM": 4 // Zambia
};
//"Asia",
Map<String, String> countryMapAS = {
  "IN": "India",
  "CN": "China",
  "JP": "Japan",
  "KR": "South Korea",
  "ID": "Indonesia",
  "PH": "Philippines",
  "SG": "Singapore",
  "AE": "Arab Emirates",
  "TH": "Thailand",
  "VN": "Vietnam"
};
Map<String, int> countryMaxCityCodeLengthAS = {
  "IN": 6, // India
  "CN": 6, // China
  "JP": 5, // Japan
  "KR": 5, // South Korea
  "ID": 4, // Indonesia
  "PH": 4, // Philippines
  "SG": 3, // Singapore
  "AE": 4, // United Arab Emirates (UAE)
  "TH": 4, // Thailand
  "VN": 4 // Vietnam
};
// "Europe"
Map<String, String> countryMapEU = {
  "AL": "Albania",
  "AT": "Austria",
  "BE": "Belgium",
  "BG": "Bulgaria",
  "HR": "Croatia",
  "CY": "Cyprus",
  "CZ": "Czech Republic",
  "DK": "Denmark",
  "EE": "Estonia",
  "FI": "Finland",
  "FR": "France",
  "DE": "Germany",
  "GR": "Greece",
  "IT": "Italy",
  "NL": "Netherlands",
  "PL": "Poland",
  "PT": "Portugal",
  "RO": "Romania",
  "RU": "Russia",
  "ES": "Spain"
};
Map<String, int> countryMaxCityCodeLengthEU = {
  "AL": 3, // Albania
  "AT": 4, // Austria
  "BE": 3, // Belgium
  "BG": 3, // Bulgaria
  "HR": 3, // Croatia
  "CY": 3, // Cyprus
  "CZ": 3, // Czech Republic
  "DK": 1, // Denmark
  "EE": 3, // Estonia
  "FI": 3, // Finland
  "FR": 3, // France
  "DE": 5, // Germany
  "GR": 3, // Greece
  "IT": 3, // Italy
  "NL": 3, // Netherlands
  "PL": 4, // Poland
  "PT": 3, // Portugal
  "RO": 3, // Romania
  "RU": 4, // Russia
  "ES": 3 // Spain
};

// "North America"
Map<String, String> countryMapNA = {
  "BS": "Bahamas",
  "BB": "Barbados",
  "BZ": "Belize",
  "BM": "Bermuda",
  "CA": "Canada",
  "CR": "Costa Rica",
  "CU": "Cuba",
  "DM": "Dominica",
  "DO": "Dominican Repub.",
  "SV": "El Salvador",
  "GD": "Grenada",
  "GT": "Guatemala",
  "HT": "Haiti",
  "HN": "Honduras",
  "JM": "Jamaica",
  "MX": "Mexico",
  "NI": "Nicaragua",
  "PA": "Panama",
  "LC": "Saint Lucia",
  "US": "United States",
  "GL": "Greenland",
};
Map<String, int> countryMaxCityCodeLengthNA = {
  "BS": 4, // Bahamas
  "BB": 4, // Barbados
  "BZ": 4, // Belize
  "BM": 4, // Bermuda
  "CA": 5, // Canada
  "CR": 4, // Costa Rica
  "CU": 4, // Cuba
  "DM": 4, // Dominica
  "DO": 5, // Dominican Republic
  "SV": 4, // El Salvador
  "GD": 4, // Grenada
  "GT": 4, // Guatemala
  "HT": 4, // Haiti
  "HN": 4, // Honduras
  "JM": 4, // Jamaica
  "MX": 5, // Mexico
  "NI": 4, // Nicaragua
  "PA": 4, // Panama
  "LC": 4, // Saint Lucia
  "US": 5, // United States
  "GL": 4, // Greenland
};
//"Oceania"
Map<String, String> countryMapOC = {
  "AU": "Australia",
  "FJ": "Fiji",
  "KI": "Kiribati",
  "MH": "Marshall Islands",
  "FM": "Micronesia",
  "NR": "Nauru",
  "NZ": "New Zealand",
  "PW": "Palau",
  "PG": "Papua New Guinea",
  "WS": "Samoa",
  "SB": "Solomon Islands",
  "TO": "Tonga",
  "TV": "Tuvalu",
  "VU": "Vanuatu"
};
Map<String, int> countryMaxCityCodeLengthOC = {
  "AU": 4, // Australia
  "FJ": 4, // Fiji
  "KI": 4, // Kiribati
  "MH": 4, // Marshall Islands
  "FM": 4, // Micronesia
  "NR": 3, // Nauru
  "NZ": 5, // New Zealand
  "PW": 4, // Palau
  "PG": 4, // Papua New Guinea
  "WS": 4, // Samoa
  "SB": 4, // Solomon Islands
  "TO": 4, // Tonga
  "TV": 4, // Tuvalu
  "VU": 4 // Vanuatu
};
//"South America"
Map<String, String> countryMapSA = {
  "AR": "Argentina",
  "BO": "Bolivia",
  "BR": "Brazil",
  "CL": "Chile",
  "CO": "Colombia",
  "EC": "Ecuador",
  "GY": "Guyana",
  "PY": "Paraguay",
  "PE": "Peru",
  "SR": "Suriname",
  "UY": "Uruguay",
  "VE": "Venezuela"
};
Map<String, int> countryMaxCityCodeLengthSA = {
  "AR": 4, // Argentina
  "BO": 4, // Bolivia
  "BR": 5, // Brazil
  "CL": 4, // Chile
  "CO": 4, // Colombia
  "EC": 4, // Ecuador
  "GY": 4, // Guyana
  "PY": 4, // Paraguay
  "PE": 4, // Peru
  "SR": 4, // Suriname
  "UY": 4, // Uruguay
  "VE": 4 // Venezuela
};
