import 'package:form_validator/form_validator.dart';

class TextFormFieldValidators {
  static StringValidationCallback nameValidator = ValidationBuilder()
      .required('Name is required.')
      .minLength(6, 'Name must be at least 6 characters.')
      .maxLength(25, 'Name must be at most 25 characters.')
      .regExp(RegExp(r'^[a-zA-Z ]+$', unicode: true),
          "Name should only contain alphabets and spaces.")
      .build();

  static StringValidationCallback phoneNumberValidator = ValidationBuilder(
          requiredMessage: "Phone is required.")
      .required("Phone is required.")
      .regExp(RegExp(r'^[0-9]+$'), "Phone must be composed of numbers only.")
      .build();

  static StringValidationCallback passwordValidator = ValidationBuilder()
      .required('Password is required.')
      .minLength(8, 'Password must be at least 8 characters.')
      .maxLength(100, 'Password must be at most 100 characters.')
      .regExp(
          RegExp(r'^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}$',
              unicode: true),
          "Password should be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character.")
      .build();

  static StringValidationCallback emailValidator = ValidationBuilder()
      .required('Email is required.')
      .email('Email is not valid.')
      .regExp(
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              unicode: true),
          "Email is not valid.")
      .build();

  static StringValidationCallback birthDateValidator =
      ValidationBuilder().add((value) {
    if (value != null) {
      DateTime birthDate = DateTime.parse(value);
      DateTime currentDate = DateTime.now();
      if (birthDate.isAfter(currentDate)) {
        return 'Birth date cannot be in the future.';
      }
    }
    return null;
  }).build();

  static StringValidationCallback apartmentNameValidator = ValidationBuilder()
      .required('Name is required.')
      .regExp(RegExp(r'^[a-zA-Z\s]{6,}$', unicode: true),
          "Name should only contain letters and spaces, and be at least 6 characters long.")
      .build();

  static StringValidationCallback apartmentDescriptionValidator =
      ValidationBuilder()
          .required('Description is required.')
          .minLength(10, 'Description should be at least 10 characters long.')
          .build();

  static StringValidationCallback pricePerNightValidator = ValidationBuilder()
      .required('Price per night is required.')
      .regExp(
          RegExp(r'^\d+$', unicode: true), "Price should only contain digits.")
      .build();

  static StringValidationCallback roomsValidator = ValidationBuilder()
      .required('Number of rooms is required.')
      .regExp(
          RegExp(r'^\d+$', unicode: true), "Rooms should only contain digits.")
      .build();

  static StringValidationCallback reviewValidator =
      ValidationBuilder().add((value) {
    if (value != null) {
      if (value.length > 200) {
        return 'Maximum length reached.';
      }
    }
    return null;
  }).build();
}
