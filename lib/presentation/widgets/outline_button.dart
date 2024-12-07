import 'package:flutter/material.dart';

class OutlineButton extends StatefulWidget {
  final String text;
  final IconData iconData;
  final Function() onPressed;

  const OutlineButton({
    super.key,
    required this.text,
    required this.iconData,
    required this.onPressed,
  });

  @override
  State<OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: ElevatedButton(
          onPressed: widget.onPressed,

          /// button style
          style: ElevatedButton.styleFrom(
            elevation: _isHovered? 3:0,
            splashFactory: NoSplash.splashFactory,

            // colors
            backgroundColor:
            _isHovered ? Colors.purple.withOpacity(0.5) : Colors.transparent,
            //disabledBackgroundColor: _btnDisabledColor(context),

            // padding
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),

            // shape
            shape: RoundedRectangleBorder(
              side:  BorderSide(color: _isHovered ?Colors.transparent :Colors.purple),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// text
              Text(
                widget.text,
                style:  TextStyle(
                  fontSize: 12,
                  color: _isHovered? Colors.white:Colors.purple,
                ),
              ),

              /// horizontal space
              const SizedBox(width: 5),

              /// icon
              Icon(
                widget.iconData,
                color: _isHovered? Colors.white:Colors.purple,
                size: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
