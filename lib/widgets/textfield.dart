// //  Selected Date

import '../../export.dart';

Future selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now().subtract(const Duration(days: 365 * 19)),
    firstDate: DateTime(1950),
    lastDate: DateTime.now().subtract(const Duration(days: 365 * 19)),
  );

  if (pickedDate != null) {
    final String formattedDate =
        "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    return formattedDate;
  } else {
    return "";
  }
}

// //  Selected Time
Future selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(data: ThemeData(primaryColor: Colors.green), child: child!);
    },
  );

  if (pickedTime != null && context.mounted) {
    return pickedTime.format(context);
  }
}

class TxtModel {
  final String? headTxt;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final TextEditingController? controller;
  final int? maxLines, minLines, maxLength;
  final dynamic onTap;
  final dynamic onTapOutside;
  final double? cursorHeight;
  final Function? validator;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final BoxDecoration? decoration;
  final Function(String?)? onSaved, onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon, prefixIcon;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;

  final bool? readOnly, filled, border, isDense;
  final Color? fillColor;
  final TextStyle? style;
  final bool? enabled;
  final FocusNode? focusNode;
  final bool autofocus;

  const TxtModel(
      {this.headTxt,
      this.autofocus = false,
      this.maxLengthEnforcement,
      this.enabled,
      this.focusNode,
      this.cursorHeight,
      this.contentPadding,
      this.textAlign,
      this.decoration,
      this.controller,
      this.labelText,
      this.errorText,
      this.inputFormatters,
      this.keyboardType,
      this.initialValue,
      this.maxLength,
      this.minLines,
      this.maxLines,
      this.onSaved,
      this.onChanged,
      this.readOnly,
      this.onTap,
      this.suffixIcon,
      this.prefixIcon,
      this.hintText,
      this.border = true,
      this.filled,
      this.fillColor,
      this.validator,
      this.style,
      this.onTapOutside,
      this.isDense});
}

class TxtField extends StatelessWidget {
  final TxtModel txtModel;
  const TxtField({super.key, required this.txtModel});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: txtModel.autofocus,
        focusNode: txtModel.focusNode,
        enabled: txtModel.enabled ?? true,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        onTap: txtModel.onTap,
        initialValue: txtModel.initialValue,
        style: txtModel.style ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15),
        textAlign: txtModel.textAlign ?? TextAlign.start,
        onChanged: txtModel.onChanged,
        cursorHeight: txtModel.cursorHeight ?? 25.0,
        inputFormatters: txtModel.inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: txtModel.maxLines,
        minLines: txtModel.minLines,
        maxLength: txtModel.maxLength,
        controller: txtModel.controller,
        onSaved: txtModel.onSaved,
        keyboardType: txtModel.keyboardType,
        maxLengthEnforcement: txtModel.maxLengthEnforcement,

        // validator: (value) {
        //   if (txtModel.validator != null) {
        // log('Validating field: ${txtModel.labelText}, value: $value');
        //     return txtModel.validator!(value);
        //   }
        //   return null;
        // },

        validator: txtModel.validator != null
            ? (value) => txtModel.validator!(value)
            : null,
        readOnly: txtModel.readOnly ?? false,
        scrollPadding: EdgeInsets.zero,
        decoration: InputDecoration(
            fillColor: txtModel.fillColor ?? Colors.transparent,
            filled: txtModel.filled ?? true,
            isDense: txtModel.isDense ?? false,
            errorStyle: const TextStyle(color: Colors.red),
            errorText: txtModel.errorText,
            counter: const Offstage(),
            labelStyle: Theme.of(context).textTheme.labelLarge,
            labelText: txtModel.labelText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: ColorTheme.primaryDark,
                )),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            )),
            border: txtModel.border == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.amber))
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.amber)),
            hintText: txtModel.hintText,
            prefixIcon: txtModel.prefixIcon,
            hintStyle: Theme.of(context).textTheme.labelLarge,
            suffixIcon: txtModel.suffixIcon,
            contentPadding: txtModel.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 17.0)));
  }
}

// ! Validation For  TextFormField
validateField(String value) {
  if (value.trim().isEmpty) {
    return 'Field is Required.';
  } else {
    return null;
  }
}

validateRangeField(String value, {required int min, required int max}) {
  if (value.trim().isEmpty) {
    return 'Field is Required.';
  } else if (value.length <= min) {
    return 'Min Text Length $min';
  } else if (value.length >= max) {
    return 'Min Text Length $max';
  }
}

String? validateRange(String value, {required int min, required int max}) {
  // Check if the value is empty
  if (value.trim().isEmpty) {
    return 'Field is required.';
  }
  final RegExp digitsOnlyRegExp = RegExp(r'^\d+$');
  if (!digitsOnlyRegExp.hasMatch(value)) {
    return 'Invalid number format. Only digits are allowed.';
  }
  int? intValue = int.tryParse(value);
  if (intValue == null) {
    return 'Invalid number format.';
  }
  if (intValue < min) {
    return 'Min value is $min.';
  } else if (intValue > max) {
    return 'Max value is $max.';
  }
  return null;
}

validateMobile(String value) {
  if (value.trim().isEmpty) {
    return 'Mobile Number is required.';
  }
  final RegExp indianMobileRegExp = RegExp(r'^[6-9]\d{9}$');
  if (!indianMobileRegExp.hasMatch(value)) {
    return 'Invalid Mobile Number';
  }
  if (value.length != 10) {
    return 'Mobile Number required at least 10 numbers';
  }
  return null;
}

validateOTP(String value) {
  if (value.trim().isEmpty) {
    return 'OTP is Required.';
  } else if (value.length < 4) {
    return 'OTP required at least 4 numbers';
  } else if (value.length > 4) {
    return 'OTP required at most 4 numbers';
  } else {
    return null;
  }
}

validateEmail(String value) {
  bool validEmail = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (value.trim().isEmpty) {
    return 'Email is Required.';
  } else if (validEmail == false) {
    return 'Invalid email address';
  } else {
    return null;
  }
}
