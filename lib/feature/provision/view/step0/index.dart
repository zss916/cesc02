import 'dart:async';

import 'package:cesc01/core/helper/app_loading.dart';
import 'package:cesc01/core/permission/ble_manager.dart';
import 'package:cesc01/core/permission/permission_tools.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/provision/dialog/ble_permission_tip_dialog.dart';
import 'package:cesc01/feature/provision/helper/state_mixin.dart';
import 'package:cesc01/feature/provision/index.dart';
import 'package:cesc01/feature/provision/widget/input_sn.dart';
import 'package:cesc01/feature/provision/widget/primary_btn.dart';
import 'package:cesc01/feature/provision/widget/status_row.dart';
import 'package:cesc01/feature/provision/widget/step_shell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'step_bluetooth.dart';
