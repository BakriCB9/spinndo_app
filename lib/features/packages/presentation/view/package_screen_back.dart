import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/packages_cubit.dart';
import '../view_model/packages_state.dart';

class PackagesScreen extends StatefulWidget {
  final String token;
  static const String routeName = '/packages';


  const PackagesScreen({Key? key, required this.token}) : super(key: key);

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
      appBar: AppBar(title: Text("Packages")),
      body: BlocBuilder<PackagesCubit, PackagesState>(
        builder: (context, state) {
          if (state is PackagesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PackagesLoaded) {
            return ListView.builder(
              itemCount: state.packages.length,
              itemBuilder: (context, index) {
                final package = state.packages[index];
                return ListTile(
                  title: Text(package?.name ?? ''),
                  subtitle: Text("€${package?.price ?? 0} for ${package?.duration?? 3} days"),
                  trailing: Icon(
                    (package?.is_subscribed??false) ? Icons.check_circle : Icons.cancel,
                    color: (package?.is_subscribed??false) ? Colors.green : Colors.red,
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
