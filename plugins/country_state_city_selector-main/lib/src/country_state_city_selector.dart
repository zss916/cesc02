import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class CountryStateCitySelector extends StatefulWidget {
  const CountryStateCitySelector({
    super.key,

    required this.onSelectionChanged,
    this.onTimeZoneChanged,

    // Optional callbacks
    this.onCountryChanged,
    this.onStateChanged,
    this.onCityChanged,

    this.enableLabels = true,
    this.hideCity = true,
    this.hideStates = true,
    this.hideSearch = true,
    this.localCode,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.fillColor = Colors.transparent,
    this.hintColor,

    // Label customization
    this.labelColor = Colors.black,
    this.labelFontSize = 14,
    this.labelFontWeight = FontWeight.normal,

    // Hint text / localization
    this.countryHintText = "Select Country",
    this.stateHintText = "Select State/Province",
    this.cityHintText = "Select City",
    this.timeZoneHintText = "",

    // Selected box text customization
    this.selectedTextColor = Colors.black,
    this.selectedTextFontSize = 16,
    this.selectedTextFontWeight = FontWeight.normal,

    // Picker list item customization
    this.pickerItemTextColor = Colors.black,
    this.pickerItemFontSize = 16,
    this.pickerItemFontWeight = FontWeight.normal,

    // Modal background
    this.modalBackgroundColor = const Color.fromRGBO(255, 255, 255, 0.95),

    // Modal title customization
    this.modalTitleColor = Colors.black,
    this.modalTitleFontSize = 18,
    this.modalTitleFontWeight = FontWeight.bold,

    // For Initialization
    this.initialCountry,
    this.initialState,
    this.initialCity,

    // default country
    this.defaultCountry,

    // vertical Padding
    this.verticalPadding = 12,

    // TextField Hint Text
    this.countryTextFieldHintText,
    this.stateTextFieldHintText,
    this.cityTextFieldHintText,
    this.timeZoneTextFieldHintText,
  });

  // Optional selection callback
  final void Function(String country, String state, String city)
  onSelectionChanged;

  final void Function(String timeZone)? onTimeZoneChanged;

  // Optional individual callbacks
  final void Function(String country)? onCountryChanged;
  final void Function(String state)? onStateChanged;
  final void Function(String city)? onCityChanged;

  final bool enableLabels;
  final bool hideCity;
  final bool hideStates;
  final bool hideSearch;
  final String? localCode;

  // Customization
  final Color borderColor;
  final double borderWidth;
  final Color fillColor;

  // Label customization
  final Color labelColor;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final Color? hintColor;

  // Hint text / localization
  final String countryHintText;
  final String stateHintText;
  final String cityHintText;
  final String timeZoneHintText;

  // Selected text customization
  final Color selectedTextColor;
  final double selectedTextFontSize;
  final FontWeight selectedTextFontWeight;

  // Picker list item customization
  final Color pickerItemTextColor;
  final double pickerItemFontSize;
  final FontWeight pickerItemFontWeight;

  // Modal background
  final Color modalBackgroundColor;

  // Modal title customization
  final Color modalTitleColor;
  final double modalTitleFontSize;
  final FontWeight modalTitleFontWeight;

  // For Initialization
  final String? initialCountry;
  final String? initialState;
  final String? initialCity;

  // Default Dountry
  final String? defaultCountry;

  final double verticalPadding;

  // TextField hint text
  final String? countryTextFieldHintText;
  final String? stateTextFieldHintText;
  final String? cityTextFieldHintText;
  final String? timeZoneTextFieldHintText;

  @override
  State<CountryStateCitySelector> createState() =>
      _CountryStateCitySelectorState();
}

