import 'package:flutter/material.dart';
import 'package:sub_tracker/core/util/constants.dart';
import '../widgets/header_box.dart';

class AuthContainer extends StatelessWidget{
  const AuthContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < Breakpoints.mobile){
            return child;
          }
          return Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 68),
                    child: const HeaderBox(),
                  )
              ),
              VerticalDivider(width: 3, thickness: 3,),
              Expanded(child: child)
            ],
          );
        }
    );
  }

}