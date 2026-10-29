import 'package:event_bus/event_bus.dart';

class AppEventBus {
  static final EventBus eventBus = EventBus();
}

class NetWorkRefresh {
  NetWorkRefresh();
}

class MainPageEvent {
  final int select;
  MainPageEvent({required this.select});
}

/*class RecentlyViewedEvent {
  RecentlyViewedEvent();
}*/
