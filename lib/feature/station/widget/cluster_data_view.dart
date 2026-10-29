import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/station/widget/battery_cluster_detail_panel.dart';
import 'package:cesc01/feature/station/widget/battery_cluster_header_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ClusterDataView extends StatelessWidget {
  final StackAndClusterEntity data;
  final String breadcrumbPrefix;
  const ClusterDataView({
    super.key,
    required this.data,
    required this.breadcrumbPrefix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 10, color: Colors.transparent),
        BatteryClusterHeaderCard(
          clusterName: data.showClusterName,
          subtitle: '${data.showStackName} · ${data.showPackCount} Pack',
          status: data.showCommStatus,
          metaRows: [
            ClusterMetaRow(
              label: LKey.clusterSn.tr,
              value: data.showClusterSn,
              mono: true,
            ),
            ClusterMetaRow(
              label: LKey.platformReception.tr,
              value: data.showLastDataTime,
              mono: true,
            ),
          ],
        ),
        BatteryClusterDetailPanel(
          breadcrumbPrefix: breadcrumbPrefix,
          metricCards: [
            ClusterMetricCardData(
              label: 'SOC',
              value: data.summary?.showSoc ?? "-",
              unit: '%',
              icon: Icons.battery_charging_full_rounded,
              color: Color(0xFF3D7BEA),
            ),
            ClusterMetricCardData(
              label: 'SOH',
              value: data.summary?.showSoh ?? "-",
              unit: '%',
              icon: Icons.verified_user_rounded,
              color: Color(0xFF5B6BE8),
            ),
            ClusterMetricCardData(
              label: LKey.totalVoltage.tr,
              value: data.summary?.showTotalVoltage ?? "-",
              unit: 'V',
              icon: Icons.bolt_rounded,
              color: Color(0xFF2FA36B),
            ),
            ClusterMetricCardData(
              label: LKey.totalCurrent.tr,
              value: data.summary?.showTotalCurrent ?? "-",
              unit: 'A',
              icon: Icons.ssid_chart_rounded,
              color: Color(0xFFD9922E),
            ),
            ClusterMetricCardData(
              label: LKey.maxTemp.tr,
              value: data.summary?.showMaxTemperature ?? "-",
              unit: '°C',
              icon: Icons.device_thermostat_rounded,
              color: Color(0xFFDD5B49),
            ),
            ClusterMetricCardData(
              label: LKey.maxVoltageDiff.tr,
              value: data.summary?.showMaxVoltageDiff ?? "-",
              unit: 'mV',
              icon: Icons.height_rounded,
              color: Color(0xFF8B5CF6),
            ),
          ],
          runProtectRows: [
            ClusterKV(
              LKey.bmsRunningStatus.tr,
              (data.runningProtection?.showRunStatus ?? '-').runningTitle,
            ),
            ClusterKV(
              LKey.chargeDischargeBan.tr,
              (data.runningProtection?.chargeDischargePermission ?? "-")
                  .permissionTitle,
            ),
            ClusterKV(
              LKey.maxAllowedChargeCurrent.tr,
              data.runningProtection?.showMaxChargeCurrent ?? '-',
            ),
            ClusterKV(
              LKey.maxAllowedDischargeCurrent.tr,
              data.runningProtection?.showMaxDischargeCurrent ?? '-',
            ),
            ClusterKV(
              LKey.currentChannel1.tr,
              data.runningProtection?.current1 ?? '-',
            ),
            ClusterKV(
              LKey.currentChannel2.tr,
              data.runningProtection?.current2 ?? '-',
            ),
            ClusterKV(
              LKey.numberOfCycles.tr,
              data.runningProtection?.showCycles ?? '-',
            ),
            ClusterKV(
              LKey.heaterStatus.tr,
              (data.runningProtection?.showHeaterStatus ?? -1).heaterTitle,
            ),
          ],
          energyRows: [
            ClusterKV(
              LKey.remainingEnergy.tr,
              data.energy?.showRemainingKwh ?? '--',
            ),
            ClusterKV(
              LKey.chargeableEnergy.tr,
              data.energy?.showCanChargeKwh ?? '--',
            ),
            ClusterKV(
              LKey.dischargeableEnergy.tr,
              data.energy?.showCanDischargeKwh ?? '--',
            ),
            ClusterKV(
              LKey.totalChargedEnergy.tr,
              data.energy?.showTotalChargedKwh ?? '--',
            ),
            ClusterKV(
              LKey.totalDischargedEnergy.tr,
              data.energy?.showTotalDischargedKwh ?? '--',
            ),
            ClusterKV(
              LKey.maxTempDiff.tr,
              data.energy?.showMaxTemperatureDiff ?? "--",
            ),
          ],
          extremes: [
            ClusterExtremeData(
              label: LKey.maxCellVoltage.tr,
              value: data.extrema?.showMaxCellVoltage ?? '--',
              unit: 'V',
              location: data.extrema?.showMaxCellVoltageTitle ?? '--',
              icon: Icons.bolt_rounded,
              isMax: true,
            ),
            ClusterExtremeData(
              label: LKey.minCellVoltage.tr,
              value: data.extrema?.showMinCellVoltage ?? '--',
              unit: 'V',
              location: data.extrema?.showMinCellVoltageTitle ?? '--',
              icon: Icons.bolt_rounded,
              isMax: false,
            ),
            ClusterExtremeData(
              label: LKey.maxTemp.tr,
              value: data.extrema?.showMaxTemperature ?? '--',
              unit: '°C',
              location: data.extrema?.showMaxTemperatureTitle ?? '--',
              icon: Icons.device_thermostat_rounded,
              isMax: true,
            ),
            ClusterExtremeData(
              label: LKey.minTemp.tr,
              value: data.extrema?.showMinTemperature ?? '--',
              unit: '°C',
              location: data.extrema?.showMinTemperatureTitle ?? '--',
              icon: Icons.device_thermostat_rounded,
              isMax: false,
            ),
          ],
          systemRows: [
            ClusterKV(
              LKey.belongingStackSn.tr,
              data.systemInfo?.showStackSn ?? '-',
            ),
            ClusterKV(
              LKey.clusterSn.tr,
              data.systemInfo?.showClusterSn ?? '-',
            ),
            ClusterKV(
              LKey.clusterAddress.tr,
              data.systemInfo?.showClusterNo ?? '-',
            ),
            ClusterKV(
              LKey.softwareVersion.tr,
              data.systemInfo?.showSoftwareVersion ?? '-',
            ),
            ClusterKV(
              LKey.hardwareVersion.tr,
              data.systemInfo?.showHardwareVersion ?? '-',
            ),
            ClusterKV(
              LKey.bootVersion.tr,
              data.systemInfo?.showBootVersion ?? '-',
            ),
            ClusterKV(
              LKey.designCapacity.tr,
              data.systemInfo?.showDesignCapacity ?? '-',
            ),
            ClusterKV(
              LKey.packCount.tr,
              data.systemInfo?.showPackCount ?? '-',
            ),
            ClusterKV(
              LKey.cellsPerPack.tr,
              data.systemInfo?.showPackCellCount ?? '-',
            ),
            ClusterKV(
              LKey.tempsPerPack.tr,
              data.systemInfo?.showPackTempCount ?? '-',
            ),
            ClusterKV(
              LKey.systemMode.tr,
              (data.systemInfo?.showMode ?? -1).modeTitle,
            ),
            ClusterKV(
              LKey.accessForm.tr,
              (data.systemInfo?.showAccessMode ?? -1).modeTitle,
            ),
          ],
          alarmRows: [
            ClusterKV(
              LKey.alarmStatus.tr,
              (data.alarmInfo?.showStatus ?? '-').statusTitle,
            ),
            ClusterKV(
              LKey.affiliatedSite.tr,
              data.alarmInfo?.showSiteName ?? '-',
            ),
            ClusterKV(
              LKey.alarmLevel.tr,
              (data.alarmInfo?.showDomainType ?? '-').levelTitle,
            ),
            ClusterKV(
              LKey.belongingStack.tr,
              '${data.alarmInfo?.showStackName ?? '-'} · ${data.alarmInfo?.showStackSn ?? '-'}',
            ),
            ClusterKV(
              LKey.belongingCluster.tr,
              data.alarmInfo?.showClusterName ?? '-',
            ),
            ClusterKV(
              LKey.alarmType.tr,
              (data.alarmInfo?.showAlarmLevel ?? -2).title,
            ),
          ],
          packs: [
            for (StackAndClusterDiagnosisPacks pack
                in (data.diagnosis?.showPacks ?? const []))
              PackCellData(
                packNo: pack.packNo ?? "--",
                voltages: [
                  for (StackAndClusterDiagnosisPacksCellVoltages cell
                      in pack.cellVoltages ?? const [])
                    CellReading(
                      value: cell.voltageMv != null
                          ? ((cell.voltageMv ?? 0) / 1000)
                          : cell.voltageV,
                    ),
                ],
                probeTemps: [
                  for (StackAndClusterDiagnosisPacksCellTemperatures probe
                      in (pack.cellTemperatures ?? const []))
                    CellReading(
                      value: probe.tempC != null
                          ? (probe.tempC ?? 0).toDouble()
                          : probe.tempC,
                    ),
                ],
                environmentTemperature: pack.environmentTemperature,
                heaterTemperature: pack.heaterTemperature,
                soh: pack.soh,
                balance: pack.balance,
                balancingCells: pack.balancingCells ?? const [],
                mosTemps: [
                  for (StackAndClusterDiagnosisPacksMosTemperatures mos
                      in (pack.mosTemperatures ?? const []))
                    CellReading(
                      label: '${mos.no ?? 0}',
                      value: (mos.tempC ?? 0).toDouble(),
                      decimals: 1,
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
