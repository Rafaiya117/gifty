import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/app_State/giftpot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SetReminderScreen extends StatefulWidget {
  final DateTime selectedDate;
  const SetReminderScreen({super.key, required this.selectedDate});

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  String _title = '';
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom AppBar
            Padding(
              padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w, bottom: 12.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5CFC5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF5B4025), size: 22.sp),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Set Reminder',
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF5B4025),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
                      final formattedTime = _time.format(context);
                      final note = _title.isEmpty ? "Reminder set at $formattedTime" : _title;
                      final appState = context.read<ApplicationState>();
                      try {
                        await appState.giftpotState.createNote(noteDate: formattedDate, note: note,);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '✅ Note created for $formattedDate at $formattedTime',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        context.pop(); 
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to create note: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5CFC5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check, color: Color(0xFF5B4025), size: 22.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reminder title field
                  GestureDetector(
                    onTap: () async {
                      final controller = TextEditingController(text: _title);
                      final result = await showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: const Color(0xFFF9F6F3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                          title: Text('Reminder Title', style: GoogleFonts.poppins(color: const Color(0xFF5B4025))),
                          content: TextField(
                            controller: controller,
                            style: GoogleFonts.poppins(color: const Color(0xFF5B4025)),
                            decoration: InputDecoration(
                              hintText: 'Enter title',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(controller.text),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                      if (result != null && result.isNotEmpty) {
                        setState(() => _title = result);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20.h),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: _title.isNotEmpty ? Text(
                        _title,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: const Color(0xFF5B4025),
                        ),
                      ) : Text(
                        'Enter title',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // Time field
                  GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: _time,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              timePickerTheme: TimePickerThemeData(
                                backgroundColor: const Color(0xFFF9F6F3),
                                hourMinuteTextColor: const Color(0xFF5B4025),
                                dayPeriodTextColor: const Color(0xFF5B4025),
                                dialHandColor: const Color(0xFF5B4025),
                                entryModeIconColor: const Color(0xFF5B4025),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() => _time = picked);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20.h),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _time.format(context),
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: const Color(0xFF5B4025),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: const Color(0xFF5B4025)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
