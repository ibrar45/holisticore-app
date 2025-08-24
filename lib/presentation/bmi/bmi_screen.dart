import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../core/hcw_colors.dart';
import 'bmi_result_args.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _formKey = GlobalKey<FormState>();

  final ageCtl = TextEditingController();
  final weightCtl = TextEditingController(); // kg
  final heightCtl = TextEditingController(); // inches (per mock)

  final ageNode = FocusNode();
  final weightNode = FocusNode();
  final heightNode = FocusNode();

  String gender = 'Male';

  @override
  void dispose() {
    ageCtl.dispose();
    weightCtl.dispose();
    heightCtl.dispose();
    ageNode.dispose();
    weightNode.dispose();
    heightNode.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final age = int.parse(ageCtl.text.trim());
    final weightKg = double.parse(weightCtl.text.trim());
    final heightIn = double.parse(heightCtl.text.trim());

    final heightM = heightIn * 0.0254; // inches → meters
    final bmi = weightKg / (heightM * heightM);

    final (label, message, color) = _classifyBMI(bmi);

    context.push(
      '/bmi/result',
      extra: BMIResultArgs(
        bmi: double.parse(bmi.toStringAsFixed(1)),
        label: label,
        message: message,
        color: color,
        gender: gender,
        age: age,
        heightIn: heightIn,
        weightKg: weightKg,
      ),
    );
  }

  // Returns (label, message, color)
  (String, String, Color) _classifyBMI(double bmi) {
    if (bmi < 18.5) {
      return (
        'Underweight',
        'You are under the normal range. Aim for gradual, healthy weight gain.',
        const Color(0xFF06B6D4)
      );
    } else if (bmi < 25) {
      return (
        'Normal',
        'You have a Normal Body weight, Good job.',
        const Color(0xFF16A34A)
      );
    } else if (bmi < 30) {
      return (
        'Overweight',
        'You are above the normal range. Consider diet & activity changes.',
        const Color(0xFFF59E0B)
      );
    } else {
      return (
        'Obese',
        'You are in the obese range. Consider consulting a healthcare provider.',
        const Color(0xFFEF4444)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text('BMI Calculator',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),

      // sticky bottom CTA like the mock
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
              onPressed: _calculate, child: const Text('Calculate')),
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // keep content nicely centered on tablets / wide screens
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  children: [
                    // Age (full width)
                    _CardField(
                      child: TextFormField(
                        controller: ageCtl,
                        focusNode: ageNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Age',
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                          border: InputBorder.none,
                        ),
                        validator: (v) {
                          final n = int.tryParse((v ?? '').trim());
                          if (n == null || n <= 0 || n > 120)
                            return 'Enter a valid age';
                          return null;
                        },
                        onFieldSubmitted: (_) => weightNode.requestFocus(),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Gender + Weight (two columns)
                    Row(
                      children: [
                        Expanded(
                          child: _CardField(
                            child: _GenderSegmented(
                              value: gender,
                              onChanged: (v) => setState(() => gender = v),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _CardField(
                            child: TextFormField(
                              controller: weightCtl,
                              focusNode: weightNode,
                              textInputAction: TextInputAction.next,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d{0,3}(\.\d{0,2})?$')),
                              ],
                              decoration: const InputDecoration(
                                hintText: 'Weight',
                                prefixIcon: Icon(Icons.monitor_weight_outlined),
                                suffixText: 'kg',
                                border: InputBorder.none,
                              ),
                              validator: (v) {
                                final n = double.tryParse((v ?? '').trim());
                                if (n == null || n <= 0 || n > 500)
                                  return 'Enter kg';
                                return null;
                              },
                              onFieldSubmitted: (_) =>
                                  heightNode.requestFocus(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Height (full width)
                    _CardField(
                      child: TextFormField(
                        controller: heightCtl,
                        focusNode: heightNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d{0,3}(\.\d{0,2})?$')),
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Height in inches',
                          prefixIcon: Icon(Icons.height),
                          suffixText: 'in',
                          border: InputBorder.none,
                        ),
                        validator: (v) {
                          final n = double.tryParse((v ?? '').trim());
                          if (n == null || n <= 0 || n > 120)
                            return 'Enter inches';
                          return null;
                        },
                        onFieldSubmitted: (_) => _calculate(),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Text(
                      'Tip: 1 foot = 12 inches • 1 inch = 2.54 cm',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Soft card container to match the mock’s rounded inputs
class _CardField extends StatelessWidget {
  const _CardField({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = HCWColors();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.border),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: child,
    );
  }
}

/// Segmented gender control (compact & touch-friendly)
class _GenderSegmented extends StatelessWidget {
  const _GenderSegmented({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme;
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12, right: 6),
          child: Icon(Icons.transgender, color: Color(0xFF64748B)),
        ),
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                _segBtn('Male', value == 'Male', () => onChanged('Male'),
                    base.primary),
                _segBtn('Female', value == 'Female', () => onChanged('Female'),
                    base.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _segBtn(
      String label, bool selected, VoidCallback onTap, Color primary) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? primary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : const Color(0xFF111827),
            ),
          ),
        ),
      ),
    );
  }
}
