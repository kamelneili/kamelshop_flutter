//import 'package:newsapp/repositories/post/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/models/Product.dart';

import 'package:kamelshop/logic/models/category.dart';
import 'package:kamelshop/logic/repository/categories_api.dart';

class CategoryBloc extends Bloc<CategoryEvents, CategoryStates> {
  @override
  CategoryStates get initialState => CatLoadingState1();
  late Category category;

  CategoriesAPI repo;
  //AuthorsAPI aurepo ;
  CategoryBloc(CategoryStates initialState, this.repo) : super(initialState);
  @override
  Stream<CategoryStates> mapEventToState(CategoryEvents event) async* {
    if (event is CatDoFetchEvent1) {
      Future.delayed(Duration(seconds: 1), () async* {
        yield CatLoadingState1();
      });
      var categories = await repo.fetchCategories();
      yield CatFetchSuccess1(categories: categories);
    } else if (event is CatDoFetchProductsEvent1) {
      Future.delayed(Duration(seconds: 1), () async* {
        yield CatLoadingState1();
      });
      try {
        print("here's the data : ${event.category}");

        //  CatDoFetchProductsEvent1(category: category);

        print(event.category);
        var products = await repo.fetchPostsCategory(event.category);
        print(products);
        // var authors= await aurepo.fetchAllAuthors();
        //yield authbloc.mapEventToState(DoFetchEvent);
        yield CatProductsFetchSuccess1(products: products);
      } catch (e) {
        yield CatErrorState1(message: e.toString());
      }
    }
  }
}

// events
class CategoryEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class CatDoFetchEvent1 extends CategoryEvents {}

class CatDoFetchProductsEvent1 extends CategoryEvents {
  Category category;

  CatDoFetchProductsEvent1({required this.category});
}

// states
class CategoryStates extends Equatable {
  @override
  List<Object> get props => [];
}

class CatInitialState1 extends CategoryStates {}

class CatProductsInitialState1 extends CategoryStates {}

class CatLoadingState1 extends CategoryStates {}

class CatProductsLoadingState1 extends CategoryStates {}

class CatFetchSuccess1 extends CategoryStates {
  List<Category> categories;
  //List<Category> authors;

  CatFetchSuccess1({required this.categories});
}

class CatProductsFetchSuccess1 extends CategoryStates {
  List<Product> products;
  //List<Category> authors;

  CatProductsFetchSuccess1({required this.products});

  @override
  String toString() => 'CatProductsFetchSuccess1(products: $products)';
}

class CatErrorState1 extends CategoryStates {
  String message;
  CatErrorState1({required this.message});
}
