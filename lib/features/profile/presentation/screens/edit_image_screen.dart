import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/const_variable.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({super.key});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  List<onLongClick> listonClick = [onLongClick(), onLongClick(), onLongClick()];
  var ans = false;
  bool isAbleToEdit = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ans = false;
    for (int i = 0; i < listonClick.length; i++) {
      if (listonClick[i].isClicked) {
        ans = true;
      }
    }
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: ans ? [Icon(Icons.delete)] : null,
        title: Text('Edit your gallery'),
        iconTheme: IconThemeData(color: Colors.white),
        leading: ans
            ? IconButton(
                onPressed: () {
                  isAbleToEdit = false;
                  ans = false;
                  for (int i = 0; i < listonClick.length; i++) {
                    listonClick[i].isClicked = false;
                  }
                  setState(() {});
                },
                icon: Icon(Icons.cancel))
            : IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.height * 0.03),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: listImage.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: size.height * 0.02,
                    crossAxisSpacing: size.width * 0.02),
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      isAbleToEdit = true;
                      setState(() {});
                    },
                    child: isAbleToEdit
                        ? Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  color: Colors.green,
                                  child: Image.asset(
                                    listImage[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: InkWell(
                                    onTap: () {
                                      listonClick[index].isClicked =
                                          !listonClick[index].isClicked;

                                      setState(() {});
                                    },
                                    child: Container(
                                      width: size.width * 0.06,
                                      height: size.width * 0.06,
                                      decoration: BoxDecoration(
                                          color: listonClick[index].isClicked
                                              ? Colors.blue
                                              : Colors.transparent,
                                          border: Border.all(),
                                          shape: BoxShape.circle),
                                      child: listonClick[index].isClicked
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  )),
                            ],
                          )
                        : AspectRatio(
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
  int indexItem = 0;
  onLongClick();
}
