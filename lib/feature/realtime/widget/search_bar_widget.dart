import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onInput;
  final Function(String) onChange;

  const SearchBarWidget({
    super.key,
    required this.onInput,
    required this.onChange,
  });

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController textEditCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.unfocus();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditCtrl.dispose();
    super.dispose();
  }

  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 1, color: const Color(0xFFEAEef5)),
      ),
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: const Color(0xFF3978F6),
              controller: textEditCtrl,
              focusNode: focusNode,
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              textInputAction: TextInputAction.search,
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0.5, left: 0, right: 10),
                prefixIcon: Container(
                  margin: EdgeInsetsDirectional.only(start: 16),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Color(0xFFA8B4C8),
                        size: 18,
                      ),
                    ],
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  maxWidth: 24 + 16,
                  maxHeight: 24,
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: LKey.searchSite.tr,
                hintMaxLines: 1,
                alignLabelWithHint: true,
                hintStyle: TextStyle(
                  color: const Color(0xFFA8B4C8),
                  fontSize: 14,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              onChanged: (value) {
                widget.onChange.call(value);
              },
              onEditingComplete: () {
                _hideKeyboard();
              },
              onSubmitted: (value) {
                _hideKeyboard();
                widget.onInput.call(value);
              },
            ),
          ),
          SizedBox.shrink(),
        ],
      ),
    );
  }
}