class _CountryStateCitySelectorState extends State<CountryStateCitySelector> {
  List<Map<String, dynamic>> countries = [];
  Map<String, dynamic>? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String? selectedTimeZone;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCountryData();
  }

  Future<void> loadCountryData() async {
    final String jsonString = await rootBundle.loadString(
      'packages/country_state_city_selector/assets/countries.json',
    );

    final List<dynamic> jsonList = jsonDecode(jsonString);

    setState(() {
      countries = jsonList.map((c) => c as Map<String, dynamic>).toList();
      isLoading = false;

      ///todo
      //  Step 1: Prefill with initialCountry (highest priority)
      if (widget.initialCountry != null) {
        if (widget.localCode == null) {
          selectedCountry =
              countries
                  .firstWhere(
                    (c) =>
                        (c["name"] as String).toLowerCase() ==
                        widget.initialCountry!.toLowerCase(),
                    orElse: () => {},
                  )
                  .isNotEmpty
              ? countries.firstWhere(
                  (c) =>
                      (c["name"] as String).toLowerCase() ==
                      widget.initialCountry!.toLowerCase(),
                )
              : null;
        } else {
          selectedCountry =
              countries
                  .firstWhere(
                    (c) =>
                        (c["translations"][widget.localCode!] as String)
                            .toLowerCase() ==
                        widget.initialCountry!.toLowerCase(),
                    orElse: () => {},
                  )
                  .isNotEmpty
              ? countries.firstWhere(
                  (c) =>
                      (c["translations"][widget.localCode!] as String)
                          .toLowerCase() ==
                      widget.initialCountry!.toLowerCase(),
                )
              : null;
        }
      }

      //  Step 2: If no initialCountry, use defaultCountry
      if (selectedCountry == null && widget.defaultCountry != null) {
        selectedCountry =
            countries
                .firstWhere(
                  (c) =>
                      (c["name"] as String).toLowerCase() ==
                      widget.defaultCountry!.toLowerCase(),
                  orElse: () => {},
                )
                .isNotEmpty
            ? countries.firstWhere(
                (c) =>
                    (c["name"] as String).toLowerCase() ==
                    widget.defaultCountry!.toLowerCase(),
              )
            : null;
      }

      //  Step 3: Prefill state (only if initialState is provided + valid)
      if (selectedCountry != null && widget.initialState != null) {
        final states = selectedCountry!["states"] as List<dynamic>;
        final stateExists = states.any(
          (s) =>
              (s["name"] as String).toLowerCase() ==
              widget.initialState!.toLowerCase(),
        );
        if (stateExists) {
          selectedState = widget.initialState;
        }
      }

      //  Step 4: Prefill city (only if initialCity is provided + valid)
      if (selectedCountry != null &&
          selectedState != null &&
          widget.initialCity != null) {
        final states = selectedCountry!["states"] as List<dynamic>;
        final stateObj = states.firstWhere(
          (s) => s["name"].toLowerCase() == selectedState!.toLowerCase(),
        );
        final cities = stateObj["cities"] as List<dynamic>;

        final cityExists = cities.any(
          (c) =>
              (c["name"] as String).toLowerCase() ==
              widget.initialCity!.toLowerCase(),
        );
        if (cityExists) {
          selectedCity = widget.initialCity;
        }
      }

      ///todo
      //  Step 5: Trigger callbacks (for prefilled/default values)
      widget.onSelectionChanged(
        (widget.localCode == null)
            ? (selectedCountry?["name"] ?? '')
            : (selectedCountry?["translations"][widget.localCode!] ?? ""),
        selectedState ?? '',
        selectedCity ?? '',
      );

      ///todo
      if (selectedCountry != null) {
        if (widget.localCode == null) {
          widget.onCountryChanged?.call(selectedCountry!["name"]);
        } else {
          widget.onCountryChanged?.call(
            selectedCountry!["translations"][widget.localCode!] ?? "",
          );
        }
      }
      if (selectedState != null) widget.onStateChanged?.call(selectedState!);
      if (selectedCity != null) widget.onCityChanged?.call(selectedCity!);
    });
  }

  void showPicker<T>({
    required BuildContext context,
    required String title,
    required List<T> items,
    required void Function(T value) onSelected,
    String? hintText,
  }) {
    List<T> filteredItems = items;

    final content = StatefulBuilder(
      builder: (context, setState) {
        return Material(
          color: Colors.transparent,
          child: FractionallySizedBox(
            heightFactor: 0.7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: widget.modalBackgroundColor,
                // uses customizable modal background
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  // Drag handle
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 12),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // Title
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: widget.modalTitleFontSize,
                        fontWeight: widget.modalTitleFontWeight,
                        color: widget.modalTitleColor,
                      ),
                    ),
                  ),

                  // Search box
                  if (!widget.hideSearch)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: (Platform.isIOS || Platform.isMacOS) && !kIsWeb
                          ? CupertinoSearchTextField(
                              placeholder: hintText ?? "Search and $title",
                              onChanged: (value) {
                                setState(() {
                                  filteredItems = items.where((item) {
                                    if (item is Map<String, dynamic>) {
                                      ///todo
                                      if (widget.localCode == null) {
                                        return item["name"]
                                            .toLowerCase()
                                            .contains(value.toLowerCase());
                                      } else {
                                        return item["translations"][widget
                                                .localCode!]
                                            .toLowerCase()
                                            .contains(value.toLowerCase());
                                      }
                                    } else if (item is String) {
                                      return item.toLowerCase().contains(
                                        value.toLowerCase(),
                                      );
                                    }
                                    return false;
                                  }).toList();
                                });
                              },
                            )
                          : TextField(
                              decoration: InputDecoration(
                                hintText: hintText ?? "Search and $title",
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (widget.localCode == null) {
                                    filteredItems = items.where((item) {
                                      if (item is Map<String, dynamic>) {
                                        return item["name"]
                                            .toLowerCase()
                                            .contains(value.toLowerCase());
                                      } else if (item is String) {
                                        return item.toLowerCase().contains(
                                          value.toLowerCase(),
                                        );
                                      }
                                      return false;
                                    }).toList();
                                  } else {
                                    filteredItems = items.where((item) {
                                      if (item is Map<String, dynamic>) {
                                        return item["translations"][widget
                                                .localCode!]
                                            .toLowerCase()
                                            .contains(value.toLowerCase());
                                      } else if (item is String) {
                                        return item.toLowerCase().contains(
                                          value.toLowerCase(),
                                        );
                                      }
                                      return false;
                                    }).toList();
                                  }
                                });
                              },
                            ),
                    ),
                  const SizedBox(height: 8),

                  // List of items
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        String displayText;
                        String? emoji;

                        if (item is Map<String, dynamic>) {
                          ///todo
                          if (widget.localCode == null) {
                            displayText = item["name"];
                          } else {
                            try {
                              displayText =
                                  item["translations"][widget.localCode!];
                            } catch (e) {
                              displayText = item["name"];
                            }
                          }
                          emoji = item["emoji"];
                        } else {
                          displayText = item.toString();
                        }

                        final bool isSelected;
                        if (item is Map<String, dynamic>) {
                          ///todo
                          if (widget.localCode == null) {
                            isSelected =
                                selectedCountry != null &&
                                selectedCountry!["name"] == displayText;
                          } else {
                            isSelected =
                                selectedCountry != null &&
                                selectedCountry!["translations"][widget
                                        .localCode!] ==
                                    displayText;
                          }
                        } else {
                          // For state or city items
                          isSelected =
                              (selectedState != null &&
                                  selectedState == displayText) ||
                              (selectedCity != null &&
                                  selectedCity == displayText);
                        }

                        final row = Row(
                          children: [
                            if (emoji != null)
                              Text(
                                emoji,
                                style: TextStyle(
                                  fontSize: widget.pickerItemFontSize,
                                ),
                              ),
                            if (emoji != null) const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                displayText,
                                style: TextStyle(
                                  fontSize: widget.pickerItemFontSize,
                                  fontWeight: widget.pickerItemFontWeight,
                                  color: isSelected
                                      ? widget.selectedTextColor
                                      : widget.pickerItemTextColor,
                                ),
                              ),
                            ),
                          ],
                        );

                        return (Platform.isIOS || Platform.isMacOS) && !kIsWeb
                            ? CupertinoButton(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                onPressed: () {
                                  onSelected(item);
                                  Navigator.pop(context);
                                },
                                child: row,
                              )
                            : ListTile(
                                title: row,
                                onTap: () {
                                  onSelected(item);
                                  Navigator.pop(context);
                                },
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if ((Platform.isIOS || Platform.isMacOS) && !kIsWeb) {
      showCupertinoModalPopup(context: context, builder: (_) => content);
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (_) => content,
      );
    }
  }

  void showPicker2<T>({
    required BuildContext context,
    required String title,
    required List<T> items,
    required void Function(T value) onSelected,
    String? hintText,
  }) {
    List<T> filteredItems = items;

    final content = StatefulBuilder(
      builder: (context, setState) {
        return Material(
          color: Colors.transparent,
          child: FractionallySizedBox(
            heightFactor: 0.7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: widget.modalBackgroundColor,
                // uses customizable modal background
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  // Drag handle
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 12),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // Title
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: widget.modalTitleFontSize,
                        fontWeight: widget.modalTitleFontWeight,
                        color: widget.modalTitleColor,
                      ),
                    ),
                  ),

                  // Search box
                  if (!widget.hideSearch)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: (Platform.isIOS || Platform.isMacOS) && !kIsWeb
                          ? CupertinoSearchTextField(
                              placeholder: hintText ?? "Search and $title",
                              onChanged: (value) {
                                setState(() {
                                  filteredItems = items.where((item) {
                                    if (item is Map<String, dynamic>) {
                                      ///todo
                                      return item["zoneName"]
                                          .toLowerCase()
                                          .contains(value.toLowerCase());
                                    } else if (item is String) {
                                      return item.toLowerCase().contains(
                                        value.toLowerCase(),
                                      );
                                    }
                                    return false;
                                  }).toList();
                                });
                              },
                            )
                          : TextField(
                              decoration: InputDecoration(
                                hintText: hintText ?? "Search and $title",
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  filteredItems = items.where((item) {
                                    if (item is Map<String, dynamic>) {
                                      return item["zoneName"]
                                          .toLowerCase()
                                          .contains(value.toLowerCase());
                                    } else if (item is String) {
                                      return item.toLowerCase().contains(
                                        value.toLowerCase(),
                                      );
                                    }
                                    return false;
                                  }).toList();
                                });
                              },
                            ),
                    ),
                  const SizedBox(height: 8),

                  // List of items
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        String displayText;
                        String? emoji;

                        if (item is Map<String, dynamic>) {
                          ///todo
                          displayText = item["zoneName"];
                          emoji = item["emoji"];
                        } else {
                          displayText = item.toString();
                        }

                        final bool isSelected;
                        if (item is Map<String, dynamic>) {
                          ///todo
                          isSelected =
                              selectedCountry != null &&
                              selectedCountry!["zoneName"] == displayText;
                        } else {
                          // For state or city items
                          isSelected =
                              (selectedState != null &&
                                  selectedState == displayText) ||
                              (selectedCity != null &&
                                  selectedCity == displayText);
                        }

                        final row = Row(
                          children: [
                            if (emoji != null)
                              Text(
                                emoji,
                                style: TextStyle(
                                  fontSize: widget.pickerItemFontSize,
                                ),
                              ),
                            if (emoji != null) const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                displayText,
                                style: TextStyle(
                                  fontSize: widget.pickerItemFontSize,
                                  fontWeight: widget.pickerItemFontWeight,
                                  color: isSelected
                                      ? widget.selectedTextColor
                                      : widget.pickerItemTextColor,
                                ),
                              ),
                            ),
                          ],
                        );

                        return (Platform.isIOS || Platform.isMacOS) && !kIsWeb
                            ? CupertinoButton(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                onPressed: () {
                                  onSelected(item);
                                  Navigator.pop(context);
                                },
                                child: row,
                              )
                            : ListTile(
                                title: row,
                                onTap: () {
                                  onSelected(item);
                                  Navigator.pop(context);
                                },
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if ((Platform.isIOS || Platform.isMacOS) && !kIsWeb) {
      showCupertinoModalPopup(context: context, builder: (_) => content);
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (_) => content,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Country Picker
        if (widget.enableLabels)
          Text(
            widget.countryHintText,
            style: TextStyle(
              color: widget.labelColor,
              fontSize: widget.labelFontSize,
              fontWeight: widget.labelFontWeight,
            ),
          ),
        GestureDetector(
          onTap: () {
            showPicker<Map<String, dynamic>>(
              context: context,
              title: widget.countryHintText,
              items: countries,
              onSelected: (value) {
                setState(() {
                  selectedCountry = value;
                  selectedState = null;
                  selectedCity = null;
                  selectedTimeZone = null;
                });

                ///todo
                if (widget.localCode == null) {
                  widget.onCountryChanged?.call(selectedCountry?["name"] ?? '');
                  widget.onSelectionChanged.call(
                    selectedCountry?["name"] ?? '',
                    selectedState ?? '',
                    selectedCity ?? '',
                  );
                } else {
                  widget.onCountryChanged?.call(
                    selectedCountry?["translations"][widget.localCode!] ?? '',
                  );
                  widget.onSelectionChanged.call(
                    selectedCountry?["translations"][widget.localCode!] ?? '',
                    selectedState ?? '',
                    selectedCity ?? '',
                  );
                }
              },
              hintText: widget.countryTextFieldHintText,
            );
          },
          child: _buildBox(
            ///todo
            widget.localCode == null
                ? (selectedCountry?["name"] ?? widget.countryHintText)
                : (selectedCountry?["translations"][widget.localCode!] ??
                      widget.countryHintText),
            widget.verticalPadding - 4,
            emoji: selectedCountry?["emoji"],
            isSelect: selectedCountry?["name"] != null,
          ),
        ),

        const SizedBox(height: 20),

        // State Picker
        if (widget.enableLabels && (!widget.hideStates))
          Text(
            widget.stateHintText,
            style: TextStyle(
              color: widget.labelColor,
              fontSize: widget.labelFontSize,
              fontWeight: widget.labelFontWeight,
            ),
          ),
        if (!widget.hideStates)
          GestureDetector(
            onTap: () {
              if (selectedCountry != null) {
                final states = selectedCountry!["states"] as List<dynamic>;
                showPicker<String>(
                  context: context,
                  title: widget.stateHintText,
                  items: states.map((s) => s["name"] as String).toList(),
                  onSelected: (value) {
                    setState(() {
                      selectedState = value;
                      selectedCity = null;
                      selectedTimeZone = null;
                    });

                    widget.onStateChanged?.call(selectedState ?? '');
                    widget.onSelectionChanged.call(
                      selectedCountry?["name"] ?? '',
                      selectedState ?? '',
                      selectedCity ?? '',
                    );
                  },
                  hintText: widget.stateTextFieldHintText,
                );
              }
            },
            child: _buildBox(
              selectedState ?? widget.stateHintText,
              widget.verticalPadding,
            ),
          ),
        if (!widget.hideStates) const SizedBox(height: 20),

        // City Picker
        if (widget.enableLabels && (!widget.hideCity))
          Text(
            widget.cityHintText,
            style: TextStyle(
              color: widget.labelColor,
              fontSize: widget.labelFontSize,
              fontWeight: widget.labelFontWeight,
            ),
          ),
        if (!widget.hideCity)
          GestureDetector(
            onTap: () {
              if (selectedCountry != null && selectedState != null) {
                final states = selectedCountry!["states"] as List<dynamic>;
                final stateObj = states.firstWhere(
                  (s) => s["name"] == selectedState,
                );

                final cities = (stateObj["cities"] as List<dynamic>)
                    .map((c) => c["name"] as String)
                    .toList();
                showPicker<String>(
                  context: context,
                  title: widget.cityHintText,
                  items: cities,
                  onSelected: (value) {
                    setState(() {
                      selectedCity = value;
                    });

                    widget.onCityChanged?.call(selectedCity ?? '');
                    widget.onSelectionChanged.call(
                      selectedCountry?["name"] ?? '',
                      selectedState ?? '',
                      selectedCity ?? '',
                    );
                  },
                  hintText: widget.cityTextFieldHintText,
                );
              }
            },
            child: _buildBox(
              selectedCity ?? widget.cityHintText,
              widget.verticalPadding,
            ),
          ),

        /// TomeZone Picker
        if (selectedCountry != null)
          Text(
            widget.timeZoneHintText,
            style: TextStyle(
              color: widget.labelColor,
              fontSize: widget.labelFontSize,
              fontWeight: widget.labelFontWeight,
            ),
          ),
        if (selectedCountry != null)
          GestureDetector(
            onTap: () {
              if (selectedCountry != null) {
                List<dynamic> timezones =
                    (selectedCountry!['timezones']) as List<dynamic>;
                List<dynamic> list = timezones
                    .map((e) => e['zoneName'])
                    .toList();
                showPicker2<dynamic>(
                  context: context,
                  title: widget.timeZoneHintText,
                  hintText: widget.timeZoneTextFieldHintText,
                  items: list,
                  onSelected: (value) {
                    setState(() {
                      selectedTimeZone = value;
                    });
                    if (widget.onTimeZoneChanged != null) {
                      widget.onTimeZoneChanged?.call(value);
                    }
                  },
                );
              }
            },
            child: _buildBox(
              ///todo
              selectedTimeZone ?? widget.timeZoneHintText,
              widget.verticalPadding - 4,
              //emoji: selectedCountry?["emoji"],
              isSelect: selectedTimeZone != null,
            ),
          ),
        if (selectedCountry != null) SizedBox(height: 14),
      ],
    );
  }

  // Picker TextFields
  Widget _buildBox(
    String text,
    double verticalPadding, {
    String? emoji,
    bool? isSelect,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: verticalPadding),
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: widget.fillColor,
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (emoji != null)
                Text(emoji, style: const TextStyle(fontSize: 22)),
              if (emoji != null) const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: isSelect == true
                      ? widget.selectedTextColor
                      : (widget.hintColor ?? Colors.grey),
                  fontSize: widget.selectedTextFontSize,
                  fontWeight: widget.selectedTextFontWeight,
                ),
              ),
            ],
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
