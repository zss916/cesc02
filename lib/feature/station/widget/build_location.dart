import 'package:cesc01/core/network/bean/site_item_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LocationWidgetState { success, loading, error }

class BuildSelectSite extends StatefulWidget {
  final SiteItemEntity? selectSite;
  final Function(SiteItemEntity) onSelect;
  final List<SiteItemEntity> data;
  final LocationWidgetState state;
  const BuildSelectSite({
    super.key,
    required this.selectSite,
    required this.state,
    required this.onSelect,
    required this.data,
  });

  @override
  State<BuildSelectSite> createState() => _BuildLocationState();
}

class _BuildLocationState extends State<BuildSelectSite> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return switch (widget.state) {
      LocationWidgetState.success => Container(
        clipBehavior: Clip.hardEdge,
        constraints: BoxConstraints(maxWidth: 170),
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
                locationSite: widget.selectSite,
                data: widget.data,
                onClose: () {
                  safeSetState(() => expanded = false);
                },
                onSelect: (site) {
                  widget.onSelect.call(site);
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      "${widget.selectSite?.siteCode ?? "-"}·${widget.selectSite?.showSiteName ?? '--'}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF172033),
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
      LocationWidgetState.loading => SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 1.5),
      ),
      LocationWidgetState.error => SizedBox.shrink(),
    };
  }

  void safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }
}

void showSelectPlaceSheet({
  required Function onClose,
  required Function(SiteItemEntity) onSelect,
  required List<SiteItemEntity> data,
  required SiteItemEntity? locationSite,
}) {
  Get.bottomSheet(
    SelectPlaceWidget(
      data: data,
      locationSite: locationSite,
      onSelect: onSelect,
    ),
    isDismissible: true,
    isScrollControlled: true,
    settings: RouteSettings(name: ARoute.selectPlaceSheet),
  ).then((_) {
    onClose.call();
  });
}

class SelectPlaceWidget extends StatefulWidget {
  final List<SiteItemEntity> data;
  final Function(SiteItemEntity) onSelect;
  final SiteItemEntity? locationSite;
  const SelectPlaceWidget({
    super.key,
    required this.data,
    required this.locationSite,
    required this.onSelect,
  });

  @override
  State<SelectPlaceWidget> createState() => _SelectPlaceWidgetState();
}

class _SelectPlaceWidgetState extends State<SelectPlaceWidget> {
  int? selected;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      if ((widget.locationSite != null) && widget.data.isNotEmpty) {
        selected = widget.data.indexOf(widget.locationSite!);
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
                  LKey.selectSite.tr,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Expanded(child: buildList(data: widget.data)),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (selected != null) {
                    SiteItemEntity site = widget.data[selected!];
                    widget.onSelect.call(site);
                  }
                  Get.back();
                },
                child: Container(
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
      return buildPlaceItem(item, index, data);
    },
    separatorBuilder: (BuildContext context, int index) =>
        Divider(height: 10, color: Colors.transparent),
  );

  Widget buildPlaceItem(
    SiteItemEntity item,
    int index,
    List<SiteItemEntity> data,
  ) => InkWell(
    onTap: () {
      setState(() {
        if (selected == index) {
          selected = null;
        } else {
          selected = index;
        }
      });
    },
    child: Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: (selected == index) ? Color(0xFF3978F6) : Color(0x80A8B4C8),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${item.siteCode ?? "-"}·${item.showSiteName ?? '--'}",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 10),
            child: (selected == index)
                ? Icon(Icons.check_rounded, color: Color(0xFF3978F6))
                : SizedBox.shrink(),
          ),
        ],
      ),
    ),
  );
}
