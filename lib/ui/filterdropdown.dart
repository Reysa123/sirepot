import 'package:flutter/material.dart';

class FilterDropdown extends StatefulWidget {
  final String label;
  final String? initialValue;
  final List<String> list;
  final Function(String?) onKlik;

  const FilterDropdown({
    super.key,
    required this.label,
    this.initialValue,
    required this.list,
    required this.onKlik,
  });

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    // Inisialisasi nilai dari parameter
    _selectedValue = (widget.initialValue == "null") ? null : widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 135,
      child: DropdownButtonFormField<String>(
        value: _selectedValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          labelText: widget.label,
          labelStyle: const TextStyle(fontSize: 11, color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          // Menggunakan suffixIcon di InputDecoration agar muncul di dalam box
          suffixIcon: _selectedValue != null
              ? IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.clear, color: Colors.red, size: 18),
                  onPressed: () {
                    setState(() {
                      _selectedValue = null;
                    });
                    widget.onKlik(null);
                  },
                )
              : null,
        ),
        style: const TextStyle(fontSize: 11, color: Colors.black),
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.green,
          size: 20,
        ),
        items: widget.list.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(fontSize: 11)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
          widget.onKlik(newValue);
        },
      ),
    );
  }
}
