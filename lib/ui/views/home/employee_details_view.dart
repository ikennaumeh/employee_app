import 'package:employee_app/core/model/employee_model.dart';
import 'package:employee_app/ui/widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployeeDetailsView extends StatelessWidget {
  final EmployeeModel data;
  const EmployeeDetailsView({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  height: 325.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.w, 80.h, 20.w, 20.h ),
                    height: 200.h,
                    width: 340.w,
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0,0),
                          blurRadius: 3.r,
                          spreadRadius: 0.2.r,
                          color: Colors.grey,
                        ),
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${data.firstName} ${data.lastName}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),),
                        SizedBox(height: 3.h,),
                        Text('Developer at Facebook', style: TextStyle(fontSize: 18.sp, color: Colors.grey),),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SmallButton(icon: Icons.phone,),
                             SizedBox(width: 20.w,),
                             Container(
                              height: 45.h,
                              width: 1.w,
                              color: Colors.black,
                            ),
                            SizedBox(width: 20.w,),
                            const SmallButton(icon: Icons.mobile_friendly,),
                            SizedBox(width: 20.w,),
                            Container(
                              height: 45.h,
                              width: 1.w,
                              color: Colors.black,
                            ),
                            SizedBox(width: 20.w,),
                            const SmallButton(icon: Icons.mail,),
                          ],
                        ),
                        SizedBox(height: 30.h,),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20.h,
                  left: 110.w,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 80.r,
                        backgroundImage: NetworkImage(data.imageUrl),
                      ),
                      Positioned(
                        bottom: 11.h,
                        right: 15.w,
                        child: CircleAvatar(
                          radius: 11.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 9.r,
                            backgroundColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text('Basic Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 200.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration:  BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0,0),
                        blurRadius: 3.r,
                        spreadRadius: 0.2.r,
                        color: Colors.grey,
                      ),
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phone', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                        Text(data.contactNumber, style: TextStyle(color: Colors.grey, fontSize: 18.sp),),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                        Text(data.id.toString(),overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey, fontSize: 14.sp),),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Age', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                        Text("${data.age}", style: TextStyle(color: Colors.grey, fontSize: 18.sp),),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                        Text(data.address, style: TextStyle(color: Colors.grey, fontSize: 18.sp),),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back,color: Colors.black,)),
      actions:  [
        const Icon(Icons.more_vert,color: Colors.black,),
        SizedBox(width: 10.w,),
      ],
      elevation: 0,
    );
  }
}


