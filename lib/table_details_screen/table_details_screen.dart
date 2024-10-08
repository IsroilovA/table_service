import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_service/data/models/order.dart';
import 'package:table_service/data/models/order_item.dart';
import 'package:table_service/data/models/service_table.dart';
import 'package:table_service/table_details_screen/cubit/table_details_cubit.dart';
import 'package:table_service/table_details_screen/widgets/table_menu.dart';
import 'package:table_service/table_details_screen/widgets/table_order_item.dart';

class TableDetailsScreen extends StatefulWidget {
  const TableDetailsScreen({super.key, this.order, required this.table});

  final Order? order;
  final ServiceTable table;
  @override
  State<TableDetailsScreen> createState() => _TableDetailsScreenState();
}

class _TableDetailsScreenState extends State<TableDetailsScreen> {
  List<OrderItem> _orderedItems = [];

  late Order _order;

  @override
  void initState() {
    if (widget.order == null) {
      _order =
          Order(table: widget.table, waiter: "Sarah", status: Status.opened);
    } else {
      _order = widget.order!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.table.name),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<TableDetailsCubit>(context)
                    .saveChanges(context, widget.order);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      bottomSheet: BottomSheet(
        enableDrag: false,
        elevation: 2,
        onClosing: () {},
        builder: (context) {
          return TableMenu(
            onTap: (product) {
              BlocProvider.of<TableDetailsCubit>(context)
                  .addOrderItem(_order, product);
            },
          );
        },
      ),
      body: BlocBuilder<TableDetailsCubit, TableDetailsState>(
          builder: (context, state) {
        if (state is TableDetailsInitial) {
          BlocProvider.of<TableDetailsCubit>(context).loadOrderItems(_order.id);
        } else if (state is TableDetailsLoaded) {
          _orderedItems = state.orderItems;
        } else if (state is TableDetailsError) {
          return Center(child: Text(state.message!));
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _orderedItems.length,
          itemBuilder: (context, index) {
            return TableOrderedItem(_orderedItems[index]);
          },
        );
      }),
    );
  }
}
