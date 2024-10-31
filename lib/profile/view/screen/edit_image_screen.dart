import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/shared/const_variable.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({super.key});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  List<onLongClick> listonClick = [onLongClick(),onLongClick(),onLongClick()];
  var ans=false;
  @override
  void initState() {
    // for (int i = 0; i < listImage.length; i++) {
    //   listonClick[i] = onLongClick();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   for(int i=0;i<listonClick.length;i++)
   {
    if(listonClick[i].isClicked)
    {ans=true;}
   } 
    return Scaffold(
      appBar: AppBar(
      actions:ans? [
        Icon(Icons.delete)
       ]:null,
        title: Text('Edit your gallery'),
        iconTheme: IconThemeData(color: Colors.white),
             
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: listImage.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      listonClick[index].isClicked = true;
                      print('ddddd');
                      setState(() {
                        
                      });
                      
                    },
                    child: 
                      listonClick[index].isClicked?   Stack(
                            alignment: Alignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(listImage[index],fit: BoxFit.cover,),
                              ),
                              Container(color: Colors.black.withOpacity(0.4),),
                              Container(child: Text('${index+1}',style: TextStyle(fontSize: 40.sp,color: Colors.white),),)
                            ],
                          )
                        :
                        AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              listImage[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class onLongClick {
  bool isClicked = false;
  onLongClick();
}
