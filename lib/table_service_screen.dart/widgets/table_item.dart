import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_service/data/models/service_table.dart';
import 'package:table_service/table_details_screen/table_details_screen.dart';
import 'package:table_service/table_service_screen.dart/cubit/table_orders_cubit.dart';

class TableItem extends StatelessWidget {
  const TableItem(this.table, {super.key});

  final ServiceTable table;

  @override
  Widget build(BuildContext context) {
    final order = context.select((TableOrdersCubit cubit) => cubit.orderItem);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TableDetailsScreen(
            table: table,
            order: order,
          ),
        ));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      table.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<TableOrdersCubit, TableOrdersState>(
                      builder: (context, state) {
                        if (state is TableOrdersInitial) {
                          BlocProvider.of<TableOrdersCubit>(context)
                              .loadTableOpenedOrder(table.id);
                        } else if (state is TableOrdersLoaded) {
                          return Text(state.orderItem.waiter);
                        } else if (state is NoTableOrders) {
                          return const SizedBox();
                        } else {
                          return const Center(
                            child: Text("error"),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<TableOrdersCubit, TableOrdersState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: state.tableColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (table.timeServed != null) Text(table.getTimeServed!),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
