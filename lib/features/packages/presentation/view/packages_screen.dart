// import 'package:app/features/packages/presentation/view/package_details.dart';
// import 'package:flutter/material.dart';
//
// import '../../../service/data/models/get_package_reponse/get_package_reponse.dart';
//
// class PackagesScreen extends StatefulWidget {
//   const PackagesScreen({super.key});
//
//   static const String routeName = 'packages';
//
//   @override
//   State<PackagesScreen> createState() => _PackagesScreenState();
// }
//
// class _PackagesScreenState extends State<PackagesScreen> {
//   @override
//   bool select1=false;
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Package Details'),
//         centerTitle: true,
//         backgroundColor: Colors.yellow[700],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
//         child: _buildPackageDetails(),
//       ),
//     );
//   }
//
//   Widget _buildPackageDetails() {
//     // بيانات الباقة الثابتة
//     final package = PackageData(
//       id: '1',
//       name: 'Basic Plan',
//       price: 9,
//       duration: 3,
//       is_subscribed: true,
//     );
//
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                 builder: (context) => PackageDetails(), // قم بتحديد الصفحة التي تريد الانتقال إليها
//             ),
//             );
//           },
//           child: Card(
//             color: Colors.yellow[50],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             margin: const EdgeInsets.only(bottom: 16),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     package.name,
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.black),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(package.name),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Price: \$${package.price.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       Text(
//                         'Duration: ${package.duration} days',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PackageDetails(), // قم بتحديد الصفحة التي تريد الانتقال إليها
//               ),
//             );
//           },
//           child: Card(
//             elevation: 4,
//             color: Colors.yellow[50],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             margin: const EdgeInsets.only(bottom: 16),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Premium Plan",
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.black),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(package.name),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Price: \$10',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       Text(
//                         'Duration: 5 days',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
