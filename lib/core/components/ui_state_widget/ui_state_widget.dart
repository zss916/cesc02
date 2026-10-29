import 'package:cesc01/core/components/ui_state_widget/app_page_empty.dart';
import 'package:cesc01/core/components/ui_state_widget/app_page_loading.dart';
import 'package:cesc01/core/components/ui_state_widget/app_page_offline.dart';
import 'package:flutter/material.dart';

///通用状态控件

///loading
Widget buildLoading() => AppPageLoading();

///empty
Widget buildEmpty() => AppPageEmpty();

///offline
Widget buildOffline() => AppPageOffline();
