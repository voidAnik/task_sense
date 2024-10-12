import 'package:flutter/material.dart';

class ToggleStar extends StatefulWidget {
  const ToggleStar({
    super.key,
    required this.onChange,
    required this.isMarked,
  });
  final Function(bool value) onChange;
  final bool isMarked;

  @override
  State<ToggleStar> createState() => _ToggleStarState();
}

class _ToggleStarState extends State<ToggleStar> {
  late bool isFav;
  @override
  void initState() {
    isFav = widget.isMarked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFav ? Icons.star_rounded : Icons.star_border_rounded,
        size: 30,
        color: isFav ? Colors.amber : null,
      ),
      onPressed: () {
        setState(() {
          isFav = !isFav;
        });
        widget.onChange(isFav);
      },
    );
  }
}
