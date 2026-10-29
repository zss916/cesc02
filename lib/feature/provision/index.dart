import 'dart:async';

import 'package:cesc01/core/components/keep_alive_page.dart';
import 'package:cesc01/core/network/api/site.dart';
import 'package:cesc01/core/network/bean/site_item_entity.dart';
import 'package:cesc01/core/permission/ble_manager.dart';
import 'package:cesc01/core/state/network/base_net_connect_logic.dart';
import 'package:cesc01/feature/provision/helper/smart_ble_link_tools.dart';
import 'package:cesc01/feature/provision/helper/state_mixin.dart';
import 'package:cesc01/feature/provision/view/step0/index.dart';
import 'package:cesc01/feature/provision/view/step1/index.dart';
import 'package:cesc01/feature/provision/view/step2/index.dart';
import 'package:cesc01/feature/provision/view/step3/index.dart';
import 'package:cesc01/feature/provision/view/step3/provision_api.dart';
import 'package:cesc01/feature/provision/widget/build_app_bar.dart';
import 'package:cesc01/feature/provision/widget/step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'logic.dart';
part 'view.dart';
