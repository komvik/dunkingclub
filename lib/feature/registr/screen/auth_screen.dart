import 'package:dunkingclub/config/colors.dart';
import 'package:dunkingclub/feature/registr/countries.dart';
import 'package:dunkingclub/feature/navigat/registration_screen.dart';
import 'package:dunkingclub/feature/registr/widgets/custom_text_field.dart';
import 'package:dunkingclub/feature/registr/widgets/custom_dropdown.dart';
import 'package:dunkingclub/feature/registr/validation.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _cityCodeController = TextEditingController(); //(text: "87600");
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
    setState(() {
      _availableCountries =
          ContinentHelper.getCountriesForContinent(continent ?? "");
      _selectedCountry = null; // Сбрасываем выбранную страну
      _maxLengthCityCode = ContinentHelper.getMaxCityCodeLengthForContinent(
          continent ?? "", _selectedCountry);
    });
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
    double inputHeight = screenHeight * 0.006;

    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double fontSize = isPortrait ? screenWidth * 0.05 : screenWidth * 0.025;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: isPortrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: _verticalIndent),
                          child: SizedBox(
                            width: screenWidth,
                            // ================================================= Email Start
                            child: CustomTextField(
                              controller: _emailController,
                              label: 'Email',
                              icon: Icons.email,
                              errorText: _isFormSubmitted
                                  ? validateEmail(_emailController.text)
                                  : null,
                            ),
                            // ================================================= Email End
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
                                //============================================== Continent Start
                                child: CustomDropdown(
                                  value: _selectedContinent,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedContinent = newValue;
                                      _updateCountriesForContinent(newValue);
                                    });
                                  },
                                  items: continentMap.entries.map((entry) {
                                    return DropdownMenuItem<String>(
                                      value: entry.key,
                                      child: Text(entry.key,
                                          style: const TextStyle(
                                              color: peachSmoothie)),
                                    );
                                  }).toList(),
                                  label: 'Continent',
                                  icon: Icons.public_outlined,
                                  errorText: _isFormSubmitted
                                      ? (_selectedContinent == null
                                          ? 'Continent?'
                                          : null)
                                      : null,
                                ),
                                //============================================== Continent end
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
                                      // Очищаем поле ввода кода города
                                      _cityCodeController.clear();

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
                                            child: Text(
                                              country.value,
                                              style: const TextStyle(
                                                // Цвет текста элементов выпадающего списка
                                                color: peachSmoothie,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  // Цвет фона выпадающего списка
                                  dropdownColor: playerDarkBlue,
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
                            //================================================== CityCode Start
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: _verticalIndent),
                              child: SizedBox(
                                width: screenWidth * 0.450,
                                child: CustomTextField(
                                  controller: _cityCodeController,
                                  label: 'City Code',
                                  icon: Icons.location_on,
                                  maxLength:
                                      _maxLengthCityCode, // Максимальная длина
                                  errorText: _isFormSubmitted
                                      ? validateCityCode(
                                          _cityCodeController.text)
                                      : null,
                                  obscureText:
                                      false, // Городской код не скрываться
                                ),
                              ),
                            ),
                            //================================================== CityCode End
                            const SizedBox(width: 5),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: _verticalIndent),
                              child: SizedBox(
                                width: screenWidth * 0.45,
                                child: TextField(
                                  cursorColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .labelStyle
                                      ?.color,
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle
                                          ?.color),
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
                                            ? Colors.grey // icon unwisible
                                            : Colors.blue, // icon wisible
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

                        const SizedBox(height: 2),
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
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        'assets/images/dunk_dark.png',
                      ),
                    ),
                  ],
                )
//==============================================================================
//
//                                LANDSKAPE
//
//==============================================================================
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Секция с иконкой
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: Center(
                        child: Image.asset(
                          'assets/images/dunk_dark.png',
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
                              //================================================ EmailLandscape
                              child: CustomTextField(
                                controller: _emailController,
                                label: 'Email',
                                icon: Icons.email,
                                errorText: _isFormSubmitted
                                    ? validateEmail(_emailController.text)
                                    : null,
                              ),
                            ),
                          ),
                          // __________Continent and Country selection fields
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: _verticalIndent),
                            child: Row(
                              children: [
                                //============================================== Continent Start
                                Expanded(
                                  child: CustomDropdown(
                                    value: _selectedContinent,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedContinent = newValue;
                                        _updateCountriesForContinent(newValue);
                                      });
                                    },
                                    items: continentMap.entries.map((entry) {
                                      return DropdownMenuItem<String>(
                                        value: entry.key,
                                        child: Text(entry.key,
                                            style: const TextStyle(
                                                color: peachSmoothie)),
                                      );
                                    }).toList(),
                                    label: 'Continent',
                                    icon: Icons.public_outlined,
                                    errorText: _isFormSubmitted
                                        ? (_selectedContinent == null
                                            ? 'Continent?'
                                            : null)
                                        : null,
                                  ),
                                  //============================================== Continent end
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
                                              child: Text(
                                                country.value,
                                                style: const TextStyle(
                                                  // Цвет текста элементов выпадающего списка
                                                  color: peachSmoothie,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    // Цвет фона выпадающего списка
                                    dropdownColor: playerDarkBlue,
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
                                      cursorColor: Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle
                                          ?.color,
                                      controller: _cityCodeController,
                                      keyboardType: TextInputType.number,
                                      maxLength:
                                          _maxLengthCityCode, // Максимальная длина из изменений
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Theme.of(context)
                                              .inputDecorationTheme
                                              .labelStyle
                                              ?.color),
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
                                      cursorColor: Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle
                                          ?.color,
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Theme.of(context)
                                              .inputDecorationTheme
                                              .labelStyle
                                              ?.color),
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
                                                ? Colors.white
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
