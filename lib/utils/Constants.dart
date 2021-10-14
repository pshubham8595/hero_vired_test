import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants{


 static Widget loadingColumn(BuildContext context){
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new CircularProgressIndicator(

          valueColor:  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          strokeWidth: 1,
        ),
        new SizedBox(height: 10,),
        new Text("Loading..",style: GoogleFonts.montserrat(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w400,fontSize: 15),),
      ],
    );
  }
}