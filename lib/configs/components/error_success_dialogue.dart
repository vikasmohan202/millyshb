import 'package:flutter/material.dart';
import 'package:millyshb/configs/theme/colors.dart';

// ignore: must_be_immutable
class SuccessAndErrorDialougeBox extends StatefulWidget {
  bool isSuccess;
  String title;
  String subTitle;
  Function()? action;
  bool isWeb;
  SuccessAndErrorDialougeBox(
      {super.key,
      required this.subTitle,
      this.isWeb = false,
      this.isSuccess = true,
      required this.title,
      this.action});

  @override
  State<SuccessAndErrorDialougeBox> createState() =>
      _SuccessAndErrorDialougeBoxState();
}

class _SuccessAndErrorDialougeBoxState
    extends State<SuccessAndErrorDialougeBox> {
  bool isDeleting = false;

  // setMessage() {
  //   setState(() {
  //     message = 'It will take few seconds, please wait...';
  //     isDeleting = true;
  //   });
  //   Future.delayed(const Duration(seconds: 1), widget.onDelete);
  // }

  @override
  void initState() {
    setState(() {
      // if (widget.action == '') {
      //   message =
      //       "A bill will be generated and sent to the customer, and they won't be able to request more services.";
      //   title = 'Attention!';
      // } else if (widget.action == 'deleting') {
      //   message = 'Are you sure you want to delete this ${widget.title}?';
      //   title = "Deleting ${widget.title} !";
      // } else if (widget.action == 'cancel') {
      //   message = 'Are you sure you want to cancel this booking?';
      //   title = 'Cancel Booking !';
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: widget.isWeb
            ? 250
            : !(MediaQuery.of(context).size.height >= 650)
                ? MediaQuery.of(context).size.height * .40
                : MediaQuery.of(context).size.height * .30,
        width: widget.isWeb ? 360 : MediaQuery.of(context).size.width,
        // padding: const EdgeInsets.symmetric(vertical: , horizontal: 49),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.isSuccess
                ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width:
                                2.0, // Adjust the width of the circle border as needed
                          ),
                        ),
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Pallete.accentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Icon(Icons.exc)
                      // Image.asset(
                      //   "assets/images/alertIcon.png",
                      //   scale: 1.2,
                      // ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.subTitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: widget.isWeb
                  ? MediaQuery.of(context).size.width * 0.1
                  : MediaQuery.of(context).size.width * .26,
              height: 35,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: Pallete.accentColor),
                  onPressed: () {
                    Navigator.pop(context);
                    // setMessage();
                  },
                  child: Text(
                    "Okay",
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}