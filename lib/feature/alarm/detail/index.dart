import 'package:cesc01/core/components/app_bar_title_widget.dart';
import 'package:cesc01/core/components/ui_state_widget/ui_state_widget.dart';
import 'package:cesc01/core/event/network_event.dart';
import 'package:cesc01/core/helper/app_loading.dart';
import 'package:cesc01/core/network/api/alarm.dart';
import 'package:cesc01/core/network/bean/stack_alarm_detail_entity.dart';
import 'package:cesc01/core/network/result/result.dart';
import 'package:cesc01/core/state/network/base_net_state_logic.dart';
import 'package:cesc01/core/state/uiState.dart';
import 'package:cesc01/core/system/app_colors.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/alarm/detail/widget/alarm_detail_panel.dart';
import 'package:cesc01/feature/alarm/detail/widget/battery_stack_info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'logic.dart';
part 'view.dart';
