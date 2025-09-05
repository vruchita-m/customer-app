import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int _current = 0; // Track the current page index

  HomeBloc() : super(HomeLoading()) {
    // Handle the LoadHomeBanners event
    on<LoadHomeBanners>((event, emit) async {
      emit(HomeLoading()); // Emit loading state

      try {
        // Simulate fetching banner data from an API
        await Future.delayed(Duration(seconds: 2));

        // Example banner data
        final bannerList = [
          {'image': AppImages.dashboardSlider},
          {'image': AppImages.dashboardSlider},
          {'image': AppImages.dashboardSlider},
          {'image': AppImages.dashboardSlider},
        ];

        emit(HomeLoaded(
            homeBannerList: bannerList,
            currentIndex: _current)); // Emit loaded state
      } catch (e) {
        emit(HomeError(message: "Failed to load banners")); // Emit error state
      }
    });

    // Handle the PageChangedEvent
    on<PageChangedEvent>((event, emit) {
      _current = event.pageIndex; // Update the current page index
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(HomeLoaded(
          homeBannerList: currentState.homeBannerList,
          currentIndex: _current,
        ));
      }
    });
  }
}
