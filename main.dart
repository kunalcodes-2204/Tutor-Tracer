import 'package:flutter/material.dart';
import 'package:tutor_tracer/durationscreen.dart';
import 'package:tutor_tracer/form_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'more_screen.dart';
import 'splash_screen.dart';

// Define a class to represent a Teacher
class Teacher {
  final String name;
  final String phoneNumber;
  final String campusNames;
  final String departments;
  final String semester;
  final String section;
  final String profileImagePath;
  final String timetableImagePath;

  final Map<String, List<TimeRange>> availability;

  Teacher(
      {required this.name,
      required this.phoneNumber,
      required this.campusNames,
      required this.departments,
      required this.semester,
      required this.section,
      required this.availability,
      required this.profileImagePath,
      required this.timetableImagePath});
}

// Define a class to represent a time range
class TimeRange {
  final TimeOfDay start;
  final TimeOfDay end;
  final String classroom;

  TimeRange({
    required this.start,
    required this.end,
    required this.classroom,
  });
}

// Define a class to represent a list of teachers
class TeachersList {
  final List<Teacher> teachers;

  TeachersList({required this.teachers});
}

// Function to check if a given time falls within a TimeRange
bool isTimeInRange(TimeOfDay time, TimeRange range) {
  final startTime = range.start;
  final endTime = range.end;
  final now = time;

  // Check if the end time is before the start time (for time ranges that cross the midnight boundary)
  if (endTime.hour < startTime.hour ||
      (endTime.hour == startTime.hour && endTime.minute < startTime.minute)) {
    return now.hour >= startTime.hour ||
        now.hour <= endTime.hour ||
        (now.hour == endTime.hour && now.minute <= endTime.minute) ||
        (now.hour == startTime.hour && now.minute >= startTime.minute);
  } else {
    return now.hour >= startTime.hour && now.hour <= endTime.hour ||
        (now.hour == startTime.hour && now.minute >= startTime.minute) ||
        (now.hour == endTime.hour && now.minute <= endTime.minute);
  }
}

