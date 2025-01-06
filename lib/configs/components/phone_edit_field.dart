import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:millyshb/configs/theme/colors.dart';

// ignore: must_be_immutable
class PhoneEditField extends StatefulWidget {
  PhoneEditField(
      {super.key,
      this.focus,
      required this.updatePhone,
      required this.currentNumber,
      required this.enabled});
  final ValueChanged<String> updatePhone;
  String currentNumber;
  bool enabled = true;
  FocusNode? focus = primaryFocus;

  @override
  State<PhoneEditField> createState() => _PhoneEditFieldState();
}

class _PhoneEditFieldState extends State<PhoneEditField> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      focusNode: widget.focus,
      initialValue: widget.currentNumber,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14, fontWeight: FontWeight.w500, color: Pallete.textColor),
      decoration: InputDecoration(
        fillColor: Colors.grey
            .withOpacity(.15), //const Color.fromARGB(255, 226, 226, 245),
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Pallete.disableButtonTextColor),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Pallete.accentColor), // Change the color as desired
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Pallete.outLineColor), // Change the color as desired
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        hintText: "Phone Number",

        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(103, 103, 103, 1),
            fontSize: 12),
        contentPadding: const EdgeInsets.all(12),
      ),

      enabled: widget.enabled,
      initialCountryCode:
          'IN', // Change it to your desired initial country code
      onChanged: (phone) {
        widget.updatePhone(phone.completeNumber);
      },
      // onCountryChanged: (country) {
      //   print(country.code);
      // },
    );
  }
}
