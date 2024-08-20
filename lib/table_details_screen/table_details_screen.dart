import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_service/data/models/order.dart';
import 'package:table_service/data/models/service_table.dart';
import 'package:table_service/services/locator.dart';
import 'package:table_service/services/table_service_repository.dart';
import 'package:table_service/table_details_screen/cubit/table_details_cubit.dart';
import 'package:table_service/table_details_screen/widgets/table_order_item.dart';

class TableDetailsScreen extends StatefulWidget {
  const TableDetailsScreen({super.key, this.order, required this.table});

  final Order? order;
  final ServiceTable table;
  @override
  State<TableDetailsScreen> createState() => _TableDetailsScreenState();
}

class _TableDetailsScreenState extends State<TableDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.table.name),
      ),
      body: BlocProvider(
        create: (context) => TableDetailsCubit(
            tableServiceRepository: locator<TableServiceRepository>()),
        child: BlocBuilder<TableDetailsCubit, TableDetailsState>(
          builder: (context, state) {
            if (widget.order == null) {
              return const Center(child: Text("No products ordered yet"));
            } else {
              if (state is TableDetailsInitial) {
                BlocProvider.of<TableDetailsCubit>(context)
                    .loadOrderItems(widget.order!.id);
              } else if (state is TableDetailsLoaded) {
                return ListView.builder(
                  itemCount: state.orderItems.length,
                  itemBuilder: (context, index) {
                    return TableOrderedItem(state.orderItems[index]);
                  },
                );
              } else if (state is TableDetailsError) {
                return Center(child: Text(state.message!));
              }
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        ),
      ),
    );
  }
}