// Dummy data for teachers' schedules
List<Teacher> teachers = [
  Teacher(
    name: 'John Doe',
    phoneNumber: '7987660323',
    campusNames: 'LNCT',
    departments: 'CSE',
    semester: '4th',
    section: 'A',
    profileImagePath: 'assets/john_doe.png',
    timetableImagePath: 'assets/image.jpeg',
    availability: {
      'Monday': [
        TimeRange(
          start: const TimeOfDay(hour: 9, minute: 00),
          end: const TimeOfDay(hour: 9, minute: 50),
          classroom: '144',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 0),
          end: const TimeOfDay(hour: 17, minute: 0),
          classroom: '422',
        ),
      ],
      'Tuesday': [
        TimeRange(
          start: const TimeOfDay(hour: 10, minute: 00),
          end: const TimeOfDay(hour: 12, minute: 0),
          classroom: '001',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 14, minute: 0),
          end: const TimeOfDay(hour: 15, minute: 0),
          classroom: '666',
        ),
      ],
    },
  ),
  Teacher(
    name: 'Jane Smith',
    phoneNumber: '9876543210',
    campusNames: 'LNCT',
    departments: 'ECE',
    semester: '4th',
    section: 'B',
    profileImagePath: 'assets/jane_smith.png',
    timetableImagePath: 'assets/timetable_jane_smith.png',
    availability: {
      'Monday': [
        TimeRange(
          start: const TimeOfDay(hour: 9, minute: 15),
          end: const TimeOfDay(hour: 10, minute: 0),
          classroom: '108',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 14, minute: 0),
          end: const TimeOfDay(hour: 15, minute: 0),
          classroom: '105',
        ),
      ],
      'Tuesday': [
        TimeRange(
          start: const TimeOfDay(hour: 8, minute: 00),
          end: const TimeOfDay(hour: 9, minute: 0),
          classroom: '805',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 0),
          end: const TimeOfDay(hour: 15, minute: 0),
          classroom: '140',
        ),
      ],
    },
  ),
  Teacher(
    name: 'Mike Taylor',
    phoneNumber: '5551234567',
    campusNames: 'LNCT',
    departments: 'CSE',
    semester: '5th',
    section: 'C',
    profileImagePath: 'assets/mike_taylor.png',
    timetableImagePath: 'assets/timetable_jane_smith.png',
    availability: {
      'Monday': [
        TimeRange(
          start: const TimeOfDay(hour: 8, minute: 15),
          end: const TimeOfDay(hour: 9, minute: 0),
          classroom: '115',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 10, minute: 0),
          end: const TimeOfDay(hour: 12, minute: 0),
          classroom: '100',
        ),
      ],
      'Tuesday': [
        TimeRange(
          start: const TimeOfDay(hour: 9, minute: 0),
          end: const TimeOfDay(hour: 9, minute: 50),
          classroom: '177',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 0),
          end: const TimeOfDay(hour: 17, minute: 0),
          classroom: '555',
        ),
      ],
    },
  ),
  Teacher(
    name: 'Rahul Kumar',
    phoneNumber: ' +91 8873944597',
    campusNames: 'LNCT',
    departments: 'CSE',
    semester: '5th',
    section: 'B',
    profileImagePath: 'assets/mike_taylor.png',
    timetableImagePath: 'assets/timetable_jane_smith.png',
    availability: {
      'Monday': [
        TimeRange(
          start: const TimeOfDay(hour: 8, minute: 15),
          end: const TimeOfDay(hour: 9, minute: 0),
          classroom: '144',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 10, minute: 0),
          end: const TimeOfDay(hour: 12, minute: 0),
          classroom: '156',
        ),
      ],
      'Tuesday': [
        TimeRange(
          start: const TimeOfDay(hour: 9, minute: 0),
          end: const TimeOfDay(hour: 9, minute: 50),
          classroom: '177',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 0),
          end: const TimeOfDay(hour: 17, minute: 0),
          classroom: '555',
        ),
      ],
      'Wednesday': [
        TimeRange(
          start: const TimeOfDay(hour: 9, minute: 0),
          end: const TimeOfDay(hour: 9, minute: 50),
          classroom: '177',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 0),
          end: const TimeOfDay(hour: 17, minute: 0),
          classroom: '555',
        ),
      ],
    },
  ),
  Teacher(
    name: 'Dr.Bhavana Pillai',
    phoneNumber: '+91 9425302343',
    campusNames: 'LNCTS',
    departments: 'CSE',
    semester: '4th',
    section: 'A',
    profileImagePath: 'assets/bhavana_pillai.png',
    timetableImagePath: 'assets/bhavana_pillai_table.png',
    availability: {
      'Monday': [
        TimeRange(
          start: const TimeOfDay(hour: 11, minute: 20),
          end: const TimeOfDay(hour: 12, minute: 10),
          classroom: "New F-1",
        ),
        TimeRange(
          start: const TimeOfDay(hour: 15, minute: 30),
          end: const TimeOfDay(hour: 16, minute: 15),
          classroom: "New lab F-14",
        ),
        TimeRange(
          start: const TimeOfDay(hour: 16, minute: 15),
          end: const TimeOfDay(hour: 17, minute: 00),
          classroom: "New lab F-14",
        ),
      ],
      'Wednesday': [
        TimeRange(
          start: const TimeOfDay(hour: 10, minute: 30),
          end: const TimeOfDay(hour: 11, minute: 20),
          classroom: "F-1",
        ),
        TimeRange(
          start: const TimeOfDay(hour: 12, minute: 10),
          end: const TimeOfDay(hour: 13, minute: 00),
          classroom: 'New lab F-14',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 00),
          end: const TimeOfDay(hour: 13, minute: 50),
          classroom: 'New lab F-14',
        ),
      ],
      'Thursday': [
        TimeRange(
          start: const TimeOfDay(hour: 10, minute: 30),
          end: const TimeOfDay(hour: 11, minute: 20),
          classroom: 'New F-1',
        ),
      ],
      'Friday': [
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 00),
          end: const TimeOfDay(hour: 13, minute: 50),
          classroom: "New F-1",
        ),
      ],
    },
  ),
  Teacher(
    name: 'Prof.Deepika Basedia',
    phoneNumber: '+91 9893930710',
    campusNames: 'LNCTS',
    departments: 'CSE',
    semester: '4th',
    section: 'A',
    profileImagePath: 'assets/deepika_basedia.png',
    timetableImagePath: 'assets/deepika_basedia_table.png',
    availability: {
      'Monday': [
        TimeRange(
          start: const TimeOfDay(hour: 10, minute: 30),
          end: const TimeOfDay(hour: 11, minute: 20),
          classroom: "New F-1",
        ),
      ],
      'Tuesday': [
        TimeRange(
          start: const TimeOfDay(hour: 14, minute: 40),
          end: const TimeOfDay(hour: 15, minute: 30),
          classroom: 'New F-1',
        ),
      ],
      'Wednesday': [
        TimeRange(
          start: const TimeOfDay(hour: 15, minute: 30),
          end: const TimeOfDay(hour: 16, minute: 15),
          classroom: "F-1",
        ),
      ],
      'Thursday': [
        TimeRange(
          start: const TimeOfDay(hour: 14, minute: 40),
          end: const TimeOfDay(hour: 15, minute: 30),
          classroom: 'F-1',
        ),
      ],
      'Friday': [
        TimeRange(
          start: const TimeOfDay(hour: 16, minute: 15),
          end: const TimeOfDay(hour: 17, minute: 00),
          classroom: "New F-1",
        ),
      ],
    },
  ),
  Teacher(
    name: 'Prof.Vijendra Singh Palash',
    phoneNumber: '+91 9300205837',
    campusNames: 'LNCTS',
    departments: 'CSE',
    semester: '4th',
    section: 'A',
    profileImagePath: 'assets/vijendra_singh_palash.png',
    timetableImagePath: 'assets/vijendra_singh_palash_table.png',
    availability: {
      'Monday': [
        TimeRange(
          start: const TimeOfDay(hour: 12, minute: 10),
          end: const TimeOfDay(hour: 13, minute: 00),
          classroom: "F-1",
        ),
      ],
      'Tuesday': [
        TimeRange(
          start: const TimeOfDay(hour: 10, minute: 30),
          end: const TimeOfDay(hour: 11, minute: 20),
          classroom: "New F-1",
        ),
        TimeRange(
          start: const TimeOfDay(hour: 12, minute: 10),
          end: const TimeOfDay(hour: 13, minute: 00),
          classroom: "Old lab F-01",
        ),
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 00),
          end: const TimeOfDay(hour: 13, minute: 50),
          classroom: 'lab F-01',
        ),
      ],
      'Wednesday': [
        TimeRange(
          start: const TimeOfDay(hour: 14, minute: 40),
          end: const TimeOfDay(hour: 15, minute: 30),
          classroom: 'New F-1',
        ),
      ],
      'Thursday': [
        TimeRange(
          start: const TimeOfDay(hour: 12, minute: 10),
          end: const TimeOfDay(hour: 13, minute: 00),
          classroom: 'New F-1',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 15, minute: 30),
          end: const TimeOfDay(hour: 16, minute: 15),
          classroom: 'Old lab F-01',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 16, minute: 15),
          end: const TimeOfDay(hour: 17, minute: 00),
          classroom: 'Old lab F-01',
        ),
      ],
    },
  ),
  Teacher(
    name: 'Prof.Vinay Sahu',
    phoneNumber: '+91 9406767337',
    campusNames: 'LNCTS',
    departments: 'CSE',
    semester: '4th',
    section: 'A',
    profileImagePath: 'assets/vinay_sahu.png',
    timetableImagePath: 'assets/vinay_sahu_table.png',
    availability: {
      'Monday': [
        TimeRange(
          start: const TimeOfDay(hour: 14, minute: 40),
          end: const TimeOfDay(hour: 15, minute: 30),
          classroom: 'New F-1',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 15, minute: 30),
          end: const TimeOfDay(hour: 16, minute: 15),
          classroom: 'New lab F-13',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 16, minute: 15),
          end: const TimeOfDay(hour: 17, minute: 00),
          classroom: 'New lab F-13',
        ),
      ],
      'Wednesday': [
        TimeRange(
          start: const TimeOfDay(hour: 14, minute: 40),
          end: const TimeOfDay(hour: 15, minute: 30),
          classroom: 'New F-1',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 12, minute: 10),
          end: const TimeOfDay(hour: 13, minute: 00),
          classroom: 'New lab F-13',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 00),
          end: const TimeOfDay(hour: 13, minute: 50),
          classroom: "New lab F-13",
        ),
      ],
      'Thursday': [
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 00),
          end: const TimeOfDay(hour: 13, minute: 50),
          classroom: 'New F-1',
        ),
      ],
      'Friday': [
        TimeRange(
          start: const TimeOfDay(hour: 14, minute: 40),
          end: const TimeOfDay(hour: 15, minute: 30),
          classroom: "New F-1",
        ),
      ],
    },
  ),
  Teacher(
    name: 'Prof.Parag Sohani',
    phoneNumber: '+91 9981522201',
    campusNames: 'LNCTS',
    departments: 'CSE',
    semester: '4th',
    section: 'A',
    profileImagePath: 'assets/parag_sohani.png',
    timetableImagePath: 'assets/parag_sohani_table.png',
    availability: {
      'Monday': [
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 00),
          end: const TimeOfDay(hour: 13, minute: 50),
          classroom: "New F-1",
        ),
      ],
      'Tuesday': [
        TimeRange(
          start: const TimeOfDay(hour: 11, minute: 20),
          end: const TimeOfDay(hour: 12, minute: 10),
          classroom: "New F-1",
        ),
        TimeRange(
          start: const TimeOfDay(hour: 12, minute: 10),
          end: const TimeOfDay(hour: 13, minute: 00),
          classroom: "Old lab F-10 B",
        ),
        TimeRange(
          start: const TimeOfDay(hour: 13, minute: 00),
          end: const TimeOfDay(hour: 13, minute: 50),
          classroom: "Old lab F-10 B",
        ),
        TimeRange(
          start: const TimeOfDay(hour: 15, minute: 30),
          end: const TimeOfDay(hour: 16, minute: 15),
          classroom: 'Old lab F-09',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 16, minute: 15),
          end: const TimeOfDay(hour: 17, minute: 00),
          classroom: 'Old lab F-09',
        ),
      ],
      'Wednesday': [
        TimeRange(
          start: const TimeOfDay(hour: 11, minute: 20),
          end: const TimeOfDay(hour: 12, minute: 10),
          classroom: "New F-1",
        ),
      ],
      'Thursday': [
        TimeRange(
          start: const TimeOfDay(hour: 15, minute: 30),
          end: const TimeOfDay(hour: 16, minute: 15),
          classroom: 'Old lab F-10 (B)',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 16, minute: 15),
          end: const TimeOfDay(hour: 17, minute: 00),
          classroom: 'Old lab F-10 (B)',
        ),
      ],
      'Friday': [
        TimeRange(
          start: const TimeOfDay(hour: 10, minute: 30),
          end: const TimeOfDay(hour: 11, minute: 20),
          classroom: "Old F-09",
        ),
        TimeRange(
          start: const TimeOfDay(hour: 11, minute: 20),
          end: const TimeOfDay(hour: 12, minute: 10),
          classroom: 'Old F-09',
        ),
        TimeRange(
          start: const TimeOfDay(hour: 12, minute: 10),
          end: const TimeOfDay(hour: 13, minute: 00),
          classroom: "New F-1",
        ),
      ],
    },
  ),
  Teacher(
    name: 'Prof.Charu Dua',
    phoneNumber: '+91 7738535300',
    campusNames: 'LNCTS',
    departments: 'CSE',
    semester: '4th',
    section: 'A',
    profileImagePath: 'assets/charu_dua.png',
    timetableImagePath: 'assets/charu_dua_table.png',
    availability: {
      'Thursday': [
        TimeRange(
          start: const TimeOfDay(hour: 11, minute: 20),
          end: const TimeOfDay(hour: 12, minute: 10),
          classroom: "New F-1",
        ),
      ],
      'Friday': [
        TimeRange(
          start: const TimeOfDay(hour: 15, minute: 30),
          end: const TimeOfDay(hour: 16, minute: 15),
          classroom: 'New F-1',
        ),
      ],
    },
  ),
];

