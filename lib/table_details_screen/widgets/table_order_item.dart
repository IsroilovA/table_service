import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_service/data/models/order_item.dart';
import 'package:table_service/table_details_screen/cubit/table_details_cubit.dart';

class TableOrderedItem extends StatefulWidget {
  const TableOrderedItem(this.orderedItem, {super.key});

  final OrderItem orderedItem;

  @override
  State<TableOrderedItem> createState() => _TableOrderedItemState();
}

class _TableOrderedItemState extends State<TableOrderedItem> {
  bool isModifiying = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              isModifiying = !isModifiying;
            });
          },
          horizontalTitleGap: 0,
          leadingAndTrailingTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.blue),
          leading: Text(
            "${widget.orderedItem.quantity}*",
          ),
          title: Text(widget.orderedItem.product.name),
          trailing: Text(
            widget.orderedItem.product.getPrice,
          ),
        ),
        if (isModifiying)
          Row(
            children: [
              IconButton.outlined(
                  onPressed: () {
                    BlocProvider.of<TableDetailsCubit>(context)
                        .changeOrderItemQuantity(
                      orderItem: widget.orderedItem,
                      isPlus: false,
                    );
                  },
                  icon: Icon(widget.orderedItem.quantity == 1
                      ? Icons.delete_outline
                      : Icons.remove)),
              const SizedBox(width: 5),
              Text(
                widget.orderedItem.quantity.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 5),
              IconButton.outlined(
                  onPressed: () {
                    BlocProvider.of<TableDetailsCubit>(context)
                        .changeOrderItemQuantity(
                      orderItem: widget.orderedItem,
                      isPlus: true,
                    );
                  },
                  icon: const Icon(Icons.add)),
            ],
          )
      ],
    );
  }
}
