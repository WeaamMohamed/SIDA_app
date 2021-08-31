import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  /// it had to be final !!
   bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;

  CustomCheckbox({ this.isChecked,this.size,  this.iconSize, this.selectedColor, this.selectedIconColor});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {

  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("i am here");
        setState(() {
          _isSelected = !_isSelected;
          /// WASN'T EXIST !!!!
          widget.isChecked=_isSelected;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
            color: _isSelected ? widget.selectedColor ?? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
            border: _isSelected ? null : Border.all(
              color: Colors.grey,
              width: 2.0,
            )
        ),
        width: widget.size ?? 30,
        height: widget.size ?? 30,
        child: _isSelected ? Icon(
          Icons.check,
          color: widget.selectedIconColor ?? Colors.white,
          size: widget.iconSize ?? 20,
        ) : null,
      ),
    );
  }
}