// Function to get available teachers at a given time and day
List<Teacher> getAvailableTeachers(String day, TimeOfDay currentTime) {
  List<Teacher> availableTeachers = [];
  for (var teacher in teachers) {
    if (teacher.availability.containsKey(day)) {
      bool isAvailable = false;
      for (var range in teacher.availability[day]!) {
        if (isTimeInRange(currentTime, range)) {
          isAvailable = true;
          break;
        }
      }
      if (isAvailable) {
        availableTeachers.add(teacher);
      }
    }
  }
  return availableTeachers;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutor Tracer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(
        nextScreen: TeacherAvailabilityScreen(),
      ),
    );
  }
}

class TeacherAvailabilityScreen extends StatefulWidget {
  const TeacherAvailabilityScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TeacherAvailabilityScreenState createState() =>
      _TeacherAvailabilityScreenState();
}

class _TeacherAvailabilityScreenState extends State<TeacherAvailabilityScreen> {
  late TimeOfDay _currentTime = TimeOfDay.now();
  late String _selectedDay = 'Monday';
  late List<Teacher> _availableTeachers = [];
  bool _isAvailable = true;
  late String selectedCampus = '';
  late String selectedDepartment = '';
  late String selectedSemester = '';
  late String selectedSection = '';

  void _updateAvailableTeachers() {
    setState(() {
      _availableTeachers = getAvailableTeachers(_selectedDay, _currentTime);
      _isAvailable = _availableTeachers.isNotEmpty;
    });
  }

