// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class SelectJobTime extends StatelessWidget {
//   const SelectJobTime({super.key});
//   static const String routeName = '/jobtime';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(  backgroundColor: Color(0xFFF0F8FF),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//       ),
//     body: Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),child: Column(children: [
//           InkWell(
//             child: Container(
//       width: double.infinity,     padding: EdgeInsets.symmetric(vertical: 10),             decoration: BoxDecoration(
//                     border: Border.all(width: 2, color: Colors.grey.shade300),borderRadius: BorderRadius.all(Radius.circular(15.r))),
//                 child: Row(
//                   children: [
//                     Icon(Icons.date_range,color: Colors.blue.shade300,),Text(
//                       "  Select Days",
//                       style: TextStyle(color: Colors.grey.shade700),
//                     ),
//                   ],
//                 )),
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     content: StatefulBuilder(
//                       builder: (context, setState) {
//                         return AlertDialog(
//                           title: const Text('Select Working Days'),
//                           content: SingleChildScrollView(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: daysOfWeek.map((day) {
//                                 final dayInfo = workingHours[day]!;
//                                 return AnimatedContainer(
//                                   duration: const Duration(milliseconds: 300),
//                                   curve: Curves.easeInOut,
//                                   child: Card(
//                                     elevation: 2,
//                                     margin: const EdgeInsets.symmetric(
//                                         vertical: 6),
//                                     child: ExpansionTile(
//                                       title: Row(
//                                         children: [
//                                           Checkbox(
//                                             value: dayInfo.isSelected,
//                                             onChanged: (bool? value) {
//                                               setState(() {
//                                                 dayInfo.isSelected =
//                                                     value ?? false;
//                                                 if (!dayInfo.isSelected) {
//                                                   dayInfo.startTime = null;
//                                                   dayInfo.endTime = null;
//                                                 }
//                                               });
//                                             },
//                                           ),
//                                           Text(
//                                             day,
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                       children: dayInfo.isSelected
//                                           ? [
//                                               Padding(
//                                                 padding: const EdgeInsets
//                                                     .symmetric(
//                                                     horizontal: 16.0),
//                                                 child: Column(
//                                                   children: [
//                                                     ListTile(
//                                                       title: Text(
//                                                         dayInfo.startTime !=
//                                                                 null
//                                                             ? "Start: ${dayInfo.startTime!.format(context)}"
//                                                             : "Select Start Time",
//                                                       ),
//                                                       trailing: const Icon(
//                                                           Icons.access_time),
//                                                       onTap: () =>
//                                                           _selectTime(
//                                                               day, true),
//                                                     ),
//                                                     ListTile(
//                                                       title: Text(
//                                                         dayInfo.endTime !=
//                                                                 null
//                                                             ? "End: ${dayInfo.endTime!.format(context)}"
//                                                             : "Select End Time",
//                                                       ),
//                                                       trailing: const Icon(
//                                                           Icons.access_time),
//                                                       onTap: () =>
//                                                           _selectTime(
//                                                               day, false),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ]
//                                           : [],
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context)
//                                     .pop(); // Close the dialog
//                               },
//                               child: const Text('Done'),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//
//       // Container(
//       //   margin: EdgeInsets.symmetric(horizontal: 10.w),
//       //   width: double.infinity,
//       //   child: ElevatedButton(
//       //     onPressed: () async {
//       //       File? temp = await ImageFunctions.CameraPicker();
//       //       if (temp != null) {
//       //         pickedImage = temp;
//       //       }
//       //       setState(() {});
//       //     },
//       //     child: Text(
//       //       "Upload Deploma Image",
//       //       style: TextStyle(fontSize: 20.sp, color: Colors.white),
//       //     ),
//       //     style: ButtonStyle(
//       //         backgroundColor: WidgetStatePropertyAll(Colors.blue),
//       //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//       //             borderRadius: BorderRadius.circular(15.r))),
//       //         padding: WidgetStatePropertyAll(
//       //             EdgeInsets.symmetric(vertical: 10.h))),
//       //   ),
//       // ),
//       // SizedBox(height: 20.h,),
//       // CircleAvatar(
//       //   backgroundImage:
//       //       pickedImage == null ? null : FileImage(pickedImage!),
//       // ),
//       // Container(
//       //   margin: EdgeInsets.symmetric(horizontal: 10.w),
//       //   width: double.infinity,
//       //   child: ElevatedButton(
//       //     onPressed: () async {
//       //       List<File>? temps = await ImageFunctions.galleryPickers();
//       //       if (temps != null) {
//       //         pickedImages = temps;
//       //       }
//       //       setState(() {});
//       //     },
//       //     child: Text(
//       //       "Upload protofile Images",
//       //       style: TextStyle(fontSize: 20.sp, color: Colors.white),
//       //     ),
//       //     style: ButtonStyle(
//       //         backgroundColor: WidgetStatePropertyAll(Colors.blue),
//       //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//       //             borderRadius: BorderRadius.circular(15.r))),
//       //         padding: WidgetStatePropertyAll(
//       //             EdgeInsets.symmetric(vertical: 10.h))),
//       //   ),
//       // ),
//       // Row(children: List.generate(3, (index){
//       //   return Padding(
//       //     padding: const EdgeInsets.all(8.0),
//       //     child: CircleAvatar(
//       //         backgroundImage: pickedImages!=null && pickedImages!.length>index?FileImage(pickedImages![index]):null,
//       //         child: pickedImages==null||pickedImages!.length<=index?Icon(Icons.image,size: 30.sp,color: Colors.blue,):null),
//       //   );
//       // }),),
//       //  SizedBox(height: 20.h,),
//       //  Container(
//       //    margin: EdgeInsets.symmetric(horizontal: 10.w),
//       //    width: double.infinity,
//       //    child: ElevatedButton(
//       //      onPressed: () {
//       //        Navigator.of(context).pushNamed(UploadProfileImage.routeName);
//       //      },
//       //      child: Text(
//       //        "Next >>",
//       //        style: TextStyle(color: Colors.white, fontSize: 18.sp),
//       //      ),
//       //      style: ButtonStyle(
//       //          backgroundColor: WidgetStatePropertyAll(Colors.blue),
//       //          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//       //              borderRadius: BorderRadius.circular(15.r))),
//       //          padding: WidgetStatePropertyAll(
//       //              EdgeInsets.symmetric(vertical: 10.h))),
//       //    ),
//       //  ),
//       //  SizedBox(height: 20.h,),
//     ],),),
//     );
//   }
// }
