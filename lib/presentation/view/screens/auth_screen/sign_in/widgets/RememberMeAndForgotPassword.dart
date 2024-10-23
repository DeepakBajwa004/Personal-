import 'package:flutter/material.dart';

class RememberMeAndForgotPassword extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onForgotPasswordPressed;

  const RememberMeAndForgotPassword({
    super.key,
    required this.isChecked,
    required this.onRememberMeChanged,
    required this.onForgotPasswordPressed,
  });

  @override
  State<RememberMeAndForgotPassword> createState() => _RememberMeAndForgotPasswordState();
}

class _RememberMeAndForgotPasswordState extends State<RememberMeAndForgotPassword> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked = newValue ?? false;
                });
                widget.onRememberMeChanged(newValue);
              },
              checkColor: Colors.white,
              fillColor: WidgetStateProperty.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                    ? const Color(0xFFF77D8E)
                    : Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              side: const BorderSide(
                color: Color(0xFFF77D8E),
                width: 2.0,
              ),
            ),
            const Text('Remember Me'),
          ],
        ),
        TextButton(
          onPressed: widget.onForgotPasswordPressed,
          child: const Text(
            'Forgot Password',
            style: TextStyle(color: Color(0xFFF77D8E)),
          ),
        ),
      ],
    );
  }
}
