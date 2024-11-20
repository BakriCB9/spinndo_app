import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget {
  @override
  static const String routeName = '/service';
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String searchMode = "Current Location"; // Default option
  String fuelType = "Diesel"; // Default option
  double distance = 10; // Default distance
  String brand = "All brands"; // Default brand
  bool nowOpen = false;
  bool onlyPublic = false;
  bool rydPayPossible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search Mode',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Radio<String>(
                      value: "Current Location",
                      groupValue: searchMode,
                      onChanged: (value) {
                        setState(() {
                          searchMode = value!;
                        });
                      },
                    ),
                    title: Text("Current Location"),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Radio<String>(
                      value: "Zip, City or Address",
                      groupValue: searchMode,
                      onChanged: (value) {
                        setState(() {
                          searchMode = value!;
                        });
                      },
                    ),
                    title: Text("Zip, City or Address"),
                  ),
                ),
              ],
            ),
            if (searchMode == "Current Location")
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: "Current Location",
                  suffixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
            if (searchMode == "Zip, City or Address")
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter Zip, City, or Address",
                  border: OutlineInputBorder(),
                ),
              ),
            SizedBox(height: 16),
            Text(
              'Fuel Type',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: fuelType,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: ["Diesel", "Petrol", "Electric"]
                  .map((e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  fuelType = value!;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Distance',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: distance,
              min: 1,
              max: 50,
              divisions: 49,
              label: "${distance.toInt()} Kilometers",
              onChanged: (value) {
                setState(() {
                  distance = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Brands',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: brand,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: ["All brands", "Brand A", "Brand B", "Brand C"]
                  .map((e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  brand = value!;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'More Filters',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            SwitchListTile(
              title: Text("Now open"),
              value: nowOpen,
              onChanged: (value) {
                setState(() {
                  nowOpen = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("Only public"),
              value: onlyPublic,
              onChanged: (value) {
                setState(() {
                  onlyPublic = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("RYD Pay Possible"),
              value: rydPayPossible,
              onChanged: (value) {
                setState(() {
                  rydPayPossible = value;
                });
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle search logic here
                print("Search started");
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("Start Search"),
            ),
          ],
        ),
      ),
    );
  }
}
