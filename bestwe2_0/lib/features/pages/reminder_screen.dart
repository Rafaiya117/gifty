import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/widgets/reminder_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  DateTime selectedDay = DateTime.now();
  Map<DateTime, List<Map<String, String>>> events = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3): [
      {'title': 'Fathers Day', 'time': '12.01 AM'}
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
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
                        'Reminder',
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF5B4025),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w),
                ],
              ),
            ),

            // Calendar and Events
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: selectedDay,
              selectedDayPredicate: (day) => isSameDay(day, selectedDay),
              // onDaySelected: (newDay, _) => setState(() => selectedDay = newDay),
              onDaySelected: (newDay, _) {
                setState(() {
                  selectedDay = newDay;
                  print('newDay........................ $newDay');
                });
              },
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5B4025),
                ),
                leftChevronIcon: Icon(Icons.chevron_left, color: const Color(0xFF5B4025)),
                rightChevronIcon: Icon(Icons.chevron_right, color: const Color(0xFF5B4025)),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey),
                weekendStyle: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                selectedDecoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                selectedTextStyle: GoogleFonts.poppins(color: Color(0xFF5B4025), fontWeight: FontWeight.bold),
                defaultTextStyle: GoogleFonts.poppins(color: Color(0xFF5B4025)),
                weekendTextStyle: GoogleFonts.poppins(color: Color(0xFF5B4025)),
              ),
            ),

            SizedBox(height: 24.h),

            // Events List
            Builder(
              builder: (_) {
                final dayEvents = events[selectedDay] ?? [];

                if (dayEvents.isEmpty) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Center(
                      child: Text(
                        'No Events',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: const Color(0xFF5B4025),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }

                final event = dayEvents.first;
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Consumer<ApplicationState>(
                    builder: (context, appState, _) {
                      final notes = appState.giftpotState.note;

                      if (notes.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            'No notes found',
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey),
                          ),
                        );
                      }

                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(), // allows nested scroll
                        children: notes.map((note) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9F6F3),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: const Color(0xFFE0DAD1),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.noteDate,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown[400],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  note.note,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF5B4025),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    note.createdAt,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                );
              },
            ),
            Consumer<ApplicationState>(
                builder: (context, appState,_){
                  final notes = appState.giftpotState.note;
                  return NoteListScreen(notes: notes,);
                }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 4,
        onPressed: () => context.push('/set-reminder', extra: selectedDay),
        child: Icon(Icons.add, color: const Color(0xFF5B4025)),
      ),
    );
  }
}
