//import 'package:newsapp/repositories/post/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamelshop/logic/models/order.dart';
import 'package:kamelshop/logic/repository/order_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  @override
  OrderStates get initialState => OrderLoadingState();
  int cartId = 1;
  OrderAPI repo;
  OrderBloc(OrderStates initialState, this.repo) : super(initialState);
  @override
  Stream<OrderStates> mapEventToState(OrderEvents event) async* {
    if (event is AddOrderEvent) {
      //print(event.id);
      yield OrderLoadingState();
      try {
        await repo.addOrder(event.cartId, event.total);
        yield AddSuccess();
      } catch (e) {
        yield ErrorState1(message: e.toString());
      }
    } else
//

//
    if (event is OrderFetchEvent) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      //print(token);
      Future.delayed(Duration(seconds: 1), () async* {
        yield OrderLoadingState();
      }); //authbloc.add(DoFetchEvent());
      try {
        var orders = await repo.fetchOrder(token!);
        // print(orders);
        // var authors= await aurepo.fetchAllAuthors();
        //yield authbloc.mapEventToState(DoFetchEvent);
        yield OrderFetchSuccess(orders: orders);
      } catch (e) {
        yield ErrorState1(message: e.toString());
      }
    }
  }
}

// events
class OrderEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class AddOrderEvent extends OrderEvents {
  int cartId;
  int total;
  AddOrderEvent({required this.cartId, required this.total});
}

class RemoveEvent extends OrderEvents {
  String id;
  RemoveEvent({required this.id});
}

class OrderFetchEvent extends OrderEvents {}

// states
class OrderStates extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderFetchSuccess extends OrderStates {
  List<Order> orders;

  OrderFetchSuccess({required this.orders});
}

class OrderInitialState extends OrderStates {}

class OrderLoadingState extends OrderStates {}

class AddSuccess extends OrderStates {}

class RemoveSuccess extends OrderStates {}

class ErrorState1 extends OrderStates {
  String message;
  ErrorState1({required this.message});
}
