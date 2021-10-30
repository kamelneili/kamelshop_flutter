//import 'package:newsapp/repositories/post/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/models/Product.dart';
import 'package:kamelshop/logic/repository/products_api.dart';

class ProductBloc extends Bloc<ProductEvents, ProductStates> {
  @override
  ProductStates get initialState => LoadingState1();

  ProductsAPI repo;
  //AuthorsAPI aurepo ;
  ProductBloc(ProductStates initialState, this.repo) : super(initialState);
  @override
  Stream<ProductStates> mapEventToState(ProductEvents event) async* {
    if (event is DoFetchEvent1) {
      Future.delayed(Duration(seconds: 1), () async* {
        yield LoadingState1();
      });
      //authbloc.add(DoFetchEvent());
      try {
        var products = await repo.fetchPosts();
        //print(products);
        // var authors= await aurepo.fetchAllAuthors();
        //yield authbloc.mapEventToState(DoFetchEvent);
        yield FetchSuccess1(products: products);
      } catch (e) {
        yield ErrorState1(message: e.toString());
      }
    }
  }
}

// events
class ProductEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class DoFetchEvent1 extends ProductEvents {}

// states
class ProductStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState1 extends ProductStates {}

class LoadingState1 extends ProductStates {}

class FetchSuccess1 extends ProductStates {
  List<Product> products;

  FetchSuccess1({required this.products});
}

class ErrorState1 extends ProductStates {
  String message;
  ErrorState1({required this.message});
}
