import 'package:flutter/material.dart';

import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:millyshb/configs/components/branded_primary_button.dart';
import 'package:millyshb/configs/theme/colors.dart';
import 'package:millyshb/configs/components/miscellaneous.dart';
import 'package:millyshb/configs/components/time_slot_to_integer.dart';
import 'package:millyshb/view/product/shopping_bag.dart';

class SelectSlots extends StatefulWidget {
  bool isWeb;
  List<int> duration;
  List<String> serviceId;
  final Function? action;

  SelectSlots({
    super.key,
    this.isWeb = false,
    required this.duration,
    required this.serviceId,
    this.action,
  });

  @override
  State<SelectSlots> createState() => _SelectSlotsState();
}

class _SelectSlotsState extends State<SelectSlots> {
  // List<dynamic> allAvailableSlots = [];
  final DatePickerController _datePickerController = DatePickerController();

  DateTime startDate = DateTime.now().subtract(const Duration(days: 14));
  DateTime endDate = DateTime.now().add(const Duration(days: 7));
  DateTime selectedDate = DateTime.now();

  int selectedSlot = 0;
  bool isLoading = false;
  bool isSlotLoading = false;

  // List<int> morningTimings = [];
  // List<int> afternoonTimings = [];
  // List<int> eveningTimings = [];
  List<int> morningTimings = [8, 9, 10, 11];
  List<int> afternoonTimings = [12, 13, 14, 15];
  List<int> eveningTimings = [16, 17, 18, 19];

  List<int> allAvailableSlots = [8, 10, 13, 16, 18];

  int startTimeSlotId = 15;
  int endTimeSlotId = 40;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    setState(() => isLoading = true);
    await fetchCompanyDetails();
    await fetchAvailableSlot(DateTime.now());
    setState(() => isLoading = false);
  }

  Future<void> fetchCompanyDetails() async {
    // setState(() => isLoading = true);
    // var response = await CompanyAPIs().getCompanyDetails();
    // if (!mounted) return;
    // if (response.success) {
    //   startTimeSlotId = response.data.startTimeSlotId;
    //   endTimeSlotId = response.data.endTimeSlotId;
    //   generateTimeSlots(startTimeSlotId, endTimeSlotId);
    // }
    // setState(() => isLoading = false);
  }

  void generateTimeSlots(int start, int end) {
    morningTimings = List.generate(end - start, (index) => start + index)
        .where((time) => time <= 23)
        .toList();
    afternoonTimings = List.generate(end - start, (index) => start + index)
        .where((time) => time > 23 && time <= 33)
        .toList();
    eveningTimings = List.generate(end - start, (index) => start + index)
        .where((time) => time > 33)
        .toList();
  }

  Future<void> fetchAvailableSlot(DateTime dateTime) async {
    // setState(() => isSlotLoading = true);
    // var response = await SalonServiceBookingAPIs().getAvailableSlotForServices(
    //     widget.serviceId, widget.duration, dateTime);
    // allAvailableSlots = response.data;
    // setState(() => isSlotLoading = false);
  }

  int getCurrentTimeSlot(DateTime dateTime) {
    int totalMinutes = dateTime.hour * 60 + dateTime.minute;
    return totalMinutes ~/ 30;
  }

  Widget buildSlotCard(int slot, bool isEnabled) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: isEnabled ? () => setState(() => selectedSlot = slot) : null,
      child: Container(
        width: 70,
        height: 50,
        alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 1,
            color: isEnabled
                ? (selectedSlot == slot
                    ? Pallete.accentColor
                    : Pallete.outLineColor)
                : Pallete.outLineColor,
          ),
          color: isEnabled
              ? (selectedSlot == slot
                  ? Pallete.accentColor.withOpacity(0.1)
                  : Colors.transparent)
              : Colors.transparent,
        ),
        child: Text(
          integerToTimeSlot(slot),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isEnabled ? Pallete.subHeading : Pallete.outLineColor,
          ),
        ),
      ),
    );
  }

  Widget buildTimeSlots(List<int> timings, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: timings
              .map((slot) => buildSlotCard(
                    slot,
                    allAvailableSlots.contains(slot) &&
                        (selectedDate.isAfter(DateTime.now()) ||
                            (selectedDate.isSameDate(DateTime.now()) &&
                                getCurrentTimeSlot(DateTime.now()) < slot)),
                  ))
              .toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            backgroundColor:
                widget.isWeb ? Colors.transparent : Pallete.whiteColor,
            appBar: widget.isWeb
                ? null
                : AppBar(
                    forceMaterialTransparency: true,
                    backgroundColor: Theme.of(context).cardColor,
                    elevation: 0,
                    centerTitle: widget.isWeb ? false : true,
                    title: const Text(
                      'Select Slot',
                      // style: Theme.of(context)
                      //     .appBarTheme
                      //     .titleTextStyle!
                      //     .copyWith(color: Pallete.highLightColor),
                    ),
                  ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Time",
                        style: TextStyle(
                            color: Pallete.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      //  margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.only(
                          left: 9, right: 9, top: 18, bottom: 33),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(width: 1, color: Pallete.outLineColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.grey,
                            alignment: Alignment.center,
                            child: HorizontalDatePickerWidget(
                              locale: 'en_IN',
                              startDate: startDate,
                              endDate: endDate,
                              selectedDate: selectedDate,
                              widgetWidth: MediaQuery.of(context).size.width,
                              datePickerController: _datePickerController,
                              onValueSelected: (date) async {
                                selectedDate = date;
                                await fetchAvailableSlot(date);
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          isSlotLoading
                              ? loadingIndicator()
                              : Column(
                                  children: [
                                    buildTimeSlots(morningTimings, "Morning"),
                                    buildTimeSlots(
                                        afternoonTimings, "Afternoon"),
                                    buildTimeSlots(eveningTimings, "Evening"),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            persistentFooterButtons: [
              BrandedPrimaryButton(
                  isEnabled: true,
                  name: "Procced",
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ShoppingBagScreen();
                    }));
                  })
            ],
          );
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
