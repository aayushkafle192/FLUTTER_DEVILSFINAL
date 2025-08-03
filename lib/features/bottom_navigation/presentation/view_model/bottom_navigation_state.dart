import 'package:equatable/equatable.dart';

class BottomNavigationState extends Equatable {
  final int index;

  const BottomNavigationState({this.index = 0});

  BottomNavigationState copyWith({int? index}) {
    return BottomNavigatnState(
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [index];
}