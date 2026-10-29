part of 'index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with WidgetsBindingObserver, AppStateMixin {
  int select = 0;
  late StreamSubscription<MainPageEvent> mainEvent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mainEvent = AppEventBus.eventBus.on<MainPageEvent>().listen((event) {
      safeSetState(() {
        select = event.select;
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        //debugPrint("Lifecycle resumed ==>");
        break;
      case AppLifecycleState.inactive:
        //debugPrint("Lifecycle inactive ==>");
        break;
      case AppLifecycleState.hidden:
        //debugPrint("Lifecycle hidden ==>");
        break;
      case AppLifecycleState.paused:
        //debugPrint("Lifecycle paused ==>");
        break;
      case AppLifecycleState.detached:
        //debugPrint("Lifecycle detached ==>");
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    mainEvent.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: appBarColor,
          backgroundColor: appBarColor,
          leadingWidth: 50,
          titleSpacing: 10,
          leading: Container(
            margin: EdgeInsetsDirectional.only(start: 10),
            child: AppBarContent(),
          ),
          centerTitle: false,
          title: AppBarTitle(),
          actions: [
            AppBarAction(
              isShow: false,
              onTap: () {
                PageTools.toMessage();
              },
            ),
          ],
        ),
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: appPageColor,
        extendBodyBehindAppBar: false,
        body: IndexedStack(
          index: select,
          children: [
            HomeView(),
            RealTimeView(),
            SiteDetailView(),
            AlertsView(),
            MineView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: select,
          elevation: 0,
          enableFeedback: false,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          selectedItemColor: Color(0xFF3978F6),
          unselectedItemColor: Color(0xFFA8B4C8),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: LKey.home.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_rounded),
              label: LKey.realtime.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: LKey.siteDetail.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_rounded),
              label: LKey.alarm.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: LKey.mine.tr,
            ),
          ],
          onTap: (i) {
            safeSetState(() {
              select = i;
            });
          },
        ),
      ),
    );
  }
}
