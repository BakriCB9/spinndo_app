import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/packages_cubit.dart';
import '../view_model/packages_state.dart';

class PackagesScreen extends StatefulWidget {
  static const String routeName = '/packages';

  const PackagesScreen({Key? key}) : super(key: key);

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PackagesCubit>().getAllPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Packages"),
        backgroundColor: Colors.yellow[700],
      ),
      body: BlocBuilder<PackagesCubit, PackagesState>(
        builder: (context, state) {
          if (state is PackagesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PackagesSuccess) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.packages.length,
              itemBuilder: (context, index) {
                final package = state.packages[index];
                final isSubscribed = package?.is_subscribed ?? false;
                return InkWell(
                  onTap: (){
                    //
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.black45,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.all(26),
                      child: Row(
                        children: [
                          Icon(
                            isSubscribed ? Icons.check_circle : Icons.cancel,
                            size: 40,
                            color: isSubscribed ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  package?.name ?? '',
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  " Price: ${package?.price ?? 0}€",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Duration: ${package?.duration ?? 3} month",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Subscribed: ${package?.is_subscribed ?? 3}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is PackagesError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
