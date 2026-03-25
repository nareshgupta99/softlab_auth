import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:softlab_auth/components/app_bar.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/features/auth/auth_controller.dart';

class RegisterStep4 extends StatefulWidget {
  const RegisterStep4({super.key});

  @override
  State<RegisterStep4> createState() => _RegisterStep4State();
}

class _RegisterStep4State extends State<RegisterStep4> {
  // ── Constants ──────────────────────────────────────────────
  static const kSubtitle = Color(0xFF888888);
  static const kTextDark = Color(0xFF1A1A1A);
  static const kBgField = Color(0xFFF2F2F0);
  static const kPrimary = Color(0xFFCD6B5A);
  static const kSlotActive = Color(0xFFF4C878);
  static const kSlotActiveText = Color(0xFF7A5500);

  final List<String> _days = ['M', 'T', 'W', 'Th', 'F', 'S', 'Su'];

  final List<String> _slots = ['8:00am - 10:00am', '10:00am - 1:00pm', '1:00pm - 4:00pm', '4:00pm - 7:00pm', '7:00pm - 10:00pm'];

  final Map<int, Set<int>> _schedule = {};

  int _selectedDay = 0;

  AuthController authController = Get.find<AuthController>();

  Set<int> get _currentSlots => _schedule[_selectedDay] ?? {};

  void _toggleSlot(int slotIndex) {
    setState(() {
      _schedule.putIfAbsent(_selectedDay, () => {});
      if (_schedule[_selectedDay]!.contains(slotIndex)) {
        _schedule[_selectedDay]!.remove(slotIndex);

        if (_schedule[_selectedDay]!.isEmpty) {
          _schedule.remove(_selectedDay);
        }
      } else {
        _schedule[_selectedDay]!.add(slotIndex);
      }
    });
  }

  bool _dayHasSlots(int dayIndex) => _schedule.containsKey(dayIndex) && _schedule[dayIndex]!.isNotEmpty;

  Map<String, List<String>> get _readableSchedule {
    return _schedule.map((dayIndex, slots) {
      return MapEntry(_days[dayIndex], slots.map((i) => _slots[i]).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FarmerEatsAppBar(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.arrow_back, color: kTextDark), onPressed: () => Navigator.pop(context)),
              Expanded(
                child: customButton(
                  onPressed: () {
                    // Pass schedule to controller before navigating
                    authController.businessHours.value = _readableSchedule;
                    authController.registerWithValidation(4, context);
                  },
                  text: 'Submit',
                  color: kPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text("Signup 4 of 4", style: TextStyle(color: kSubtitle, fontSize: 13.sp, fontWeight: FontWeight.w400)),
              const SizedBox(height: 4),
              const Text("Business Hours", style: TextStyle(color: kTextDark, fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
              const SizedBox(height: 10),
              const Text(
                'Choose the hours your farm is open for pickups.\nThis will allow customers to order deliveries.',
                style: TextStyle(color: kSubtitle, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 28),

              // ── Day selector ─────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_days.length, (i) {
                  final isSelected = i == _selectedDay;
                  final hasSlots = _dayHasSlots(i);

                  return GestureDetector(
                    onTap: () => setState(() => _selectedDay = i),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected ? kPrimary : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              // highlight days that have slots even when not active
                              color:
                                  isSelected
                                      ? kPrimary
                                      : hasSlots
                                      ? kPrimary.withOpacity(0.4)
                                      : const Color(0xFFDDDDDD),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _days[i],
                              style: TextStyle(color: isSelected ? Colors.white : kTextDark, fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ),
                        ),

                        // ── Orange dot = day has slots selected ──
                        if (hasSlots)
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: kSlotActive, shape: BoxShape.circle)),
                          ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 8),

              // ── Selected day label ────────────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Align(
                  key: ValueKey(_selectedDay),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _currentSlots.isEmpty
                        ? 'No slots selected for ${_days[_selectedDay]}'
                        : '${_currentSlots.length} slot${_currentSlots.length > 1 ? 's' : ''} selected for ${_days[_selectedDay]}',
                    style: TextStyle(color: _currentSlots.isEmpty ? kSubtitle : kPrimary, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Time slots grid ───────────────────────────────
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(_slots.length, (i) {
                  final isSelected = _currentSlots.contains(i);
                  return GestureDetector(
                    onTap: () => _toggleSlot(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      width: (MediaQuery.of(context).size.width - 48 - 12) / 2,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected ? kSlotActive : kBgField,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? kSlotActive : Colors.transparent, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          _slots[i],
                          style: TextStyle(color: isSelected ? kSlotActiveText : kTextDark, fontWeight: FontWeight.w500, fontSize: 13.5),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              // ── Summary chips ─────────────────────────────────
              if (_schedule.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text('Your schedule', style: TextStyle(color: kTextDark, fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children:
                      _schedule.entries.map((entry) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: kPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            '${_days[entry.key]}: ${entry.value.length} slot${entry.value.length > 1 ? 's' : ''}',
                            style: const TextStyle(color: kPrimary, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList(),
                ),
              ],

              const Spacer(),

              // ── Bottom bar ────────────────────────────────────
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
