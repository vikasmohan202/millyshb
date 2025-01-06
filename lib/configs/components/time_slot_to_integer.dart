int timeSlotToInteger(String timeSlot) {
  // Split the time slot string into parts
  final parts = timeSlot.split(' ');

  // Parse the time and AM/PM parts
  final timeParts = parts[0].split(':');
  final hour = int.parse(timeParts[0]);
  final minute = int.parse(timeParts[1]);
  final isPM = parts[1].toLowerCase() == 'pm';

  // Calculate the time in minutes
  int timeInMinutes = (hour % 12) * 60 + minute;

  // Add 12 hours (720 minutes) if it's PM
  if (isPM) {
    timeInMinutes += 720;
  }

  // Calculate the time slot integer (30-minute slots)
  int timeSlotInteger = timeInMinutes ~/ 30;

  return timeSlotInteger;
}

String integerToTimeSlot(int timeSlotInteger) {
  // Calculate the total minutes since midnight
  int totalMinutes = timeSlotInteger * 30;

  // Calculate the hour and minute parts
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;

  // Adjust hours for 12-hour clock format
  hours = hours % 12;
  // Handle the case when hours is 0 (midnight)
  if (hours == 0) {
    hours = 12;
  }
  // Determine if it's AM or PM
  String amPm = totalMinutes < 720 ? 'AM' : 'PM';

  // Format the time as a string
  String formattedTime = '$hours:${minutes.toString().padLeft(2, '0')} $amPm';

  return formattedTime;
}

String convertTo12HourFormat(String input) {
  // Split the input string into hours and AM/PM parts
  List<String> parts = input.split(' ');

  if (parts.length != 2) {
    // Invalid input format
    return '';
  }

  String timePart = parts[0];
  String amPmPart = parts[1];

  int hours;
  int minutes = 0; // Default to 0 minutes

  // Check if the input is in 12-hour format
  if (RegExp(r'^\d{1,2}(:\d{2})?$').hasMatch(timePart)) {
    // Parse hours and minutes if present
    List<String> timeParts = timePart.split(':');
    hours = int.parse(timeParts[0]);
    if (timeParts.length == 2) {
      minutes = int.parse(timeParts[1]);
    }
  } else {
    // Invalid time format
    return 'Invalid time format';
  }

  // Convert to 12-hour format
  String period = amPmPart.toUpperCase();
  if (period == 'AM') {
    if (hours == 12) {
      // 12 AM should be converted to 0 AM
      hours = 0;
    }
  } else if (period == 'PM') {
    if (hours != 12) {
      // Add 12 to hours if it's not already 12 PM
      hours -= 12;
    }
  } else {
    // Invalid AM/PM part
    return 'Invalid AM/PM part';
  }

  // Format the result as a 12-hour time string
  return '$hours:${minutes.toString().padLeft(2, '0')} $period';
}
