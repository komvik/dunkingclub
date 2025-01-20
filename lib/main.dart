import 'package:dunkingclub/countries.dart';

import 'package:dunkingclub/registration_screen.dart';
import 'package:dunkingclub/validation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _cityCodeController = TextEditingController(text: "87600");
  final _passwordController = TextEditingController();

  bool _isFormSubmitted = false;
  bool _obscurePassword = true;
  int _maxLengthCityCode = 1;
  final double _verticalIndent = 5.0;

  String? _selectedCountry;
  String? _selectedContinent = "EU"; // Для континента

  // Инициализация списка стран
  List<MapEntry<String, String>> _availableCountries = [];

  // Обновление списка стран в зависимости от выбранного континента
  void _updateCountriesForContinent(String? continent) {
    switch (continent) {
      case "AF": // Africa
        setState(() {
          _availableCountries = countryMapAF.entries.toList();
          _selectedCountry = null; // Сбрасываем выбранную страну
          _maxLengthCityCode =
              4; // Дефолтное значение для Африки, если страна не выбрана
        });
        break;
      case "AS": // Asia
        setState(() {
          _availableCountries = countryMapAS.entries.toList();
          _selectedCountry = null;
          _maxLengthCityCode =
              6; // Дефолтное значение для Азии, если страна не выбрана
        });
        break;
      case "EU": // Europe
        setState(() {
          _availableCountries = countryMapEU.entries.toList();
          _selectedCountry = "DE";
          _maxLengthCityCode =
              5; // Дефолтное значение для Европы, если страна не выбрана
        });
        break;
      case "NA": // North America
        setState(() {
          _availableCountries = countryMapNA.entries.toList();
          _selectedCountry = null;
          _maxLengthCityCode = 5; // Дефолтное значение для Северной Америки
        });
        break;
      case "OC": // Oceania
        setState(() {
          _availableCountries = countryMapOC.entries.toList();
          _selectedCountry = null;
          _maxLengthCityCode = 5; // Дефолтное значение для Океании
        });
        break;
      case "SA": // South America
        setState(() {
          _availableCountries = countryMapSA.entries.toList();
          _selectedCountry = null;
          _maxLengthCityCode = 4; // Дефолтное значение для Южной Америки
        });
        break;
      default:
        setState(() {
          _availableCountries = [];
          _selectedCountry = null;
          _maxLengthCityCode = 1; // По умолчанию
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    // Инициализируем континент и страну по умолчанию
    _updateCountriesForContinent(_selectedContinent);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double inputHeight = screenHeight * 0.005;

    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double fontSize = isPortrait ? screenWidth * 0.05 : screenWidth * 0.025;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: isPortrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        // Email input field
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: _verticalIndent),
                          child: SizedBox(
                            width: screenWidth,
                            child: TextField(
                              controller: _emailController,
                              style: TextStyle(fontSize: fontSize),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.email),
                                errorText: _isFormSubmitted
                                    ? validateEmail(_emailController.text)
                                    : null,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: inputHeight), // Высота поля
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: _verticalIndent),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Continent
                              SizedBox(
                                width: screenWidth * 0.30,
                                child: DropdownButtonFormField<String>(
                                  value: _selectedContinent,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedContinent = newValue;
                                      _updateCountriesForContinent(newValue);
                                    });
                                  },
                                  items: continentMap.entries
                                      .map((entry) => DropdownMenuItem(
                                            value: entry.key,
                                            child: Text(entry.key),
                                          ))
                                      .toList(),
                                  decoration: InputDecoration(
                                    labelText: 'Continent',
                                    border: const OutlineInputBorder(),
                                    prefixIcon:
                                        const Icon(Icons.public_outlined),
                                    errorText: _isFormSubmitted
                                        ? (_selectedContinent == null
                                            ? 'Continent?'
                                            : null)
                                        : null,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: inputHeight), // Высота поля
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              // Country
                              SizedBox(
                                width: screenWidth * 0.64,
                                child: DropdownButtonFormField<String>(
                                  value: _selectedCountry,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedCountry = newValue;
                                      // Сбрасываем код города при изменении страны
                                      _cityCodeController
                                          .clear(); // Очищаем поле ввода кода города

// Обновляем maxLengthCityCode в зависимости от выбранной страны и континента
                                      if (_selectedContinent == "AF") {
                                        _maxLengthCityCode =
                                            countryMaxCityCodeLengthAF[
                                                    _selectedCountry] ??
                                                4;
                                      } else if (_selectedContinent == "AS") {
                                        _maxLengthCityCode =
                                            countryMaxCityCodeLengthAS[
                                                    _selectedCountry] ??
                                                6;
                                      } else if (_selectedContinent == "EU") {
                                        _maxLengthCityCode =
                                            countryMaxCityCodeLengthEU[
                                                    _selectedCountry] ??
                                                5;
                                      } else if (_selectedContinent == "NA") {
                                        _maxLengthCityCode =
                                            countryMaxCityCodeLengthNA[
                                                    _selectedCountry] ??
                                                5;
                                      } else if (_selectedContinent == "OC") {
                                        _maxLengthCityCode =
                                            countryMaxCityCodeLengthOC[
                                                    _selectedCountry] ??
                                                4;
                                      } else if (_selectedContinent == "SA") {
                                        _maxLengthCityCode =
                                            countryMaxCityCodeLengthSA[
                                                    _selectedCountry] ??
                                                4;
                                      } else {
                                        _maxLengthCityCode = 1; // Default value
                                      }
                                    });
                                  },
                                  items: _availableCountries
                                      .map((country) => DropdownMenuItem(
                                            value: country.key,
                                            child: Text(country.value),
                                          ))
                                      .toList(),
                                  decoration: InputDecoration(
                                    labelText: 'Select Country',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.location_on),
                                    errorText: _isFormSubmitted
                                        ? (_selectedCountry == null
                                            ? 'Please select a country'
                                            : null)
                                        : null,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: inputHeight), // Высота поля
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // City Code input field
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: _verticalIndent),
                              child: SizedBox(
                                width: screenWidth * 0.450,
                                child: TextField(
                                  controller: _cityCodeController,
                                  keyboardType: TextInputType.number,
                                  maxLength:
                                      _maxLengthCityCode, //_______________________ MAX LENGZ
                                  style: TextStyle(fontSize: fontSize),
                                  decoration: InputDecoration(
                                    labelText: 'City Code',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.location_on),
                                    errorText: _isFormSubmitted
                                        ? validateCityCode(
                                            _cityCodeController.text)
                                        : null,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: inputHeight), // Высота поля
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: _verticalIndent),
                              child: SizedBox(
                                width: screenWidth * 0.45,
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: TextStyle(fontSize: fontSize),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: _obscurePassword
                                            ? Colors.grey
                                            : Colors.blue,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                    errorText: _isFormSubmitted
                                        ? validatePassword(
                                            _passwordController.text)
                                        : null,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: inputHeight), // Высота поля
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Password input field

                        const SizedBox(height: 10),
                        // Registration button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isFormSubmitted = true;
                              });

                              // Check if all fields are valid
                              if (validateEmail(_emailController.text) ==
                                      null &&
                                  _selectedCountry != null &&
                                  validateCityCode(_cityCodeController.text) ==
                                      null &&
                                  validatePassword(_passwordController.text) ==
                                      null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen(),
                                  ),
                                );
                              }
                            },
                            child: const Text('Register'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Space between button and logo
                    Container(
                      width: 300,
                      height: 300,
                      color: Colors.blue[50],
                      child: const Center(
                        child: Icon(
                          Icons.account_circle,
                          size: 150,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ) // =========================LANDSKAPE
//=================================================================================
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Секция с иконкой
                    Container(
                      width: 300,
                      height: 300,
                      color: Colors.blue[50],
                      child: const Center(
                        child: Icon(
                          Icons.account_circle,
                          size: 150,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),

                    // Секция с формой
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // __________________________________Email input field
                          Padding(
                            padding: EdgeInsets.only(bottom: _verticalIndent),
                            child: SizedBox(
                              width: double
                                  .infinity, // Используем всю доступную ширину
                              child: TextField(
                                controller: _emailController,
                                style: TextStyle(fontSize: fontSize),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.email),
                                  errorText: _isFormSubmitted
                                      ? validateEmail(_emailController.text)
                                      : null,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: inputHeight), // Высота поля
                                ),
                              ),
                            ),
                          ),
                          // __________________________________Continent and Country selection fields
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: _verticalIndent),
                            child: Row(
                              children: [
                                // Континент
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedContinent,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedContinent = newValue;
                                        _updateCountriesForContinent(
                                            newValue); // Обновляем список стран
                                      });
                                    },
                                    items: continentMap.entries
                                        .map((entry) => DropdownMenuItem(
                                              value: entry.key,
                                              child: Text(entry.key),
                                            ))
                                        .toList(),
                                    decoration: InputDecoration(
                                      labelText: 'Select Continent',
                                      border: const OutlineInputBorder(),
                                      prefixIcon:
                                          const Icon(Icons.public_outlined),
                                      errorText: _isFormSubmitted
                                          ? (_selectedContinent == null
                                              ? 'Please select a continent'
                                              : null)
                                          : null,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: inputHeight), // Высота поля
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                // Страна
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedCountry,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedCountry = newValue;
                                        // Сбрасываем код города при изменении страны
                                        _cityCodeController
                                            .clear(); // Очищаем поле ввода кода города

                                        // Обновляем maxLengthCityCode в зависимости от выбранной страны и континента
                                        if (_selectedContinent == "AF") {
                                          _maxLengthCityCode =
                                              countryMaxCityCodeLengthAF[
                                                      _selectedCountry] ??
                                                  4;
                                        } else if (_selectedContinent == "AS") {
                                          _maxLengthCityCode =
                                              countryMaxCityCodeLengthAS[
                                                      _selectedCountry] ??
                                                  6;
                                        } else if (_selectedContinent == "EU") {
                                          _maxLengthCityCode =
                                              countryMaxCityCodeLengthEU[
                                                      _selectedCountry] ??
                                                  5;
                                        } else if (_selectedContinent == "NA") {
                                          _maxLengthCityCode =
                                              countryMaxCityCodeLengthNA[
                                                      _selectedCountry] ??
                                                  5;
                                        } else if (_selectedContinent == "OC") {
                                          _maxLengthCityCode =
                                              countryMaxCityCodeLengthOC[
                                                      _selectedCountry] ??
                                                  4;
                                        } else if (_selectedContinent == "SA") {
                                          _maxLengthCityCode =
                                              countryMaxCityCodeLengthSA[
                                                      _selectedCountry] ??
                                                  4;
                                        } else {
                                          _maxLengthCityCode =
                                              1; // Default value
                                        }
                                      });
                                    },
                                    items: _availableCountries
                                        .map((country) => DropdownMenuItem(
                                              value: country.key,
                                              child: Text(country.value),
                                            ))
                                        .toList(),
                                    decoration: InputDecoration(
                                      labelText: 'Select Country',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.location_on),
                                      errorText: _isFormSubmitted
                                          ? (_selectedCountry == null
                                              ? 'Please select a country'
                                              : null)
                                          : null,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: inputHeight), // Высота поля
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // __________________________________City Code and Password input fields in one row
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: _verticalIndent),
                            child: Row(
                              children: [
                                // City Code input field
                                Expanded(
                                  child: SizedBox(
                                    child: TextField(
                                      controller: _cityCodeController,
                                      keyboardType: TextInputType.number,
                                      maxLength:
                                          _maxLengthCityCode, // Максимальная длина из изменений
                                      style: TextStyle(fontSize: fontSize),
                                      decoration: InputDecoration(
                                        labelText: 'City Code',
                                        border: const OutlineInputBorder(),
                                        prefixIcon:
                                            const Icon(Icons.location_on),
                                        errorText: _isFormSubmitted
                                            ? validateCityCode(
                                                _cityCodeController.text)
                                            : null,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical:
                                                inputHeight), // Высота поля
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                // Password input field
                                Expanded(
                                  child: SizedBox(
                                    child: TextField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      style: TextStyle(fontSize: fontSize),
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        border: const OutlineInputBorder(),
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: _obscurePassword
                                                ? Colors.grey
                                                : Colors.blue,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                        ),
                                        errorText: _isFormSubmitted
                                            ? validatePassword(
                                                _passwordController.text)
                                            : null,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical:
                                                inputHeight), // Высота поля
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Registration button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isFormSubmitted = true;
                                });

                                if (validateEmail(_emailController.text) ==
                                        null &&
                                    validateCityCode(
                                            _cityCodeController.text) ==
                                        null &&
                                    validatePassword(
                                            _passwordController.text) ==
                                        null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen(),
                                    ),
                                  );
                                }
                              },
                              child: const Text('Register'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