  void sortTeachersByCampus(String campus) {
    setState(() {
      selectedCampus = campus;
      if (selectedDepartment.isNotEmpty) {
        _availableTeachers = teachers
            .where((teacher) =>
                teacher.campusNames == selectedCampus &&
                teacher.departments == selectedDepartment)
            .toList();
      } else {
        _availableTeachers = teachers
            .where((teacher) => teacher.campusNames == selectedCampus)
            .toList();
      }
    });
  }

  void sortTeachersByDepartment(String department) {
    setState(() {
      selectedDepartment = department;
      if (selectedCampus.isNotEmpty) {
        _availableTeachers = teachers
            .where((teacher) =>
                teacher.departments == selectedDepartment &&
                teacher.campusNames == selectedCampus)
            .toList();
      } else {
        _availableTeachers = teachers
            .where((teacher) => teacher.departments == selectedDepartment)
            .toList();
      }
    });
  }

  void sortTeachersBySemester(String semester) {
    setState(() {
      selectedSemester = semester;
      if (selectedCampus.isNotEmpty && selectedDepartment.isNotEmpty) {
        _availableTeachers = teachers
            .where((teacher) =>
                teacher.departments == selectedDepartment &&
                teacher.campusNames == selectedCampus &&
                teacher.semester == selectedSemester)
            .toList();
      } else {
        _availableTeachers = teachers
            .where((teacher) => teacher.semester == selectedSemester)
            .toList();
      }
    });
  }

