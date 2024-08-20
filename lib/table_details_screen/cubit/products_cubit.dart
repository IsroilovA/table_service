import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:table_service/data/models/product.dart';
import 'package:table_service/services/table_service_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required TableServiceRepository tableServiceRepository})
      : _tableServiceRepository = tableServiceRepository,
        super(ProductsInitial());

  final TableServiceRepository _tableServiceRepository;

  void loadProducts() async {
    emit(ProductsLoading());
    try {
      final products = await _tableServiceRepository.getAllProducts();
      if (products == null) {
        emit(NoProducts());
      } else {
        emit(ProductsLoaded(products));
      }
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
