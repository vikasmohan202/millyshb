import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/components/branded_text_field.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final bool isWeb;
  final Function? action;

  const ProfilePage({this.action, this.isWeb = false, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String profilePicPath = '';
  bool isImageLoading = false;
  String picture = '';
  bool isEdit = false;

  Uint8List? _bytesData;

  @override
  void initState() {
    super.initState();
  }

  void receiveCroppedImage(String data) async {
    setState(() {
      isImageLoading = true;
    });

    if (data.isNotEmpty) {
      profilePicPath = data;
    }

    // Simulate image upload and get a static URL
    await Future.delayed(const Duration(seconds: 2));
    picture = "https://example.com/cropped_profile_pic.jpg";

    setState(() {
      isImageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController.text = userProvider.user!.userName;
    mobileController.text = userProvider.user!.mobileNumber;
    emailController.text = userProvider.user!.email;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        leading: BackButton(onPressed: () {
          Navigator.of(context).pop();
        }),
        centerTitle: true,
        title: const Text(
          'Profile',
        ),
        actions: const [
          // IconButton(
          //   icon: isEdit ? Icon(Icons.done) : Icon(Icons.edit),
          //   onPressed: () {
          //     setState(() {
          //       isEdit = isEdit ? false : true;
          //     });
          //   },
          // )
        ],
      ),
      persistentFooterButtons: [
        BrandedPrimaryButton(name: "Save", onPressed: () {})
      ],
      body: Padding(
        padding: widget.isWeb
            ? const EdgeInsets.only(left: 16, right: 16)
            : const EdgeInsets.all(0),
        child: Container(
          decoration: ShapeDecoration(
            color: Pallete.whiteColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: widget.isWeb ? Pallete.outLineColor : Pallete.whiteColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Center(
                    //   child: InkWell(
                    //     onTap: () async {
                    //       setState(() {});
                    //     },
                    //     child: CircleAvatar(
                    //       backgroundColor: Pallete.greyColor,
                    //       radius: 55,
                    //       child: isImageLoading
                    //           ? const CircularProgressIndicator()
                    //           : ClipOval(
                    //               clipBehavior: Clip.hardEdge,
                    //               child: _bytesData != null
                    //                   ? Image.memory(
                    //                       _bytesData!,
                    //                       width: 200,
                    //                       height: 200,
                    //                       fit: BoxFit.cover,
                    //                     )
                    //                   : picture.isNotEmpty
                    //                       ? Image.network(
                    //                           picture,
                    //                           width: 200,
                    //                           height: 200,
                    //                           fit: BoxFit.cover,
                    //                         )
                    //                       : const Icon(
                    //                           Icons.photo_camera,
                    //                           size: 38,
                    //                           color: Pallete.whiteColor,
                    //                         )),
                    //     ),
                    //   ),
                    // ),
                    // Center(
                    //   child: TextButton(
                    //     onPressed: () async {},
                    //     child: const Text(
                    //       "Upload Image",
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 30,
                    ),

                    BrandedTextField(
                        controller: nameController, labelText: "Name"),
                    const SizedBox(
                      height: 30,
                    ),
                    // PhoneEditField(
                    //   currentNumber: mobileController.text,
                    //   enabled: true,
                    //   updatePhone: (value) {
                    //     mobileController.text = value;
                    //   },
                    // ),
                    BrandedTextField(
                        controller: mobileController,
                        labelText: 'Phone Number'),
                    const SizedBox(
                      height: 30,
                    ),
                    BrandedTextField(
                        controller: emailController, labelText: 'Email Id'),
                    const SizedBox(
                      height: 30,
                    ),
                    if (widget.isWeb)
                      const SizedBox(
                        height: 40,
                      )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
