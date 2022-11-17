import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class modified_text extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;

  const modified_text({Key? key, this.color,this.size,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.brawler(
      color: color,
      fontSize: size
    ),
    );
  }
}
