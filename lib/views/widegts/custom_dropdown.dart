import 'package:flutter/material.dart';
import '../../config/colors/colors.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final String? preSelectedItem; // New variable for pre-selection
  final ValueChanged<String> onItemSelected;
  final String text;
  final Function(Object?)? onchanged;
  final String? Function(String?)? validator;
  final Widget? icon;
  final String? value;
  final String? hinttext;
  final String? startext;

  const CustomDropDown({
    Key? key,
    required this.items,
    this.selectedItem,
    this.preSelectedItem, // Added pre-selection variable
    required this.onItemSelected,
    required this.text,
    this.onchanged,
    this.validator,
    this.icon,
    this.hinttext,
    this.startext,
    this.value,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();

    // Ensure the selected value exists in the dropdown items
    if (widget.items.contains(widget.preSelectedItem)) {
      _selectedValue = widget.preSelectedItem;
    } else if (widget.items.contains(widget.selectedItem)) {
      _selectedValue = widget.selectedItem;
    } else {
      _selectedValue = null; // Avoid invalid selection
    }

    // Call onItemSelected only if a valid pre-selected value exists
    if (_selectedValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onItemSelected(_selectedValue!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxDropdownHeight = MediaQuery.of(context).size.height * 0.4;

    return DropdownButtonFormField<String>(
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.lightblackcol,
      ),
      validator: widget.validator,
      value: _selectedValue, // Use checked value
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(value),
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedValue = value;
          });
          widget.onItemSelected(value);
        }
      },
      menuMaxHeight: maxDropdownHeight,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        fillColor: AppColors.whitecol,
        hintStyle: const TextStyle(
          color: AppColors.lightblackcol,
          fontFamily: 'inter',
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.lightblackcol.withOpacity(0.25),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.lightblackcol.withOpacity(0.25),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.lightblackcol.withOpacity(0.25),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.colred),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.colred),
        ),
      ),
      hint: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightblackcol,
                ),
              ),
            ),
            Text(
              widget.startext ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.colred,
                fontFamily: 'inter',
              ),
            )
          ],
        ),
      ),
    );
  }
}




// DropdownButtonFormField<String>(
//                               validator: validateGender,
//                               icon: const Padding(
//                                 padding: EdgeInsets.only(right: 5),
//                                 child: Icon(
//                                   Icons.keyboard_arrow_down,
//                                   color: AppColors.hinttextcol,
//                                 ),
//                               ),
//                               value: selectedGender,
//                               items: items.map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 10),
//                                     child: Text(
//                                       value,
//                                       style: const TextStyle(
//                                         fontFamily: 'dmsans',
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 context
//                                     .read<GenderCubit>()
//                                     .selectGender(newValue!);
//                               },
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 hintText: 'Gender',
//                                 hintStyle: const TextStyle(
//                                   fontFamily: 'dmsans',
//                                   fontSize: 16,
//                                   color: AppColors.hinttextcol,
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 16,
//                                   horizontal: 15,
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: const BorderSide(
//                                       color: AppColors.whitecol),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: const BorderSide(
//                                       color: AppColors.whitecol),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: const BorderSide(
//                                       color: AppColors.whitecol),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: const BorderSide(
//                                       color: AppColors.whitecol),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: const BorderSide(
//                                       color: AppColors.whitecol),
//                                 ),
//                               ),
//                               hint: Align(
//                                 alignment: Alignment.center,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 10),
//                                   child: Text(
//                                     'Gender',
//                                     style: const TextStyle(
//                                       fontFamily: 'dmsans',
//                                       fontSize: 16,
//                                       color: AppColors.hinttextcol,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )