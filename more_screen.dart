import 'package:flutter/material.dart';

class TimeRange {
  final String lecture;
  final TimeOfDay start;
  final TimeOfDay end;

  TimeRange({required this.lecture, required this.start, required this.end});
}

class Teacher {
  final String name;
  final String department;
  final String campus;
  final Map<String, List<TimeRange>> availability;
  final Map<String, List<TimeRange>> unavailability;

  Teacher({
    required this.name,
    required this.department,
    required this.campus,
    required this.availability,
    required this.unavailability,
  });

  static List<Teacher> getDummyTeachers() {
    return [
      Teacher(
        name: 'John Doe',
        department: 'Math',
        campus: 'Campus A',
        availability: {
          'Monday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
            createTimeRange('Lecture 7', 15, 0, 15, 50),
          ],
          'Tuesday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
          'Wednesday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
        },
        unavailability: {
          'Monday': [
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
          ],
          'Tuesday': [
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
          ],
          'Wednesday': [
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 7', 15, 0, 15, 50),
          ],
        },
      ),
      Teacher(
        name: 'Jane Smith',
        department: 'Science',
        campus: 'Campus B',
        availability: {
          'Monday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
          'Tuesday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
          ],
          'Wednesday': [
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
        },
        unavailability: {
          'Monday': [
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
          ],
          'Tuesday': [
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
          'Wednesday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 7', 15, 0, 15, 50),
          ],
        },
      ),
      Teacher(
        name: 'Alice Johnson',
        department: 'Math',
        campus: 'Campus A',
        availability: {
          'Monday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
            createTimeRange('Lecture 7', 15, 0, 15, 50),
          ],
          'Tuesday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
          'Wednesday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
        },
        unavailability: {
          'Monday': [
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 7', 15, 0, 15, 50),
          ],
          'Tuesday': [
            createTimeRange('Lecture 5', 13, 0, 13, 50),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
          'Wednesday': [
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
          ],
        },
      ),
      Teacher(
        name: 'Pane Kooker',
        department: 'Math',
        campus: 'Campus A',
        availability: {
          'Monday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
          ],
          'Tuesday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
          'Wednesday': [
            createTimeRange('Lecture 1', 9, 0, 9, 50),
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
            createTimeRange('Lecture 6', 14, 0, 14, 50),
          ],
        },
        unavailability: {
          'Monday': [
            createTimeRange('Lecture 6', 14, 0, 14, 50),
            createTimeRange('Lecture 7', 15, 0, 15, 50),
          ],
          'Tuesday': [
            createTimeRange('Lecture 3', 10, 40, 11, 30),
            createTimeRange('Lecture 5', 13, 0, 13, 50),
          ],
          'Wednesday': [
            createTimeRange('Lecture 2', 9, 50, 10, 40),
            createTimeRange('Lecture 4', 12, 0, 12, 50),
          ],
        },
      ),
    ];
  }

  static TimeRange createTimeRange(String lecture, int startHour,
      int startMinute, int endHour, int endMinute) {
    return TimeRange(
      lecture: lecture,
      start: TimeOfDay(hour: startHour, minute: startMinute),
      end: TimeOfDay(hour: endHour, minute: endMinute),
    );
  }
}

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  Teacher? _selectedTeacher;
  List<Teacher> _filteredTeachers = [];
  late final List<Teacher> _teachersList = Teacher.getDummyTeachers();

  @override
  void initState() {
    super.initState();
    _filteredTeachers = _teachersList;
    _searchController.addListener(() {
      _filterTeachers(_searchController.text);
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  void _filterTeachers(String query) {
    setState(() {
      _filteredTeachers = _teachersList
          .where((teacher) =>
              teacher.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _selectTeacher(Teacher teacher) {
    setState(() {
      _selectedTeacher = teacher;
    });
    Navigator.of(context).pop();
  }

  void _showTeacherSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search teachers',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTeachers.length,
                itemBuilder: (context, index) {
                  final teacher = _filteredTeachers[index];
                  return ListTile(
                    title: Text(teacher.name),
                    subtitle: Text('${teacher.department}, ${teacher.campus}'),
                    onTap: () => _selectTeacher(teacher),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  List<Teacher> _findReplacementTeachers(
      Teacher selectedTeacher, String day, TimeRange lectureTime) {
    List<Teacher> replacements = [];

    for (var teacher in _teachersList) {
      if (teacher.name != selectedTeacher.name &&
          teacher.department == selectedTeacher.department &&
          teacher.campus == selectedTeacher.campus &&
          teacher.availability[day]?.any((timeRange) =>
                  timeRange.start == lectureTime.start &&
                  timeRange.end == lectureTime.end) ==
              true) {
        replacements.add(teacher);
      }
    }

    return replacements;
  }

  void _scheduleHoliday() {
    if (_selectedTeacher != null && (_startDate != null && _endDate != null)) {
      List<Map<String, dynamic>> replacementSchedule = [];
      DateTime currentDay = _startDate!;

      while (currentDay.isBefore(_endDate!) ||
          currentDay.isAtSameMomentAs(_endDate!)) {
        String dayName = _getDayName(currentDay.weekday);
        if (_selectedTeacher!.availability.containsKey(dayName)) {
          for (var lecture in _selectedTeacher!.availability[dayName]!) {
            List<Teacher> replacements =
                _findReplacementTeachers(_selectedTeacher!, dayName, lecture);
            if (replacements.isNotEmpty) {
              replacementSchedule.add({
                'date': currentDay.toLocal().toShortDateString(),
                'lecture': lecture.lecture,
                'replacements': replacements
              });
            }
          }
        }
        if (_selectedTeacher!.unavailability.containsKey(dayName)) {
          for (var lecture in _selectedTeacher!.unavailability[dayName]!) {
            List<Teacher> replacements =
                _findReplacementTeachers(_selectedTeacher!, dayName, lecture);
            if (replacements.isNotEmpty) {
              replacementSchedule.add({
                'date': currentDay.toLocal().toShortDateString(),
                'lecture': lecture.lecture,
                'replacements': replacements
              });
            }
          }
        }
        currentDay = currentDay.add(const Duration(days: 1));
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ReplacementScheduleScreen(schedule: replacementSchedule),
        ),
      );
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  void _generateReplacementSchedule() {
    if (_selectedTeacher == null || _startDate == null || _endDate == null) {
      return;
    }

    Map<String, Map<String, List<Map<String, dynamic>>>> schedule = {};

    // Initialize the schedule with empty lists
    for (int i = 1; i <= 9; i++) {
      String lecture = 'Lecture $i';
      schedule[lecture] = {};

      DateTime currentDate = _startDate!;
      while (currentDate.isBefore(_endDate!) ||
          currentDate.isAtSameMomentAs(_endDate!)) {
        schedule[lecture]?[currentDate.toIso8601String().substring(0, 10)] = [];
        currentDate = currentDate.add(const Duration(days: 1));
      }
    }

    // Populate the schedule with available teachers
    for (var teacher in _teachersList) {
      // Only consider teachers that match the department and campus of the selected teacher
      if (teacher.department == _selectedTeacher!.department &&
          teacher.campus == _selectedTeacher!.campus) {
        teacher.availability.forEach((day, timeRanges) {
          for (var timeRange in timeRanges) {
            if (schedule.containsKey(timeRange.lecture)) {
              DateTime currentDate = _startDate!;
              while (currentDate.isBefore(_endDate!) ||
                  currentDate.isAtSameMomentAs(_endDate!)) {
                if (_getDayName(currentDate.weekday) == day) {
                  schedule[timeRange.lecture]
                          ?[currentDate.toIso8601String().substring(0, 10)]
                      ?.add({
                    'name': teacher.name,
                    'department': teacher.department,
                    'campus': teacher.campus,
                  });
                }
                currentDate = currentDate.add(const Duration(days: 1));
              }
            }
          }
        });
      }
    }

    // Create DataRows for the DataTable
    List<DataRow> rows = [];
    schedule.forEach((lecture, dates) {
      List<DataCell> cells = [DataCell(Text(lecture))];
      DateTime currentDate = _startDate!;
      while (currentDate.isBefore(_endDate!) ||
          currentDate.isAtSameMomentAs(_endDate!)) {
        String dateKey = currentDate.toIso8601String().substring(0, 10);
        List<Map<String, dynamic>> teachers = dates[dateKey]!;

        // Create a list of cards for each teacher
        List<Widget> teacherCards = teachers
            .map((teacher) => _buildTeacherCard(
                teacher['name'], teacher['department'], teacher['campus']))
            .toList();

        // Wrap cards in a Row for horizontal display
        cells.add(DataCell(
          Container(
            constraints: const BoxConstraints(minHeight: 100),
            child: Row(
              children:
                  teacherCards.map((card) => Expanded(child: card)).toList(),
            ),
          ),
        ));
        currentDate = currentDate.add(const Duration(days: 1));
      }
      rows.add(DataRow(cells: cells));
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DataTableScreen(
          rows: rows,
          startDate: _startDate!,
          endDate: _endDate!,
        ),
      ),
    );
  }

  Widget _buildTeacherCard(
      String teacherName, String department, String campus) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:
              MainAxisSize.min, // Ensure the Column takes minimum space
          children: [
            Text(
              teacherName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4), // Small gap between name and details
            Text(
              'Department: $department',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Campus: $campus',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Holiday Page'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showTeacherSelection,
              child: Text(_selectedTeacher == null
                  ? 'Select Teacher'
                  : 'Selected Teacher: ${_selectedTeacher!.name}'),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDateRange(context),
                    child: Text(_startDate == null || _endDate == null
                        ? 'Select Duration'
                        : '${_startDate!.toLocal().toShortDateString()} - ${_endDate!.toLocal().toShortDateString()}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _scheduleHoliday,
              child: const Text('Schedule Holiday'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _generateReplacementSchedule,
              child: const Text('Generate Replacement Schedule'),
            ),
          ],
        ),
      ),
    );
  }

  // Other methods...
}

class ReplacementScheduleScreen extends StatelessWidget {
  final List<Map<String, dynamic>> schedule;

  const ReplacementScheduleScreen({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Replacement Schedule'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final item = schedule[index];
          return ListTile(
            title: Text('${item['date']} - ${item['lecture']}'),
            subtitle: Text(
                'Available Replacements: ${item['replacements'].join(', ')}'),
          );
        },
      ),
    );
  }
}

class DataTableScreen extends StatefulWidget {
  final List<DataRow> rows;
  final DateTime startDate;
  final DateTime endDate;

  const DataTableScreen({
    super.key,
    required this.rows,
    required this.startDate,
    required this.endDate,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DataTableScreenState createState() => _DataTableScreenState();
}

class _DataTableScreenState extends State<DataTableScreen> {
  bool editMode = false;
  List<DataRow> selectedRows = [];
  String? selectedCampus;
  String? selectedDepartment;

  void _toggleEditMode() {
    setState(() {
      editMode = !editMode;
      if (!editMode) {
        selectedRows.clear();
      }
    });
  }

  void _handleDeleteSelected() {
    setState(() {
      widget.rows.removeWhere((row) => selectedRows.contains(row));
      selectedRows.clear();
    });
  }

  void _toggleRowSelection(DataRow row) {
    setState(() {
      if (selectedRows.contains(row)) {
        selectedRows.remove(row);
      } else {
        selectedRows.add(row);
      }
    });
  }

  List<DataColumn> generateColumns() {
    List<DataColumn> columns = [
      const DataColumn(label: Text('Lecture')),
    ];

    DateTime currentDate = widget.startDate;
    while (currentDate.isBefore(widget.endDate) ||
        currentDate.isAtSameMomentAs(widget.endDate)) {
      columns.add(DataColumn(
          label: Text(currentDate.toIso8601String().substring(0, 10))));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Replacement Schedule DataTable'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(editMode ? Icons.check : Icons.edit),
            onPressed: _toggleEditMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            // ignore: deprecated_member_use
            dataRowHeight: 100, // Set your desired row height here
            columns: generateColumns(),
            rows: widget.rows.map((row) {
              final isSelected = selectedRows.contains(row);
              return DataRow(
                selected: isSelected,
                onSelectChanged:
                    editMode ? (isSelected) => _toggleRowSelection(row) : null,
                cells: row.cells,
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: editMode && selectedRows.isNotEmpty
          ? FloatingActionButton(
              onPressed: _handleDeleteSelected,
              tooltip: 'Delete Selected',
              backgroundColor: Colors.red,
              child: const Icon(Icons.delete),
            )
          : null,
    );
  }
}

extension DateHelpers on DateTime {
  String toShortDateString() {
    // ignore: unnecessary_this
    return "${this.year}-${this.month.toString().padLeft(2, '0')}-${this.day.toString().padLeft(2, '0')}";
  }
}
