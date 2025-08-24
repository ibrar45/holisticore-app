import 'package:flutter/material.dart';

class HCWTextField extends StatefulWidget {
  const HCWTextField({
    super.key,
    this.hint,
    this.icon,
    this.obscure = false,
    this.controller,
    this.keyboardType,
  });

  final String? hint;
  final IconData? icon;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  State<HCWTextField> createState() => _HCWTextFieldState();
}

class _HCWTextFieldState extends State<HCWTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        suffixIcon: widget.obscure
            ? IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(_obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              )
            : null,
      ),
    );
  }
}
