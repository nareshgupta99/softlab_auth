import 'package:flutter/material.dart';

class StateDropdown extends StatefulWidget {
  final List<String> states;
  final Function(String?) onchanged;
  final String? selected;

  const StateDropdown({super.key, required this.states, required this.onchanged, this.selected});

  @override
  State<StateDropdown> createState() => _StateDropdownState();
}

class _StateDropdownState extends State<StateDropdown> {
  static const kBgField = Color(0xFFF2F2F0);
  static const kTextLight = Color(0xFFAAAAAA);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(color: kBgField, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selected,
          hint: const Text('State', style: TextStyle(color: kTextLight, fontSize: 15)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: kTextLight),
          items: widget.states.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          onChanged: widget.onchanged,
        ),
      ),
    );
  }
}
