abstract class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {}

class CommonErrorState extends CommonState {
  final String erroeMsg;
  CommonErrorState({
    required this.erroeMsg,
  });
}

class CommonSuccessState<Type> extends CommonState {
  Type item;
  CommonSuccessState({
    required this.item,
  });

}
