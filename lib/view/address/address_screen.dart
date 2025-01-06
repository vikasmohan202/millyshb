import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/phone_edit_field.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/view_model/address_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AddressInputScreen extends StatefulWidget {
  final Address? customerAddress;
  final bool isEdit;

  const AddressInputScreen({
    super.key,
    this.isEdit = false,
    this.customerAddress,
  });

  @override
  _AddressInputScreenState createState() => _AddressInputScreenState();
}

class _AddressInputScreenState extends State<AddressInputScreen> {
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pinNumberController = TextEditingController();
  bool isLoading = false;
  AddressType? selectedAddressType;
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = "";
  bool isEnable = false;
  bool isHomeDisabled = false;
  bool isWorkDisabled = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      addressProvider.getAddressList("669e2f350a92abdbb4e2003c", context);
    });

    if (widget.isEdit) {
      _nameController.text = widget.customerAddress!.name;
      _areaController.text = widget.customerAddress!.street;
      _houseController.text = widget.customerAddress!.houseNumber;
      _phoneNumber = widget.customerAddress!.mobileNumber;
      _mobileNumberController.text = widget.customerAddress!.mobileNumber;
      _areaController.text = widget.customerAddress!.street;
      _stateController.text = widget.customerAddress!.state;
      _cityController.text = widget.customerAddress!.city;
      _countryController.text = widget.customerAddress!.country;
      _pinNumberController.text = widget.customerAddress!.postalCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              "Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          persistentFooterButtons: [
            BrandedPrimaryButton(
              isEnabled: true, //_houseController.text.isNotEmpty,
              name: "Save",
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                Address address = Address(
                    addressType: AddressType.HOME,
                    city: _cityController.text,
                    state: _stateController.text,
                    country: _countryController.text,
                    houseNumber: _houseController.text,
                    mobileNumber: _phoneNumber, //_mobileNumberController.text,
                    name: _nameController.text,
                    postalCode: _pinNumberController.text,
                    street: _areaController.text,
                    userId: userProvider.user!.id);

                if (widget.isEdit) {
                  address.addressId = widget.customerAddress!.addressId;
                  await addressProvider.editAddress(address, context);
                } else {
                  await addressProvider.saveAddress(address, context);
                }
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BrandedTextField(
                        controller: _nameController,
                        labelText: 'Name.',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Name before proceeding';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(),
                        child: PhoneEditField(
                          currentNumber: _mobileNumberController.text,
                          enabled: true,
                          updatePhone: (value) {
                            _phoneNumber = value;
                            setState(() {
                              isEnable = value.length > 10;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BrandedTextField(
                        keyboardType: TextInputType.number,
                        controller: _houseController,
                        labelText: 'House / Flat/ Block.',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter House Number before proceeding';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BrandedTextField(
                        controller: _areaController,
                        labelText: 'Apartment/ Road / Area',
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.4,
                            child: BrandedTextField(
                              keyboardType: TextInputType.phone,
                              controller: _pinNumberController,
                              labelText: 'Pin Code',
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.4,
                            child: BrandedTextField(
                              controller: _cityController,
                              labelText: 'City',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      BrandedTextField(
                        controller: _stateController,
                        labelText: 'State',
                      ),
                      const SizedBox(height: 20.0),
                      BrandedTextField(
                        controller: _countryController,
                        labelText: 'Country',
                      ),

                      // const SizedBox(height: 20.0),
                      // const Text('Save As'),
                      // const SizedBox(height: 20.0),
                      // Wrap(
                      //   spacing: 20,
                      //   children: [
                      //     _buildSaveAsButton(context, Icons.home, 'Home',
                      //         AddressType.HOME, isHomeDisabled),
                      //     _buildSaveAsButton(context, Icons.work, 'Work',
                      //         AddressType.WORK, isWorkDisabled),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isLoading)
          loadingIndicator(
            isTransParent: true,
          )
      ],
    );
  }

  Widget _buildSaveAsButton(BuildContext context, IconData icon, String label,
      AddressType type, bool isDisabled) {
    return ElevatedButton.icon(
      onPressed: isDisabled
          ? null
          : () {
              setState(() {
                selectedAddressType = type;
              });
            },
      icon: Icon(
        icon,
        color: selectedAddressType == type && !isDisabled
            ? Colors.white
            : isDisabled
                ? Pallete.greyColor
                : Colors.black,
      ),
      label: Text(
        label,
        style: TextStyle(
          color:
              selectedAddressType == type ? Colors.white : Pallete.accentColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedAddressType == type ? Pallete.accentColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _houseController.dispose();
    super.dispose();
  }
}
