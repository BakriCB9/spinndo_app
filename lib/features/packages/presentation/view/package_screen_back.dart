import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/di/service_locator.dart'; // ✅ هذا السطر هو الحل

import '../view_model/packages_cubit.dart';
import '../view_model/packages_state.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PackagesCubit>()..getAllPackages(),
      child: Scaffold(
        appBar: AppBar(title: const Text("الباقات")),
        body: BlocBuilder<PackagesCubit, PackagesState>(
          builder: (context, state) {
            if (state is PackagesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PackagesError) {
              return Center(child: Text("حدث خطأ: ${state.message}"));
            } else if (state is PackagesSuccess) {
              final packages = state.packages;
              return ListView.builder(
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  final package = packages[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(package.name),
                      subtitle: Text(
                        "السعر: \$${package.price} | المدة: ${package.duration} يوم",
                      ),
                      trailing: package.is_subscribed
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.radio_button_unchecked),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
