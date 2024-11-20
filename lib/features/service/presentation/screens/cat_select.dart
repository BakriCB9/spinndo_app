// import 'package:flutter/material.dart';
//
// class FilterScreen extends StatefulWidget {
//   static const String routeName = '/filter';
//   @override
//   _FilterScreenState createState() => _FilterScreenState();
// }
//
// class _FilterScreenState extends State<FilterScreen> {
//   RangeValues _priceRange = RangeValues(1299, 3999);
//   double _discount = 50.0;
//   List<String> brands = ["Philips", "Sony", "JBL", "Headphones", "Sennheiser", "Motorola", "zebronics", "ball"];
//   String? selectedBrand;
//   List<String> features = ["Wireless", "Sports", "Noise canceling", "With microphone", "Tangle free cord"];
//   List<String> selectedFeatures = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.blue.shade50, Colors.blue.shade100],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text("Filters"),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.check),
//               onPressed: () {
//                 // Apply the filters
//                 print("Filters applied");
//               },
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.attach_money, color: Colors.blue),
//                   SizedBox(width: 8),
//                   Text("Price Range", style: Theme.of(context).textTheme.titleMedium),
//                 ],
//               ),            SizedBox(height: 8),
//               RangeSlider(
//                 values: _priceRange,
//                 min: 0,
//                 max: 5000,
//                 divisions: 100,
//                 labels: RangeLabels(
//                   "\$${_priceRange.start.toInt()}",
//                   "\$${_priceRange.end.toInt()}",
//                 ),
//                 onChanged: (RangeValues values) {
//                   setState(() {
//                     _priceRange = values;
//                   });
//                 },
//               ),
//               Text("\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}"),
//               SizedBox(height: 16),
//               Text("Discount", style: Theme.of(context).textTheme.headlineMedium),
//               SizedBox(height: 8),
//               SliderTheme(
//                 data: SliderTheme.of(context).copyWith(
//                   activeTrackColor: Colors.blue,
//                   inactiveTrackColor: Colors.blue.withOpacity(0.2),
//                   thumbColor: Colors.blue,
//                   overlayColor: Colors.blue.withOpacity(0.3),
//                   thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
//                   overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
//                 ),
//                 child: Slider(
//                   value: _discount,
//                   min: 0,
//                   max: 100,
//                   divisions: 100,
//                   label: "${_discount.toInt()}%",
//                   onChanged: (value) {
//                     setState(() {
//                       _discount = value;
//                     });
//                   },
//                 ),
//               ),
//
//               Text("${_discount.toInt()}%"),
//               SizedBox(height: 16),
//               Text("Brand", style: Theme.of(context).textTheme.headlineMedium),
//               SizedBox(height: 8),
//           Wrap(
//             spacing: 8,
//             children: features.map((feature) {
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     if (selectedFeatures.contains(feature)) {
//                       selectedFeatures.remove(feature); // Deselect feature
//                     } else {
//                       selectedFeatures.add(feature); // Select feature
//                     }
//                   });
//                 },
//                 child: AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: selectedFeatures.contains(feature)
//                         ? Colors.blue
//                         : Colors.grey[200],
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: Text(
//                     feature,
//                     style: TextStyle(
//                       color: selectedFeatures.contains(feature)
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//               SizedBox(height: 16),
//               ExpansionTile(
//                 title: Text("Features"),
//                 children: [
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: features.map((feature) {
//                       return FilterChip(
//                         label: Text(feature),
//                         selected: selectedFeatures.contains(feature),
//                         onSelected: (bool selected) {
//                           setState(() {
//                             if (selected) {
//                               selectedFeatures.add(feature);
//                             } else {
//                               selectedFeatures.remove(feature);
//                             }
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: 16),
//               Divider(),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   color: Colors.white,
//                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           // Reset filters
//                           setState(() {
//                             _priceRange = RangeValues(1299, 3999);
//                             _discount = 50.0;
//                             selectedBrand = null;
//                             selectedFeatures.clear();
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.grey[300],
//                           foregroundColor: Colors.black,
//                         ),
//                         child: Text("Reset All"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Apply filters
//                           print("Filters applied");
//                         },
//                         child: Text("Apply"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               FloatingActionButton.extended(
//                 onPressed: () {
//                   // Apply filters
//                   print("Filters applied");
//                   showModalBottomSheet( backgroundColor: Colors.white,
//                     context: context,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                     ),
//                     isScrollControlled: true,
//                     builder: (context) {
//                       return FilterBottomSheet();
//                     },
//                   );
//                 },
//                 label: Text("Apply"),
//                 icon: Icon(Icons.check),
//                 backgroundColor: Colors.blue,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FilterBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//
//       initialChildSize: 0.7, // Adjust as needed
//       maxChildSize: 0.9,
//       minChildSize: 0.5,
//       expand: false,
//       builder: (_, scrollController) {
//         return Column(
//           children: [
//             // Header with Tabs
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Filters & Sort',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'Cars',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(thickness: 1),
//             Expanded(
//               child: ListView(
//                 controller: scrollController,
//                 children: [
//                   // Example Categories
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text('Popular Brands'),
//                   ),
//                   CheckboxListTile(
//                     title: Text('Hyundai'),
//                     value: true,
//                     onChanged: (val) {},
//                   ),
//                   CheckboxListTile(
//                     title: Text('Toyota'),
//                     value: false,
//                     onChanged: (val) {},
//                   ),
//                   // Add more items here
//                 ],
//               ),
//             ),
//             // Bottom Buttons
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {},
//                       child: Text('Reset All'),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('Apply'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const String routeName = '/filter';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _distance = 10.0;
  List<String> category = [
    "Doctor",
    "Barber",
    "Service",
    "Coach",
    "art",
    "teacher",
    "loyal",
    "fixer"
  ];
  String? selectedBrand;
  List<String> country = [
    "Current Location",
    "Germany",
    "Syria",
    "Saudi",
    "UAE",
    "USA",
    "China",
    "Egypt"
  ];
  String? selectedCountry;
  List<String> subCategory = [
    "math teacher",
    "science teacher",
    "art teacher",
    "english teacher",
    "arabic teacher"
  ];
  List<String> selectedFeatures = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.blue,
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Apply the filters
              print("Filters applied");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Categories",
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: category.map((brand) {
                return ChoiceChip(
                  backgroundColor: Colors.grey.shade300,
                  selectedColor: Colors.blue,
                  elevation: 20,
                  side: BorderSide.none,
                  showCheckmark: false,
                  label: Text(
                    brand,
                    style: TextStyle(
                        color: selectedBrand == brand
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: selectedBrand == brand,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedBrand = selected ? brand : null;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            selectedBrand != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sub Category",
                          style: Theme.of(context).textTheme.headlineMedium),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: subCategory.map((feature) {
                          return FilterChip(
                            backgroundColor: Colors.grey.shade300,
                            selectedColor: Colors.blue,
                            elevation: 20,
                            side: BorderSide.none,
                            showCheckmark: false,
                            label: Text(feature, style: TextStyle(
                                color:  selectedFeatures.contains(feature)
                                    ? Colors.white
                                    : Colors.black),),
                            selected: selectedFeatures.contains(feature),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedFeatures.add(feature);
                                } else {
                                  selectedFeatures.remove(feature);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 16),
            Text("Countries",
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: country.map((countr) {
                return ChoiceChip(
                  backgroundColor: Colors.grey.shade300,
                  selectedColor: Colors.blue,
                  elevation: 20,
                  side: BorderSide.none,
                  showCheckmark: false,
                  label: Text(
                    countr,
                    style: TextStyle(
                        color: selectedCountry == countr
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: selectedCountry == countr,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedCountry = selected ? countr : null;
                    });
                  },
                );
              }).toList(),
            ),
            Text("Distance", style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
 selectedCountry==country[0]?Column(crossAxisAlignment: CrossAxisAlignment.start,
   children: [           Slider(
     activeColor: Colors.blue,
     inactiveColor: Colors.grey.shade300,
     value: _distance,
     min: 0,
     max: 25,
     divisions: 5,
     label: "${_distance.toInt()}%",
     onChanged: (value) {
       setState(() {
         _distance = value;
       });
     },
   ),
     Text("${_distance.toInt()}km"),
     SizedBox(height: 16),],
 ):SizedBox(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Reset filters
                    setState(() {
                      _distance = 10.0;
                      selectedBrand = null;
                      selectedFeatures.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Reset All"),
                ),
                ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    // Apply filters
                    print("Filters applied");
                  },
                  child: Text("Apply",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
