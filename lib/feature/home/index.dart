import 'dart:async';

import 'package:cesc01/core/components/app_page_title.dart';
import 'package:cesc01/core/helper/app_loading.dart';
import 'package:cesc01/core/network/api/home.dart';
import 'package:cesc01/core/network/bean/dashboard_entity.dart';
import 'package:cesc01/core/permission/ble_manager.dart';
import 'package:cesc01/core/state/network/base_net_connect_logic.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/home/widget/home_overview_widget.dart';
import 'package:cesc01/feature/home/widget/home_site_card.dart';
import 'package:cesc01/feature/home/widget/home_skeleton.dart';
import 'package:cesc01/feature/home/widget/provision_quick_card.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'logic.dart';
part 'view.dart';
