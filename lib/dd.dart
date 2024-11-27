import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _priceRange = RangeValues(1299, 3999);
  double _discount = 50.0;
  List<String> brands = ["Philips", "Sony", "JBL", "Headphones", "Sennheiser", "Motorola", "zebronics", "ball"];
  String? selectedBrand;
  List<String> features = ["Wireless", "Sports", "Noise canceling", "With microphone", "Tangle free cord"];
  List<String> selectedFeatures = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Text("Price Range", style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 8),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 5000,
              divisions: 100,
              labels: RangeLabels(
                "\$${_priceRange.start.toInt()}",
                "\$${_priceRange.end.toInt()}",
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            Text("\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}"),
            SizedBox(height: 16),
            Text("Discount", style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 8),
            Slider(
              value: _discount,
              min: 0,
              max: 100,
              divisions: 100,
              label: "${_discount.toInt()}%",
              onChanged: (value) {
                setState(() {
                  _discount = value;
                });
              },
            ),
            Text("${_discount.toInt()}%"),
            SizedBox(height: 16),
            Text("Brand", style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: brands.map((brand) {
                return ChoiceChip(
                  label: Text(brand),
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
            Text("Features", style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: features.map((feature) {
                return FilterChip(
                  label: Text(feature),
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
            SizedBox(height: 16),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Reset filters
                    setState(() {
                      _priceRange = RangeValues(1299, 3999);
                      _discount = 50.0;
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
                ElevatedButton(
                  onPressed: () {
                    // Apply filters
                    print("Filters applied");
                  },
                  child: Text("Apply"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: FilterScreen(),
  ));
}
