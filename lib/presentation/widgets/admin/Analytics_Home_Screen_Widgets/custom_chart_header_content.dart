import 'package:flutter/material.dart';

class CustomChartHeaderContent extends StatefulWidget {
  CustomChartHeaderContent({
    super.key,
    required this.availableYears,
    required this.selectedYear,
    required this.showWeekly,
    required this.onYearChanged,
    required this.onShowWeeklyChanged,
  });

  final List<int> availableYears;
  int selectedYear;
  bool showWeekly;
  final ValueChanged<int> onYearChanged;
  final ValueChanged<bool> onShowWeeklyChanged;

  @override
  State<CustomChartHeaderContent> createState() =>
      _CustomChartHeaderContentState();
}

class _CustomChartHeaderContentState extends State<CustomChartHeaderContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.showWeekly
                ? 'Weekly Sales Analytics'
                : 'Yearly Sales Analytics (${widget.selectedYear})',
            style: TextStyle(
              color: Color.fromARGB(255, 165, 101, 56),
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!widget.showWeekly)
                  DropdownButton<int>(
                    dropdownColor: Colors.brown.shade50,
                    borderRadius: BorderRadius.circular(8),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 165, 101, 56),
                    ),
                    iconSize: 32,
                    underline: const SizedBox(),
                    isExpanded: false,
                    focusColor: Colors.brown.shade50,
                    focusNode: FocusNode(),
                    alignment: Alignment.center,
                    value: widget.selectedYear,
                    items: widget.availableYears
                        .map(
                          (year) => DropdownMenuItem(
                            value: year,
                            child: Text(year.toString()),
                          ),
                        )
                        .toList(),
                    onChanged: (year) => widget.onYearChanged(year!),
                    style: TextStyle(
                      color: Color.fromARGB(255, 165, 101, 56),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ToggleButtons(
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: Colors.white,
                  fillColor: Color.fromARGB(255, 165, 101, 56),
                  color: Colors.brown.shade400,
                  constraints: const BoxConstraints(
                    minWidth: 60,
                    minHeight: 36,
                  ),
                  isSelected: [widget.showWeekly, !widget.showWeekly],
                  onPressed: (index) => widget.onShowWeeklyChanged(index == 0),
                  children: const [Text('Week'), Text('Year')],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
