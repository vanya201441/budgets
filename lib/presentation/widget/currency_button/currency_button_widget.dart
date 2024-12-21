import 'package:byte_budget/domain/entities/operation.dart';
import 'package:flutter/material.dart';

class CurrencyToggleButton extends StatefulWidget {
  final Currency selectedCurrency;
  final ValueChanged<Currency> onCurrencyChanged;

  const CurrencyToggleButton({
    super.key,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
  });

  @override
  State<CurrencyToggleButton> createState() => _CurrencyToggleButtonState();
}

class _CurrencyToggleButtonState extends State<CurrencyToggleButton> {
  late Currency _selectedCurrency;

  @override
  void initState() {
    super.initState();
    _selectedCurrency = widget.selectedCurrency;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Currency>(
      value: _selectedCurrency,
      icon: const Icon(Icons.arrow_drop_down),
      onChanged: (Currency? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedCurrency = newValue;
          });
          widget.onCurrencyChanged(newValue);
        }
      },
      items: Currency.values.map<DropdownMenuItem<Currency>>((Currency value) {
        return DropdownMenuItem<Currency>(
          value: value,
          child: Text(value.symbol),
        );
      }).toList(),
    );
  }
}