  void _sortTeachersBysection(String section) {
    setState(() {
      selectedSection = section;
      if (selectedCampus.isNotEmpty &&
          selectedDepartment.isNotEmpty &&
          selectedSemester.isNotEmpty) {
        _availableTeachers = teachers
            .where((teacher) =>
                teacher.departments == selectedDepartment &&
                teacher.campusNames == selectedCampus &&
                teacher.semester == selectedSemester)
            .toList();
      } else {
        _availableTeachers = teachers
            .where((teacher) => teacher.section == selectedSection)
            .toList();
      }
    });
  }

  // Function to get available teachers at a given time and day
  List<Teacher> getAvailableTeachers(String day, TimeOfDay currentTime) {
    List<Teacher> availableTeachers = [];
    for (var teacher in teachers) {
      if (teacher.availability.containsKey(day)) {
        bool isAvailable = false;
        for (var range in teacher.availability[day]!) {
          if (isTimeInRange(currentTime, range)) {
            isAvailable = true;
            break;
          }
        }
        if (isAvailable) {
          availableTeachers.add(teacher);
        }
      }
    }
    return availableTeachers;
  }

// Function to get the classroom of a teacher at a given time and day
  String getClassroomForTeacher(
      Teacher teacher, String day, TimeOfDay currentTime) {
    if (teacher.availability.containsKey(day)) {
      for (var range in teacher.availability[day]!) {
        if (isTimeInRange(currentTime, range)) {
          return range.classroom;
        }
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor Tracer'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('About Tutor Tracer'),
                  content: const Text(
                      'Tutor Tracer is an app designed to help teachers to find available teachers for assigning them task or work and also students can find faculty. \n \n Developed by Mayur Vishwakarma  \n \n Contact :  7987660323'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.info),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchTeacherScreen(
                        teachersList: TeachersList(teachers: teachers))),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            color: Colors.redAccent,
            onPressed: () {
              // Handle More action
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Tutor Tracer',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('About Tutor Tracer'),
                    content: const Text(
                        'Tutor Tracer is an app designed to help teachers to find available teachers for assigning them task or work and also students can find faculty.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Suggest'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ModeScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Lectures Timing'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Lectures Timing'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView(
                        shrinkWrap: true,
                        children: const [
                          ListTile(title: Text('Lecture 1: 09:00 - 09:50')),
                          ListTile(title: Text('Lecture 2: 10:00 - 10:50')),
                          ListTile(title: Text('Lecture 3: 11:00 - 11:50')),
                          ListTile(title: Text('Lecture 4: 12:00 - 12:50')),
                          ListTile(title: Text('Lecture 5: 13:00 - 13:50')),
                          ListTile(title: Text('Lecture 6: 14:00 - 14:50')),
                          ListTile(title: Text('Lecture 7: 15:00 - 15:50')),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Copyright'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Copyright'),
                    content:
                        const Text('© 2024 Tutor Tracer. All rights reserved.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Select Day and Time:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton<String>(
                    value: _selectedDay,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDay = newValue!;
                        _updateAvailableTeachers();
                      });
                    },
                    items: <String>[
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: _currentTime,
                      );
                      if (picked != null && picked != _currentTime) {
                        setState(() {
                          _currentTime = picked;
                          _updateAvailableTeachers();
                        });
                      }
                    },
                    child: const Text(
                      'Select Time',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  // In your main screen
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DurationScreen()),
                      );
                    },
                    child: const Text('Duration'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _isAvailable ? 'Available Teachers:' : 'Teacher is unavailable',
                style: const TextStyle(fontSize: 20),
              ),
              Expanded(
                child: _isAvailable
                    ? ListView.builder(
                        itemCount: _availableTeachers.length,
                        itemBuilder: (context, index) {
                          final teacher = _availableTeachers[index];
                          final classroom = getClassroomForTeacher(teacher, _selectedDay, _currentTime);
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage(teacher.profileImagePath),
                                radius: 25,
                              ),
                              title: Text(
                                teacher.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Campus: ${teacher.campusNames}'),
                                  Text('Department: ${teacher.departments}'),
                                  Text('Classroom: ${classroom}'),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'call') {
                                    launchUrl(Uri.parse(
                                        'tel:${teacher.phoneNumber}'));
                                  } else if (value == 'whatsapp') {
                                    launchUrl(Uri.parse(
                                        'https://wa.me/${teacher.phoneNumber}'));
                                  } else if (value == 'sms') {
                                    launchUrl(Uri.parse(
                                        'sms:${teacher.phoneNumber}'));
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem(
                                      value: 'call',
                                      child: ListTile(
                                        leading: Icon(Icons.call),
                                        title: Text('Call'),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'whatsapp',
                                      child: ListTile(
                                        leading: Icon(Icons.message),
                                        title: Text('Send WhatsApp Message'),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'sms',
                                      child: ListTile(
                                        leading: Icon(Icons.sms),
                                        title: Text('Send SMS'),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            ),
                          );
                        },
                      )
                    : const Text(
                        'No teachers available at this time.',
                        style: TextStyle(fontSize: 20),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          // Handle navigation
          if (index == 0) {
            // Navigate to home screen
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TeacherAvailabilityScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchTeacherScreen(
                  teachersList: TeachersList(teachers: teachers),
                ),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MoreScreen()),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      children: [
                        const ListTile(
                          title: Text('Sort By:'),
                          textColor: Color.fromARGB(255, 231, 9, 9),
                        ),
                        ListTile(
                          title: const Text('Campus'),
                          onTap: () {
                            setState(() {
                              selectedCampus = '';
                            });
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        title: const Text('LNCT'),
                                        onTap: () {
                                          setState(() {
                                            sortTeachersByCampus('LNCT');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('LNCTS'),
                                        onTap: () {
                                          setState(() {
                                            sortTeachersByCampus('LNCTS');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('LNCTE'),
                                        onTap: () {
                                          setState(() {
                                            sortTeachersByCampus('LNCTE');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Department'),
                          onTap: () {
                            setState(() {
                              selectedDepartment = '';
                            });
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        title: const Text('CSE'),
                                        onTap: () {
                                          setState(() {
                                            sortTeachersByDepartment('CSE');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('ECE'),
                                        onTap: () {
                                          setState(() {
                                            sortTeachersByDepartment('ECE');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('IOT'),
                                        onTap: () {
                                          setState(() {
                                            sortTeachersByDepartment('IOT');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Semester'),
                          onTap: () {
                            setState(() {
                              selectedSemester = '';
                            });
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        title: const Text('4th'),
                                        onTap: () {
                                          setState(() {
                                            sortTeachersBySemester('4th');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('5th'),
                                        onTap: () {
                                          setState(() {
                                            sortTeachersBySemester('5th');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('6th'),
                                        onTap: () {
                                          setState(() {
                                            sortTeachersBySemester('6th');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Section'),
                          onTap: () {
                            setState(() {
                              selectedSection = '';
                            });
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        title: const Text('A'),
                                        onTap: () {
                                          setState(() {
                                            _sortTeachersBysection('A');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('B'),
                                        onTap: () {
                                          setState(() {
                                            _sortTeachersBysection('B');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('C'),
                                        onTap: () {
                                          setState(() {
                                            _sortTeachersBysection('C');
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.sort),
      ),
    );
  }
}

class SearchTeacherScreen extends StatefulWidget {
  final TeachersList teachersList;

  const SearchTeacherScreen({super.key, required this.teachersList});

  @override
  // ignore: library_private_types_in_public_api
  _SearchTeacherScreenState createState() => _SearchTeacherScreenState();
}

class _SearchTeacherScreenState extends State<SearchTeacherScreen> {
  late List<Teacher> _filteredTeachers;
  Teacher? _selectedTeacher; // Initialize selected teacher to null

  @override
  void initState() {
    super.initState();
    _filteredTeachers = widget.teachersList.teachers;
  }

  void _filterTeachers(String query) {
    setState(() {
      _filteredTeachers = widget.teachersList.teachers
          .where((teacher) =>
              teacher.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _sendMessage(String phoneNumber) {
    TextEditingController messageController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send Message to ${_selectedTeacher!.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  labelText: 'Enter your message',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _launchURL(phoneNumber, messageController.text);
                Navigator.pop(context);
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _launchURL(String phoneNumber, String message) async {
    // Check if WhatsApp is installed
    // ignore: deprecated_member_use
    bool isWhatsAppInstalled =
        // ignore: deprecated_member_use
        await canLaunch("whatsapp://send?phone=$phoneNumber");

    if (isWhatsAppInstalled) {
      // If WhatsApp is installed, open WhatsApp
      String url =
          "whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}";
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      // If WhatsApp is not installed, open SMS
      String url = "sms:$phoneNumber?body=$message";
      // ignore: deprecated_member_use
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Teachers'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search by teacher name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _filterTeachers,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTeachers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(_filteredTeachers[index].name),
                      subtitle: Text(
                          'Campus: ${_filteredTeachers[index].campusNames}, Department: ${_filteredTeachers[index].departments}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedTeacher = _filteredTeachers[index];
                          });
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(_filteredTeachers[index].name),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Campus: ${_filteredTeachers[index].campusNames}'),
                                  Text(
                                      'Department: ${_filteredTeachers[index].departments}'),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 300,
                                    width: 400,
                                    child: InteractiveViewer(
                                      boundaryMargin:
                                          const EdgeInsets.all(20.0),
                                      minScale: 0.1,
                                      maxScale: 4.0,
                                      child: Image.asset(
                                          _filteredTeachers[index]
                                              .timetableImagePath),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _sendMessage(
                                        _filteredTeachers[index].phoneNumber);
                                  },
                                  child: const Text('Assign Task'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('View'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
