import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/models/address_model.dart';
import 'package:millyshb/view/address/address_screen.dart';
import 'package:millyshb/view/widget/address_card.dart';
import 'package:millyshb/view_model/address_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AddressList extends StatefulWidget {
  bool isSelectAddress;
   AddressList({this.isSelectAddress=false,super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  _fetchAddresses() async {
    setState(() {
      isLoading = true;
    });
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await addressProvider.getAddressList(userProvider.user!.id, context);

    setState(() {
      isLoading = false;
    }); // Replace with actual userId
  }

  void _editAddress(Address address) {
    // Implement edit address functionality
    // You might navigate to another screen or show a dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Address'),
          content: Text('Edit address for ${address.city}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add your edit logic here
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _removeAddress(Address address) {
    // Implement remove address functionality
    // You might show a confirmation dialog before removing the address
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove Address'),
          content: Text(
              'Are you sure you want to remove the address for ${address.city}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add your remove logic here
                //Provider.of<AddressProvider>(context, listen: false).removeAddress(address.id);
                Navigator.of(context).pop();
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              title: const Text('My Addresses'),
            ),
            body: Consumer<AddressProvider>(
              builder: (context, addressProvider, child) {
                if (addressProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (addressProvider.address.isEmpty) {
                  return const Center(child: Text('No addresses found'));
                } else {
                  return ListView.builder(
                    itemCount: addressProvider.address.length,
                    itemBuilder: (context, index) {
                      final address = addressProvider.address[index];
                      return addressCard(context, address,
                          Provider.of<UserProvider>(context, listen: false));
                    },
                  );
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddressInputScreen();
                })).then((value) async {
                  await _fetchAddresses();
                });
              },
              child: const Icon(Icons.add),
            ),
          );
  }
}

//  Padding(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   child: Card(
//                     child: ListTile(
//                       title: Text(address.city),
//                       subtitle: const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("45, Suresh Sharma Nagar Bareilly"),
//                           SizedBox(height: 10),
//                           Text("9621040205"),
//                         ],
//                       ),
//                       trailing: PopupMenuButton<String>(
//                         onSelected: (value) {
//                           if (value == 'edit') {
//                             _editAddress(address);
//                           } else if (value == 'remove') {
//                             _removeAddress(address);
//                           }
//                         },
//                         itemBuilder: (context) => [
//                           PopupMenuItem<String>(
//                             value: 'edit',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.edit, color: Colors.black),
//                                 SizedBox(width: 8),
//                                 Text('Edit'),
//                               ],
//                             ),
//                           ),
//                           PopupMenuItem<String>(
//                             value: 'remove',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.delete, color: Colors.red),
//                                 SizedBox(width: 8),
//                                 Text('Remove'),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                       isThreeLine: true,
//                     ),
//                   ),
//                 );