//import 'package:newsapp/repositories/post/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/models/Product.dart';
import 'package:kamelshop/logic/repository/products_api.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  @override
  SearchStates get initialState => SearchLoadingState1();

  ProductsAPI repo;
  //AuthorsAPI aurepo ;
  SearchBloc(SearchStates initialState, this.repo) : super(initialState);
  @override
  Stream<SearchStates> mapEventToState(SearchEvents event) async* {
    if (event is FindEvent) {
      yield SearchLoadingState1();
      try {
        var products = await repo.searchProducts(event.key);
        // var authors= await aurepo.fetchAllAuthors();
        //yield authbloc.mapEventToState(DoFetchEvent);
        yield FindState(products: products);
        print(products);
      } catch (e) {
        yield SearchErrorState1(message: e.toString());
      }
    }
  }
}

//events
class SearchEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FindEvent extends SearchEvents {
  String key;
  FindEvent({required this.key});
}

// states
class SearchStates extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitialState1 extends SearchStates {}

class SearchLoadingState1 extends SearchStates {}

class SearchErrorState1 extends SearchStates {
  String message;
  SearchErrorState1({required this.message});
}

class FindState extends SearchStates {
  List<Product> products;
  FindState({required this.products});
}
