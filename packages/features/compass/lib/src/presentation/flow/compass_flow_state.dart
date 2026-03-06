import '../../domain/entities/place.dart';

sealed class CompassFlowState {
  const CompassFlowState();
}

class SelectingCategory extends CompassFlowState {
  const SelectingCategory({this.category = 'cafe'});
  final String category;
}

class DiscoveringPlace extends CompassFlowState {
  const DiscoveringPlace({required this.category});
  final String category;
}

class ViewingCompass extends CompassFlowState {
  const ViewingCompass({required this.place});
  final Place place;
}

class ErrorPage extends CompassFlowState {
  const ErrorPage();
}
