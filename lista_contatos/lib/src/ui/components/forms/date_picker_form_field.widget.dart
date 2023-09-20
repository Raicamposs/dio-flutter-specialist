import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lista_contatos/src/ui/components/formatter/date_input_formatter.dart';

import '../../common/debounce.dart';

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField({
    Key? key,
    this.firstDate,
    this.lastDate,
    this.onSaved,
    this.onChange,
    this.initialValue,
    this.validator,
    this.decoration = const InputDecoration(),
    this.icon,
  }) : super(key: key);

  final DateTime? firstDate;
  final DateTime? lastDate;
  final InputDecoration decoration;
  final FormFieldSetter<DateTime>? onSaved;
  final DateTime Function(DateTime)? onChange;
  final DateTime? initialValue;
  final String? Function(DateTime?)? validator;
  final Icon? icon;

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  late Debounce _debounce;
  late TextEditingController _controller;

  @override
  void initState() {
    _debounce = Debounce(const Duration(milliseconds: 400));
    _controller = TextEditingController(text: _format(widget.initialValue));
    super.initState();
  }

  @override
  void dispose() {
    _debounce.dispose();
    super.dispose();
  }

  String _format(DateTime? date) {
    if (date != null) return DateFormat('dd/MM/yyyy').format(date);
    return '';
  }

  DateTime get _initDate {
    return widget.firstDate ?? DateTime(1900);
  }

  DateTime get _endDate {
    final fiveYearsInFuture = DateTime.now().add(
      const Duration(days: 365 * 5),
    );
    return widget.lastDate ?? fiveYearsInFuture;
  }

  _onTap(BuildContext context, FormFieldState<DateTime> state) {
    return () async {
      return showDatePicker(
        context: context,
        firstDate: _initDate,
        lastDate: _endDate,
        initialDate: state.value ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        builder: (context, Widget? child) {
          return Theme(
            data: Theme.of(context),
            child: child!,
          );
        },
      ).then((selectedDate) {
        if (selectedDate == null) {
          return Future.value();
        }

        _controller.text = _format(selectedDate);
        state.didChange(selectedDate);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: FormField<DateTime>(
          initialValue: widget.initialValue,
          onSaved: widget.onSaved,
          validator: widget.validator,
          builder: (FormFieldState<DateTime> state) {
            return TextField(
              controller: _controller,
              onChanged: (value) {
                _debounce(() {
                  try {
                    final date = DateFormat('dd/MM/yyyy').parse(value);
                    state.didChange(date);
                  } catch (e) {
                    state.didChange(null);
                  }
                });
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DateInputFormatter(),
              ],
              decoration: widget.decoration.copyWith(
                errorText: state.errorText,
                suffixIcon: IconButton(
                  icon: widget.icon ?? const Icon(Icons.arrow_drop_down),
                  onPressed: _onTap(context, state),
                ),
              ),
            );
          }),
    );
  }
}
