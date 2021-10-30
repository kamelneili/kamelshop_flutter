//import 'package:newsapp/repositories/post/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/models/Cart.dart';
import 'package:kamelshop/logic/repository/cart_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  @override
  CartStates get initialState => CartLoadingState();

  CartAPI repo;
  CartBloc(CartStates initialState, this.repo) : super(initialState);
  @override
  Stream<CartStates> mapEventToState(CartEvents event) async* {
    if (event is AddEvent) {
      Future.delayed(Duration(seconds: 1), () async* {
        yield CartLoadingState();
      });
      try {
        await repo.addProductToCart(event.id);
        print(event.id);
        yield AddSuccess();
      } catch (e) {
        yield ErrorState1(message: e.toString());
      }
    } else
//
    if (event is RemoveEvent) {
      //print(event.id);
      Future.delayed(Duration(seconds: 1), () async* {
        yield CartLoadingState();
      });
      try {
        await repo.removeProductToCart(event.id);
        yield RemoveSuccess();
      } catch (e) {
        yield ErrorState1(message: e.toString());
      }
    } else
//
    if (event is DoFetchCartItemsEvent) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      Future.delayed(Duration(seconds: 1), () async* {
        yield CartLoadingState();
      });
      //authbloc.add(DoFetchEvent());
      try {
        var cart = await repo.fetchCart(token!);
        print(cart);
        // var authors= await aurepo.fetchAllAuthors();
        //yield authbloc.mapEventToState(DoFetchEvent);
        yield CartItemFetchSuccess(cart: cart!);
      } catch (e) {
        yield ErrorState1(message: e.toString());
      }
    }
  }
}
// Future.delayed(Duration(seconds: 1), () {
//               return Center(child: CircularProgressIndicator());
//             });

// events
class CartEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class AddEvent extends CartEvents {
  String id;
  AddEvent({required this.id});
}

class RemoveEvent extends CartEvents {
  String id;
  RemoveEvent({required this.id});
}

class DoFetchCartItemsEvent extends CartEvents {}

// states
class CartStates extends Equatable {
  @override
  List<Object> get props => [];
}

class CartItemFetchSuccess extends CartStates {
  Cart cart;

  CartItemFetchSuccess({required this.cart});
}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class AddSuccess extends CartStates {}

class RemoveSuccess extends CartStates {}

class ErrorState1 extends CartStates {
  String message;
  ErrorState1({required this.message});
}
