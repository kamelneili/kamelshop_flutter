import 'dart:developer';

import 'package:bloc/bloc.dart';

//                CategoryBloc(CategoriesAPI())..add(CatDoFetchEvent1()),
//  BlocProvider(
//             create: (context) =>
//                 CategoryBloc(CatInitialState1(), CategoriesAPI())
//                   ..add(CatDoFetchEvent1()),
//           ),
// press: () {
//                       context.read<CategoryBloc>().add(
//                           CatDoFetchProductsEvent1(
//                               category: state.categories[index]));
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) {
//                           return CategoryProducts(state.categories[index]);
//                           // print(category);
//                         }),
//                       );
//                       // BlocProvider.of<CategoryBloc>(context).add(
//                       //     CatDoFetchProductsEvent1(
//                       //         category: state.categories[index]));
//                     },
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('${bloc.runtimeType} $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('$transition');
  }
}
