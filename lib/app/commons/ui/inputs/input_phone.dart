import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/ui/buttons/x_button.dart';
import 'package:schematic/app/commons/ui/inputs/x_input.dart';

class InputPhone extends StatefulWidget {
  const InputPhone({super.key});

  @override
  _InputPhoneState createState() => _InputPhoneState();
}

class _InputPhoneState extends State<InputPhone> {
  String selectedCountryCode = '+91';
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Horizontal space between country code and phone number input
        // Phone number input
        // button show bottom sheet with country codes
        // Country code input
        // Vertical space between country code and phone number input
        // Phone number input
        XButton.outline(
          padding: const EdgeInsets.all(0),
          borderRadius: 5,
          fixedSize: const Size(80, 45),
          textStyle: Theme.of(context).textTheme.bodyMedium,
          foregroundColor: Colors.black,
          onPressed: () {
            Get.bottomSheet(
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                height: Get.height * 0.5,
                child: ListView.builder(
                  itemCount: getCountryCodes().length,
                  itemBuilder: (context, index) {
                    final country = getCountryCodes()[index];
                    return ListTile(
                      leading: Text(country['flag']!),
                      title: Text('${country['name']!} ${country['code']!}'),
                      onTap: () {
                        setState(() {
                          selectedCountryCode = country['code']!;
                        });
                        Get.back();
                      },
                    );
                  },
                ),
              ),
            );
          },
          text: selectedCountryCode,
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        Expanded(
          child: XInput(
            label: 'Phone Number',
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              // Do something with the phone number
              selectedCountryCode + value;
            },
            inputFormatters: [
              // Add input formatter to enforce phone number format
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  List<Map<String, String>> getCountryCodes() {
    return [
      {"name": "India", "code": "+91", "flag": "🇮🇳"},
      {"name": "Indonesia", "code": "+62", "flag": "🇮🇩"},
      {"name": "United Kingdom", "code": "+44", "flag": "🇬🇧"},
      {"name": "Germany", "code": "+49", "flag": "🇩🇪"},
      {"name": "Australia", "code": "+61", "flag": "🇦🇺"},
      {"name": "Canada", "code": "+1", "flag": "🇨🇦"},
      {"name": "Brazil", "code": "+55", "flag": "🇧🇷"},
      {"name": "France", "code": "+33", "flag": "🇫🇷"},
      {"name": "China", "code": "+86", "flag": "🇨🇳"},
      {"name": "Japan", "code": "+81", "flag": "🇯🇵"},
      {"name": "South Korea", "code": "+82", "flag": "🇰🇷"},
      {"name": "Mexico", "code": "+52", "flag": "🇲🇽"},
      {"name": "Russia", "code": "+7", "flag": "🇷🇺"},
      {"name": "South Africa", "code": "+27", "flag": "🇿🇦"},
      {"name": "Turkey", "code": "+90", "flag": "🇹🇷"}
    ];
  }
}
