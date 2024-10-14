import 'package:comp3330_project/providers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmCard extends StatefulWidget {
  final String facilityId;
  final String title;

  const AlarmCard({
    super.key,
    required this.facilityId,
    required this.title,
  });

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  List<String> _selectedDays = [];
  bool _isSettingAlarm = false;

  final List<String> _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  @override
  void initState() {
    super.initState();
    _loadAlarmData();
  }

  void _loadAlarmData() {
    final prefsProvider =
        Provider.of<SharedPreferencesProvider>(context, listen: false);

    _startTime = prefsProvider.getStartTime(widget.facilityId);
    _endTime = prefsProvider.getEndTime(widget.facilityId);
    _selectedDays = prefsProvider.getAlarmDays(widget.facilityId);

    _isSettingAlarm =
        _startTime != null || _endTime != null || _selectedDays.isNotEmpty;
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
  }

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _saveAlarm() async {
    final prefsProvider =
        Provider.of<SharedPreferencesProvider>(context, listen: false);

    await prefsProvider.setAlarmData(
      widget.facilityId,
      _startTime,
      _endTime,
      _selectedDays,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _isSettingAlarm
                ? _buildAlarmSelector(context)
                : _buildSetAlarmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSetAlarmButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          setState(() {
            _isSettingAlarm = true;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Set Alarm',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlarmSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Start Time: ',
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                _selectTime(context, true);
              },
              child: Text(
                _startTime != null
                    ? _startTime!.format(context)
                    : 'Select Start Time',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'End Time: ',
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                _selectTime(context, false);
              },
              child: Text(
                _endTime != null
                    ? _endTime!.format(context)
                    : 'Select End Time',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: _weekdays.map((day) {
            final isSelected = _selectedDays.contains(day);
            return ChoiceChip(
              label: Text(
                day,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selectedColor: Colors.blue,
              backgroundColor: Colors.grey[300],
              selected: isSelected,
              onSelected: (_) {
                _toggleDay(day);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: _saveAlarm,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Save Alarm',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
