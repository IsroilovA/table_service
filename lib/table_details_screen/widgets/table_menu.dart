import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_service/data/models/product.dart';
import 'package:table_service/services/locator.dart';
import 'package:table_service/services/table_service_repository.dart';
import 'package:table_service/table_details_screen/cubit/products_cubit.dart';
import 'package:table_service/table_details_screen/widgets/product_item.dart';

class TableMenu extends StatelessWidget {
  const TableMenu({super.key, required this.onTap});

  final void Function(Product product) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Menu",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocProvider(
            create: (context) => ProductsCubit(
                tableServiceRepository: locator<TableServiceRepository>()),
            child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsInitial) {
                  BlocProvider.of<ProductsCubit>(context).loadProducts();
                } else if (state is ProductsLoaded) {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: state.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                      ),
                      itemBuilder: (context, index) {
                        return ProductItem(
                          product: state.products[index],
                          onTap: onTap
                        );
                      },
                    ),
                  );
                } else if (state is NoProducts) {
                  return const Center(child: Text("No Products found"));
                } else if (state is ProductsError) {
                  return Center(child: Text(state.message!));
                }
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              },
            ),
          ),
        ],
      ),
    );
  }
}
