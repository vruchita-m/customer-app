abstract class HomeState {}

// State when banners are loading
class HomeLoading extends HomeState {}

// State when banners are successfully loaded
class HomeLoaded extends HomeState {
  final List<Map<String, String>> homeBannerList;
  final int currentIndex; // Track the current page index

  HomeLoaded({required this.homeBannerList, required this.currentIndex});
}

// State when an error occurs
class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
