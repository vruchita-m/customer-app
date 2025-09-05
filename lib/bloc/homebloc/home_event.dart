abstract class HomeEvent {}

// Event to load banners
class LoadHomeBanners extends HomeEvent {}

// Event to handle page changes
class PageChangedEvent extends HomeEvent {
  final int pageIndex;
  PageChangedEvent(this.pageIndex);
}
