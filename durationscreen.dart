// ignore_for_file: unnecessary_cast

import 'dart:ui';
import 'package:flutter/material.dart';

class DurationScreen extends StatefulWidget {
  const DurationScreen({super.key});

  @override
  _DurationScreenState createState() => _DurationScreenState();
}

class _DurationScreenState extends State<DurationScreen> {
  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Sturday"
  ];
  String? selectedDay;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  List<Teacher> availableTeachers = [];
  String? selectedCampus;
  String? selectedDepartment;
  String? selectedSemester;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Teacher Availability'),
      ),
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 161, 203, 237),
                  Color.fromARGB(255, 229, 169, 239)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Glassmorphism effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: const Color.fromARGB(255, 171, 239, 183).withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      hint: const Text('Select Day'),
                      value: selectedDay,
                      items: days.map((day) {
                        return DropdownMenuItem(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDay = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeButton(
                          context: context,
                          time: startTime,
                          label: 'Select Start Time',
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null && picked != startTime) {
                              setState(() {
                                startTime = picked;
                              });
                            }
                          },
                        ),
                        _buildTimeButton(
                          context: context,
                          time: endTime,
                          label: 'Select End Time',
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null && picked != endTime) {
                              setState(() {
                                endTime = picked;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _filterTeachers,
                      child: const Text('Check Availability'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: availableTeachers.length,
                        itemBuilder: (context, index) {
                          final teacher = availableTeachers[index];
                          return Card(
                            color: Colors.white.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                teacher.name,
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                '${teacher.department}, ${teacher.campus}',
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterBottomSheet,
        child: const Icon(Icons.filter_list),
      ),
    );
  }

  Widget _buildTimeButton({
    required BuildContext context,
    required TimeOfDay? time,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(time == null ? label : time.format(context)),
    );
  }

  void _filterTeachers() {
    if (selectedDay == null || startTime == null || endTime == null) {
      // Show error message
      return;
    }

    setState(() {
      availableTeachers = _teachers.where((teacher) {
        bool matchesDay = teacher.availability.containsKey(selectedDay) &&
            teacher.availability[selectedDay]!.any((timeRange) {
              final start = TimeOfDay(
                hour: int.parse(timeRange.start.split(":")[0]),
                minute: int.parse(timeRange.start.split(":")[1]),
              );
              final end = TimeOfDay(
                hour: int.parse(timeRange.end.split(":")[0]),
                minute: int.parse(timeRange.end.split(":")[1]),
              );
              return _isTimeInRange(start, end);
            });
        bool matchesCampus = selectedCampus == null ||
            teacher.campus.toLowerCase() == selectedCampus!.toLowerCase();
        bool matchesDepartment = selectedDepartment == null ||
            teacher.department.toLowerCase() ==
                selectedDepartment!.toLowerCase();
        bool matchesSemester =
            selectedSemester == null || teacher.semester == selectedSemester;

        return matchesDay &&
            matchesCampus &&
            matchesDepartment &&
            matchesSemester;
      }).toList();
    });
  }

  bool _isTimeInRange(TimeOfDay start, TimeOfDay end) {
    final selectedStart =
        TimeOfDay(hour: startTime!.hour, minute: startTime!.minute);
    final selectedEnd = TimeOfDay(hour: endTime!.hour, minute: endTime!.minute);

    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    final selectedStartMinutes = selectedStart.hour * 60 + selectedStart.minute;
    final selectedEndMinutes = selectedEnd.hour * 60 + selectedEnd.minute;

    return selectedStartMinutes >= startMinutes &&
        selectedEndMinutes <= endMinutes;
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Filter By', style: TextStyle(fontSize: 18)),
                  CheckboxListTile(
                    title: const Text('Campus'),
                    value: selectedCampus != null,
                    onChanged: (value) {
                      setModalState(() {
                        if (value == true) {
                          _showCampusSelection(context, setModalState);
                        } else {
                          selectedCampus = null;
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Department'),
                    value: selectedDepartment != null,
                    onChanged: (value) {
                      setModalState(() {
                        if (value == true) {
                          _showDepartmentSelection(context, setModalState);
                        } else {
                          selectedDepartment = null;
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Semester'),
                    value: selectedSemester != null,
                    onChanged: (value) {
                      setModalState(() {
                        if (value == true) {
                          _showSemesterSelection(context, setModalState);
                        } else {
                          selectedSemester = null;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _filterTeachers();
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Apply Filters'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showCampusSelection(BuildContext context, StateSetter setModalState) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Campus'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: const Text('LNCT'),
                value: 'LNCT',
                groupValue: selectedCampus,
                onChanged: (value) {
                  setModalState(() {
                    selectedCampus = value as String?;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('LNCTS'),
                value: 'LNCTS',
                groupValue: selectedCampus,
                onChanged: (value) {
                  setModalState(() {
                    selectedCampus = value as String?;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('LNCTE'),
                value: 'LNCTE',
                groupValue: selectedCampus,
                onChanged: (value) {
                  setModalState(() {
                    selectedCampus = value as String?;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDepartmentSelection(
      BuildContext context, StateSetter setModalState) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Department'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: const Text('CSE'),
                value: 'CSE',
                groupValue: selectedDepartment,
                onChanged: (value) {
                  setModalState(() {
                    selectedDepartment = value as String?;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('ECE'),
                value: 'ECE',
                groupValue: selectedDepartment,
                onChanged: (value) {
                  setModalState(() {
                    selectedDepartment = value as String?;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('IOT'),
                value: 'IOT',
                groupValue: selectedDepartment,
                onChanged: (value) {
                  setModalState(() {
                    selectedDepartment = value as String?;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSemesterSelection(BuildContext context, StateSetter setModalState) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Semester'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: const Text('4'),
                value: '4',
                groupValue: selectedSemester,
                onChanged: (value) {
                  setModalState(() {
                    selectedSemester = value as String?;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('5'),
                value: '5',
                groupValue: selectedSemester,
                onChanged: (value) {
                  setModalState(() {
                    selectedSemester = value;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('6'),
                value: '6',
                groupValue: selectedSemester,
                onChanged: (value) {
                  setModalState(() {
                    selectedSemester = value as String?;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Define your Teacher class and sample data
class Teacher {
  final String name;
  final String department;
  final String campus;
  final String semester;
  final Map<String, List<TimeRange>> availability;

  Teacher({
    required this.name,
    required this.department,
    required this.campus,
    required this.semester,
    required this.availability,
  });
}

class TimeRange {
  final String start;
  final String end;

  TimeRange({required this.start, required this.end});
}

// Sample teachers data
final List<Teacher> _teachers = [
  Teacher(
    name: "Teacher A",
    department: "CSE",
    campus: "LNCT",
    semester: "4",
    availability: {
      "Monday": [
        TimeRange(start: "09:00", end: "10:00"),
        TimeRange(start: "14:00", end: "15:00")
      ],
      "Tuesday": [TimeRange(start: "11:00", end: "12:00")],
    },
  ),
  Teacher(
    name: "Teacher B",
    department: "CSE",
    campus: "LNCTS",
    semester: "5",
    availability: {
      "Monday": [
        TimeRange(start: "10:00", end: "11:00"),
        TimeRange(start: "13:00", end: "14:00")
      ],
      "Thursday": [TimeRange(start: "12:00", end: "13:00")],
    },
  ),
  Teacher(
    name: "Teacher C",
    department: "CSE",
    campus: "LNCT",
    semester: "4",
    availability: {
      "Monday": [
        TimeRange(start: "10:00", end: "11:00"),
        TimeRange(start: "15:00", end: "16:00")
      ],
    },
  ),
  Teacher(
    name: "Teacher D",
    department: "CSE",
    campus: "LNCT",
    semester: "4",
    availability: {
      "Monday": [
        TimeRange(start: "10:00", end: "11:00"),
        TimeRange(start: "14:00", end: "15:00")
      ],
    },
  ),
  Teacher(
    name: "Teacher E",
    department: "ECE",
    campus: "LNCTS",
    semester: "5",
    availability: {
      "Monday": [
        TimeRange(start: "10:00", end: "11:00"),
        TimeRange(start: "13:00", end: "14:00")
      ],
    },
  ),
];
