import 'package:flutter/material.dart';
import 'package:slice_ledger/src/utils/colors.dart';


class CustomButton{
  static InkWell button(text,
      {Function? callBack, double? size // Providing a default value for size
  }) {
    return InkWell(
      onTap: () => callBack!(),
      child:Container(
        height:40,
        width: 325,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:AppColors.primaryColor,),
        child:  Center(
            child: Text(text,
              style:  TextStyle(
                  color: AppColors.backGroundColor,
                  fontSize: size ?? 14,fontFamily: "Questrial-Regular"),)),
      ),


    );
  }



  static InkWell buttonWithoutBg(text, {Function? callBack}) {
    return InkWell(
      onTap: () => callBack!(),
      child: Container(
        height: (70),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
        child: Center(
            child:
        Text(text,
            style: const TextStyle(fontSize: 16,
                color: Color(0xff6B39F4),
                fontFamily: "Manrope-Bold"))) ,
      ),

    );
  }

}