import 'package:flutter/material.dart';
import 'package:table_service/data/models/service_table.dart';

class TableItem extends StatelessWidget {
  const TableItem(this.table, {super.key});
  final ServiceTable table;

  @override
  Widget build(BuildContext context) {
    // Color tableColor = switch (table.getWaiter) {
    //   // Handle this case.
    //   "Sarah" => const Color.fromARGB(255, 218, 105, 143),
    //   // Handle this case.
    //   null => Colors.green,
    //   // Handle this case.
    //   _ => Colors.grey,
    // };

    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => TableDetailsScreen(table),
        //   ),
        // );
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
                  ],
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   // decoration: BoxDecoration(color: tableColor),
            //   child: Row(
            //     mainAxisAlignment: table.getStatus != TableStatus.closed
            //         ? MainAxisAlignment.spaceBetween
            //         : MainAxisAlignment.center,
            //     children: [
            //       Text(table.getNumOfPeople),
            //       if (table.getStatus != TableStatus.closed)
            //         Text(table.getTimeServed!),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
