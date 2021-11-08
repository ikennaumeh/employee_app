import 'package:employee_app/core/model/employee_model.dart';
import 'package:employee_app/ui/views/home/employee_details_view.dart';
import 'package:employee_app/ui/widgets/employee_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:azlistview/azlistview.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<EmployeeModel> list = [];
  List<_AZItem> items = [];
  List<int> data = [];
  final int increment = 50;
  bool isLoading = false;
  int currentLength = 0;

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });

    // Add in an artificial delay
    await Future.delayed(const Duration(seconds: 2));
    for (var i = currentLength; i <= currentLength + increment; i++) {
      data.add(i);
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });

  }

  Future<void> fetchData() async {
    final String response =
        await rootBundle.loadString("assets/json/employees.json");
    list = employeeModelFromJson(response);
    initList(list);
  }

  void initList(List<EmployeeModel> items) {
    this.items = items
        .map((item) =>
            _AZItem(model: item, tag: item.firstName[0].toUpperCase()))
        .toList();
    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
    setState(() {});
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    _loadMore();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: items.isEmpty
                ? const CircularProgressIndicator()
                : LazyLoadScrollView(
                  isLoading: isLoading,
                  onEndOfPage: () => _loadMore(),
                  child: AzListView(
                      data: items,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final tag = item.getSuspensionTag();
                        final offStage = !item.isShowSuspension;
                        return Column(
                          children: [
                            Offstage(
                              offstage: offStage,
                              child: Container(
                                height: 40.h,
                                margin: EdgeInsets.only(right: 16.w),
                                padding: EdgeInsets.only(left: 16.w),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  tag,
                                  softWrap: true,
                                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            EmployeeList(
                              onTap: () =>
                                  Get.to(() => EmployeeDetailsView(data: item.model)),
                              name: "${item.model.firstName} ${item.model.lastName}",
                              imageLink: item.model.imageUrl,
                              model: item.model,
                            ),
                          ],
                        );
                      },
                      indexHintBuilder: (context, hint) => Container(
                        width: 60.h,
                        height: 60.h,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          hint,
                          style: TextStyle(color: Colors.white, fontSize: 30.sp),
                        ),
                      ),
                      indexBarMargin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 135.h),
                      indexBarOptions: const IndexBarOptions(
                        needRebuild: true,
                        selectTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        selectItemDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        indexHintAlignment: Alignment.centerRight,
                        indexHintOffset: Offset(-20, 0),
                      ),
                    ),
                )),
      ),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: const Size(0, 120),
      child: Column(
        children: [
          AppBar(
            leading: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            title: const Text(
              'Employee Directory',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 5.h,),
          Container(
            height: 45.h,
            margin: EdgeInsets.only(top: 5.h, left: 20.w, right: 20.w),
            padding: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(99.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  offset: const Offset(0, 4),
                  blurRadius: 0.2,
                  spreadRadius: 2,
                ),
              ]
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: "Search Employee",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white.withOpacity(.2),
                        width: 0,
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white.withOpacity(.2),
                        width: 0,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h,),
        ],
      ),
    );
  }
}




class _AZItem extends ISuspensionBean {
  final EmployeeModel model;
  final String tag;

  _AZItem({
    required this.model,
    required this.tag,
  });

  @override
  String getSuspensionTag() => tag;
}
