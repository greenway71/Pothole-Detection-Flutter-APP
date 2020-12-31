import 'package:new_project/Directory/Classforsigin.dart';
import 'package:test/test.dart';

void main() {
  test('Empty Email Test', () {
    var result = FieldValidator.validateEmail('');
    expect(result, 'Enter valid Email!');
  });

  test('Invalid Email Test', () {
    var result = FieldValidator.validateEmail('');
    expect(result, 'Enter valid Email!');
  });

  test('Valid Email Test', () {
    var result = FieldValidator.validateEmail('sandeshadhikari92@gmail.com');
    expect(result, null);
  });

  test('Empty Password Test', () {
    var result = FieldValidator.validatePassword('');
    expect(result, 'Enter Password!');
  });

  test('Invalid Password Test', () {
    var result = FieldValidator.validatePassword('123');
    expect(result, 'Password should be of at least 8 characters');
  });

  test('Valid Password Test', () {
    var result = FieldValidator.validatePassword('password123');
    expect(result, null);
  });
}

