// import 'package:app/features/service/data/models/get_package_reponse/get_package_reponse.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/di/service_locator.dart';
// import '../../domain/package_intity.dart';
// import '../view_model/packages_cubit.dart';
// import '../view_model/packages_state.dart';
//
// class PackagesScreen extends StatefulWidget {
//   const PackagesScreen({super.key});
//   static const String routeName = 'packages';
//
//   @override
//   State<PackagesScreen> createState() => _PackagesScreenState();
// }
//
// class _PackagesScreenState extends State<PackagesScreen> {
//   final packageCubit = serviceLocator.get<PackagesCubit>();
//
//   @override
//   void initState() {
//     super.initState();
//     packageCubit.getAllPackages();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Available Packages'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//         child: BlocBuilder<PackagesCubit, PackagesState>(
//           bloc: packageCubit,
//           builder: (context, state) {
//             if (state is PackagesLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is PackagesError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(state.message),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: packageCubit.getAllPackages,
//                       child: const Text('Retry'),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is PackagesSuccess) {
//               if (state.listOffPackages.isEmpty) {
//                 return const Center(child: Text('No packages available'));
//               }
//               return ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: state.listOffPackages.length,
//                 itemBuilder: (context, index) {
//                   final package = state.listOffPackages[index];
//                   return _buildPackageCard(package);
//                 },
//               );
//             } else {
//               return const SizedBox.shrink();
//             }
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: packageCubit.getAllPackages,
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
//
//   Widget _buildPackageCard(PackageData package) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               package.name,
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             // const SizedBox(height: 8),
//             // Text(package.description),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Price: \$${package.price.toStringAsFixed(2)}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Duration: ${package.duration} month',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // اختيار الباقة
//                 },
//                 child: const Text('Select Package'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
