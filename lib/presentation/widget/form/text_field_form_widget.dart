import 'package:byte_budget/presentation/colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    this.errorText,
    this.maxLength,
    this.onChanged,
    this.keyboardType,
    this.formControlName,
    this.obscureText = false,
    this.isUrl = false,
    this.suffixIcon,
  });

  final String title;
  final TextEditingController controller;
  final int? maxLength;
  final void Function(String item)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? formControlName;
  final String? errorText;
  final bool isUrl;
  final Widget? suffixIcon;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController _controller = TextEditingController();
  late FormGroup form;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      widget.formControlName!: FormControl<String>(value: ''),
    });
    widget.controller.addListener(() {
      widget.onChanged?.call(widget.controller.text);
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      errorText: widget.errorText,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      filled: true,
      fillColor: Colors.blue.withOpacity(0.4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      suffixIcon: widget.suffixIcon,
      counterText: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            widget.title,
            style: TextStyle(color: AppColors.primary),
          ),
          const SizedBox(height: 4),
          ReactiveForm(
            formGroup: form,
            child: GestureDetector(
                child: ReactiveTextField<dynamic>(
              cursorColor: AppColors.primaryLight,
              decoration: _buildInputDecoration(),
              maxLength: widget.maxLength,
              formControlName: widget.formControlName,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              style: const TextStyle(),
              obscureText: widget.obscureText,
            )),
          )
        ],
      ),
    );
  }
}
