import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/widgets/custom_text_form_field_bakri.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';

class EditJobDetails extends StatelessWidget {
final String categoryName;
final String serviceName;
final String locationName;
final String description;
  const EditJobDetails({required this.categoryName,required this.description, required this.locationName ,required this.serviceName ,super.key});

//final _profileCubit=serviceLocator.get<ProfileCubit>();
  @override
  Widget build(BuildContext context) {
    final _profileCubit=serviceLocator.get<ProfileCubit>();
    final _serviceCubit=serviceLocator.get<ServiceCubit>();
    _profileCubit.descriptionController.text=description;
    _profileCubit.serviceNameController.text=serviceName;

    final indexOfMyCurrentCategory=_serviceCubit.categoriesList?.indexWhere((element) {
     return element.name==categoryName;
    },);
    print('ther index is ${indexOfMyCurrentCategory}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit job details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),
            // CustomTextFromFieldBakri(
            //   label: 'Work',
            //   icon: Icons.work_outline,
            //   initialvalue: 'Doctor',
            // ),
            // SizedBox(height: 30.h),
            // CustomTextFromFieldBakri(
            //   label: 'Title job',
            //   icon: Icons.work_outline,
            //   initialvalue: 'Dentist',
            // ),
            // SizedBox(height: 30.h),
            // CustomTextFromFieldBakri(
            //   label: 'Location',
            //   icon: Icons.location_on_outlined,
            //   initialvalue: 'Doctor',
            // ),
            // SizedBox(
            //   height: 30.h,
            // ),
            // CustomTextFromFieldBakri(
            //   maxlines: 20,
            //   label: 'Description',
            //   icon: Icons.description_outlined,
            //   initialvalue:
            //       'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don'
            //       't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn'
            //       't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // SizedBox(height: 30.h)

            SizedBox(height: 30.h,),
            DropdownButtonFormField(
                menuMaxHeight: 200,
                hint: Text(categoryName,style: TextStyle(fontSize: 25.sp),),
                //style: TextStyle(fontSize: 30.sp,color: Colors.red),
                items:_serviceCubit.categoriesList?.map((e){
              return DropdownMenuItem(value: e.id,child: Text(e.name),);
            }).toList() , onChanged: (value){

            }),
            SizedBox(height: 30.h),

            TextFormField(
              controller: _profileCubit.serviceNameController,
              style: TextStyle(color: Colors.black,fontSize: 25.sp),
              onChanged: (value){
                // _profileCubit.updateInfo(
                //     curEmail: email,
                //     newEmail: _profileCubit.emailEditController.text,
                //     curFirst: firstName,
                //     newFirst: _profileCubit.firstNameEditController.text,
                //     curLast: lastName,
                //     newLast: _profileCubit.lastNameEditController.text
                // );
              },
              decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.person),
                  labelText: 'Title Service',
                  labelStyle: TextStyle(color: Colors.black,fontSize:20.sp )
              ),

            ),
            SizedBox(height: 30.h,),
            TextFormField(

              controller: _profileCubit.descriptionController,
              style: TextStyle(color: Colors.black,fontSize: 25.sp),
              onChanged: (value){

                // _profileCubit.updateInfo(
                //     curEmail: email,
                //     newEmail: _profileCubit.emailEditController.text,
                //     curFirst: firstName,
                //     newFirst: _profileCubit.firstNameEditController.text,
                //     curLast: lastName,
                //     newLast: _profileCubit.lastNameEditController.text
                // );
              },
              decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.person),
                  labelText: "Description",
                  labelStyle: TextStyle(color: Colors.black,fontSize:20.sp )
              ),

            ),
            SizedBox(height: 30.h),
            TextFormField(

              controller: _profileCubit.emailEditController,
              style: TextStyle(color: Colors.black,fontSize: 25.sp),
              onChanged: (value){

                // _profileCubit.updateInfo(
                //     curEmail: email,
                //     newEmail: _profileCubit.emailEditController.text,
                //     curFirst: firstName,
                //     newFirst: _profileCubit.firstNameEditController.text,
                //     curLast: lastName,
                //     newLast: _profileCubit.lastNameEditController.text
                // );
              },
              decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.email),
                  labelText: "Email" ,
                  labelStyle: TextStyle(color: Colors.black,fontSize:20.sp )
              ),

            ),

            SizedBox(height: 50.h,),
            BlocBuilder <ProfileCubit,ProfileStates>(
                buildWhen: (pre,cur){
                  if(cur is IsUpdated || cur is IsNotUpdated)return true; return false;
                },
                builder:(context,state){
                  print('the State is ${state}');

                  if(state is IsUpdated)
                    return  ElevatedButton(onPressed: (){}, child:Text('Save') );
                  else {
                    return const  SizedBox();
                  }
                }

            )
          ],
        ),
      )),
    );
  }
}
