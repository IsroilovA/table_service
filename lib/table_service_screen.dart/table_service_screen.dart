import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_service/services/locator.dart';
import 'package:table_service/services/table_service_repository.dart';
import 'package:table_service/table_service_screen.dart/cubit/table_service_cubit.dart';
import 'package:table_service/table_service_screen.dart/widgets/table_item.dart';

class TableServiceScreen extends StatelessWidget {
  const TableServiceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableServiceCubit(
          tableServiceRepository: locator<TableServiceRepository>()),
      child: BlocBuilder<TableServiceCubit, TableServiceState>(
        builder: (context, state) {
          if (state is TableServiceInitial) {
            BlocProvider.of<TableServiceCubit>(context).loadData();
          } else if (state is TableServiceDataLoaded) {
            return GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: state.tables.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 4,
                crossAxisSpacing: 8,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return TableItem(state.tables[index]);
              },
            );
          } else if (state is TableServiceError) {
            return Center(
              child: Text(state.message!),
            );
          } else if (state is TableServiceNoData) {
            return const Center(
              child: Text("No tables found"),
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
