import 'package:employee_app/core/model/employee_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';


class EmployeeList extends StatelessWidget {
  final String imageLink, name;
  final EmployeeModel model;
  final VoidCallback onTap;

  const EmployeeList({
    Key? key,
    required this.imageLink,
    required this.name,
    required this.model,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32.r,
              backgroundImage: NetworkImage(imageLink),
            ),
            SizedBox(
              width: 15.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Developer at Facebook',
                  style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}