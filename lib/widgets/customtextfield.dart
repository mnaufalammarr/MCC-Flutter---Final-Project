import 'package:flutter/material.dart';

import '../style.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final bool? readonly;
  final Widget? suffix;
  final bool? pass;
  final ValueChanged<String>? onChanged;
  final int? maxChar;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? minLines;

  CustomTextFieldWidget({
    Key? key,
    required this.controller,
    required this.hint,
    required this.label,
    this.readonly = false,
    this.suffix,
    this.pass = false,
    this.onChanged,
    this.maxChar,
    this.textInputType,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField();
  }

  Widget CustomTextField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: Styles.Text16,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          onChanged: onChanged,
          obscureText: pass!,
          obscuringCharacter: "*",
          readOnly: readonly!,
          maxLength: maxChar,
          maxLines: maxLines ?? 1,
          minLines: minLines ?? maxLines,
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              hintText: hint,
              hintStyle: Styles.inputTextHintDefaultTextStyle,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              filled: true,
              fillColor: Styles.inputTextDefaultBackgroundColor,
              suffixIcon: suffix),
          style: Styles.inputTextDefaultTextStyle,
        ),
      ],
    );
  }
} 

// class CustomTextFieldWidget extends StatefulWidget {
//   final TextEditingController controller;
//   final String hint;
//   final String label;
//   bool pass = false;

//   CustomTextFieldWidget({
//     Key? key,
//     required this.controller,
//     required this.hint,
//     required this.label,
//     this.pass = false,
//   }) : super(key: key);

//   @override
//   State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
// }

// class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
//   bool _passwordVisible = false;
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomTextField();
//   }

//   Widget CustomTextField() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: Styles.Text16,
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         TextField(
//             obscureText: widget.pass ? !_passwordVisible : false,
//             obscuringCharacter: "*",
//             controller: widget.controller,
//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//               hintText: widget.hint,
//               hintStyle: Styles.inputTextHintDefaultTextStyle,
//               fillColor: Styles.inputTextDefaultBackgroundColor,
//               filled: true,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 borderSide: BorderSide.none,
//               ),
//               suffixIcon: widget.pass
//                   ? IconButton(
//                       icon: Icon(
//                         // Based on passwordVisible state choose the icon
//                         _passwordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Theme.of(context).primaryColorDark,
//                       ),
//                       onPressed: () {
//                         // Update the state i.e. toogle the state of passwordVisible variable
//                         setState(() {
//                           _passwordVisible = !_passwordVisible;
//                         });
//                       },
//                     )
//                   : null,
//             ))
//       ],
//     );
//   }
// }
