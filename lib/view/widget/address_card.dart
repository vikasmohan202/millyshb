import 'package:flutter/material.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/view/address/address_screen.dart';
import 'package:millyshb/view_model/address_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

Widget addressCard(BuildContext context, Address customerAddress,
    UserProvider customerProvider) {
  final addressProvider = Provider.of<AddressProvider>(context, listen: false);
  return GestureDetector(
    onTap: () async {
      await addressProvider.selectAddress(
          customerAddress.addressId, customerAddress.userId, context);
      Navigator.of(context).pop();
    },
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getAddressWidget(customerAddress),
            const SizedBox(height: 5),
            Text(
              '${customerAddress.houseNumber} ${customerAddress.street} ${customerAddress.city} ${customerAddress.state} ${customerAddress.country} ${customerAddress.postalCode}',
              // "${customerAddress.name} ${customerAddress.postalCode}",
              style: const TextStyle(fontSize: 12, color: Pallete.subHeading),
            ),
            const SizedBox(height: 5),
            Text(
              'Phone number: ${customerAddress.mobileNumber}',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddressInputScreen(
                        customerAddress: customerAddress,
                        isEdit: true,
                      );
                    }));
                  },
                  child: const Text(
                    'EDIT',
                    style: TextStyle(color: Pallete.accentColor),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    addressProvider.deleteAddress(customerAddress, context);
                  },
                  child: const Text(
                    'DELETE',
                    style: TextStyle(color: Pallete.accentColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget getAddressWidget(Address customerAddress) {
  switch (customerAddress.addressType) {
    case AddressType.HOME:
      return const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.home_outlined,
            color: Pallete.black87,
          ),
          SizedBox(width: 8),
          Text(
            "Home",
            // customerAddress.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );
    case AddressType.WORK:
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.work_outline,
            color: Pallete.black87,
          ),
          const SizedBox(width: 8),
          Text(
            customerAddress.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );

    default:
      return Container();
  }
}
