class EmailAddress {
  final String value;
  EmailAddress(this.value) {
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      throw ArgumentError('Invalid email');
    }
  }
  @override
  String toString() => value;
}

class Password {
  final String value;
  Password(this.value) {
    if (value.length < 6) throw ArgumentError('Password too short');
  }
  @override
  String toString() => '***';
}

class NonEmptyString {
  final String value;
  NonEmptyString(this.value) {
    if (value.trim().isEmpty) throw ArgumentError('Empty string');
  }
  @override
  String toString() => value;
}

class PhoneNumber {
  final String value;
  PhoneNumber(this.value) {
    if (value.trim().length < 7) throw ArgumentError('Invalid phone');
  }
  @override
  String toString() => value;
}

class Age {
  final int value;
  Age(this.value) {
    if (value < 1 || value > 120) throw ArgumentError('Invalid age');
  }
}

class Gender {
  final String value; // "male", "female", "other"
  Gender(this.value);
}

class WeightKg {
  final double value;
  WeightKg(this.value) {
    if (value <= 0 || value > 500) throw ArgumentError('Invalid weight');
  }
}
