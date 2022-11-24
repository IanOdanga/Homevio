import 'package:homevio/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Empty Email Test', () {
    var result = FieldValidator.validateEmail('');
    expect(result, 'Enter Email!');
  });

  test('Invalid Email Test', () {
    var result = FieldValidator.validateEmail('ianlukeodanga');
    expect(result, 'Enter valid Email!');
  });

  test('Valid Email Test', () {
    var result = FieldValidator.validateEmail('ianlukeodanga@gmail.com');
    expect(result, null);
  });

  test('Empty Password Test', () {
    var result = FieldValidator.validatePassword('');
    expect(result, 'Enter Password!');
  });

  test('Invalid Password Test', () {
    var result = FieldValidator.validatePassword('123');
    expect(result, 'Password must be more than 8 characters');
  });

  test('Valid Password Test', () {
    var result = FieldValidator.validatePassword('testing123');
    expect(result, null);
  });
}