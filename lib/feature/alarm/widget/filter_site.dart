import 'package:cesc01/core/network/bean/site_item_entity.dart';
import 'package:cesc01/core/network/bean/stack_item_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterSite extends StatefulWidget {
  final Function(SiteItemEntity?, StackItemEntity?) onSelect;
  final List<SiteItemEntity> data;
  const FilterSite({super.key, required this.onSelect, required this.data});

  @override
  State<FilterSite> createState() => _BuildLocationState();
}

class _BuildLocationState extends State<FilterSite> {
  bool expanded = false;
  SiteItemEntity? selectSite;
  StackItemEntity? selectStack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /* Container(
          margin: EdgeInsetsDirectional.only(bottom: 5),
          width: double.maxFinite,
          child: Text("所属站点", style: TextStyle(color: Color(0xFF6F7D92))),
        ),*/
        Divider(height: 5, color: Colors.transparent),
        Container(
          clipBehavior: Clip.hardEdge,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFEAEef5)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                safeSetState(() => expanded = !expanded);

                showSelectPlaceSheet(
                  selectStack: selectStack,
                  selectSite: selectSite,
                  data: widget.data,
                  onClose: () {
                    safeSetState(() => expanded = false);
                  },
                  onSelect: (site, stack) {
                    selectSite = site;
                    selectStack = stack;
                    widget.onSelect.call(site, stack);
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        getSelectName(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: (selectSite == null)
                              ? FontWeight.normal
                              : FontWeight.w600,
                          color: selectSite == null
                              ? Color(0xFF6F7D92)
                              : Color(0xFF172033),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    AnimatedRotation(
                      turns: expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(height: 3, color: Colors.transparent),
      ],
    );
  }

  String getSelectName() {
    if (selectSite != null) {
      return selectSite?.showSiteName ?? '';
    } else if (selectStack != null) {
      return selectStack?.stackSn ?? '';
    } else {
      return LKey.selectStationOrStack.tr;
    }
  }

  void safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }
}

void showSelectPlaceSheet({
  required Function onClose,
  required Function(SiteItemEntity?, StackItemEntity?) onSelect,
  required List<SiteItemEntity> data,
  required SiteItemEntity? selectSite,
  required StackItemEntity? selectStack,
}) {
  Get.bottomSheet(
    SelectPlaceWidget(
      data: data,
      selectSite: selectSite,
      selectStack: selectStack,
      onSelect: onSelect,
    ),
    isDismissible: true,
    isScrollControlled: true,
    settings: RouteSettings(name: ARoute.filterSite),
  ).then((_) {
    onClose.call();
  });
}

class SelectPlaceWidget extends StatefulWidget {
  final List<SiteItemEntity> data;
  final Function(SiteItemEntity?, StackItemEntity?) onSelect;
  final SiteItemEntity? selectSite;
  final StackItemEntity? selectStack;
  const SelectPlaceWidget({
    super.key,
    required this.data,
    required this.selectSite,
    required this.selectStack,
    required this.onSelect,
  });

  @override
  State<SelectPlaceWidget> createState() => _SelectPlaceWidgetState();
}

class _SelectPlaceWidgetState extends State<SelectPlaceWidget> {
  String? id;
  SiteItemEntity? site;
  StackItemEntity? stack;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      if ((widget.selectSite != null) && widget.data.isNotEmpty) {
        id = widget.selectSite?.siteId;
      }
      if ((widget.selectStack != null) && widget.data.isNotEmpty) {
        id = widget.selectStack?.stackSn;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: MediaQuery.heightOf(context) / 4),
      padding: EdgeInsetsDirectional.only(
        top: 10,
        start: 10,
        end: 10,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      width: double.maxFinite,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: 5, bottom: 5),
                child: Text(
                  LKey.selectStationOrStack.tr,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Expanded(child: buildList(data: widget.data)),
              GestureDetector(
                onTap: () {
                  widget.onSelect.call(site, stack);
                  Get.back();
                },
                child: Container(
                  margin: EdgeInsetsDirectional.only(top: 20),
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 5,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF3978F6),
                  ),
                  width: double.maxFinite,
                  child: Text(
                    LKey.confirm.tr,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),

          PositionedDirectional(
            top: 0,
            end: 0,
            child: IconButton(
              onPressed: () => Get.back<void>(),
              icon: const Icon(
                Icons.close_rounded,
                size: 22,
                color: Color(0xFF6F7D92),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList({required List<SiteItemEntity> data}) => ListView.separated(
    padding: EdgeInsetsDirectional.only(start: 6, end: 6, top: 15),
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      SiteItemEntity item = data[index];
      return buildSiteItem(item, index);
    },
    separatorBuilder: (BuildContext context, int index) =>
        Divider(height: 10, color: Colors.transparent),
  );

  Widget buildSiteItem(SiteItemEntity item, int index) => Column(
    spacing: 10,
    children: [
      InkWell(
        onTap: () {
          setState(() {
            if (id == item.siteId) {
              id = null;
              site = null;
            } else {
              id = item.siteId;
              site = item;
            }
          });
        },
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 10,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Color(0x66A8B4C8),
            border: Border.all(
              width: 1,
              color: (id == item.siteId)
                  ? Color(0xFF3978F6)
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${item.showSiteCode} · ${item.showSiteName}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                "${item.showStacks.length}${LKey.stack.tr}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 10),
                child: (id == item.siteId)
                    ? Icon(
                        Icons.check_rounded,
                        color: Color(0xFF3978F6),
                        size: 20,
                      )
                    : SizedBox(width: 20, height: 20),
              ),
            ],
          ),
        ),
      ),
      ...item.showStacks.mapIndexed((i, subItem) {
        return InkWell(
          onTap: () {
            setState(() {
              if (id == subItem.stackSn) {
                id = null;
                stack = null;
                site = null;
              } else {
                id = subItem.stackSn;
                stack = subItem;
                site = item;
              }
            });
          },
          child: Container(
            margin: EdgeInsetsDirectional.only(start: 20),
            padding: EdgeInsetsDirectional.only(
              start: 10,
              end: 10,
              top: 6,
              bottom: 6,
            ),
            decoration: BoxDecoration(
              color: Color(0x26A8B4C8),
              border: Border.all(
                width: 1,
                color: (id == subItem.stackSn)
                    ? Color(0xFF3978F6)
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 0),
                        width: double.maxFinite,
                        child: Text(
                          "${LKey.batteryStack.tr} ${i + 1}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 0),
                        width: double.maxFinite,
                        child: Text(
                          subItem.showStackName,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 10),
                  child: (id == subItem.stackSn)
                      ? Icon(Icons.check_rounded, color: Color(0xFF3978F6))
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      }),
    ],
  );
}
