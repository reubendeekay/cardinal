String? validateEmail(String? value) {
  String? _msg;
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value!.isEmpty) {
    _msg = "Your email is required";
  } else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid email address";
  }
  return _msg;
}

String? validatePassword(String? value) {
  String? _msg;
  if (value!.isEmpty) {
    _msg = "Your password is required";
  } else if (value.length < 8) {
    _msg = "Password must be atleast 8 characters long";
  }
  return _msg;
}

String? validateConfirmPassword(String password1, String password2) {
  String _msg = "";
  if (password2.isEmpty) {
    _msg = "Your password is required";
  } else if (password2.length < 8) {
    _msg = "Password must be atleast 8 characters long";
  } else if (password2 != password1) {
    _msg = 'Passwords do not match';
  }
  return _msg;
}

String? validatePhoneNumber(String? value) {
  RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  if (value == null || value.isEmpty) {
    return 'Enter your phone number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return null;
}
