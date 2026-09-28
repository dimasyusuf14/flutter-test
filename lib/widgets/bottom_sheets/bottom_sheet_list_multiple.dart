import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:flutter_test_gias/widgets/buttons/button_action.dart';
import 'package:get/get.dart';

class BottomSheetListMultiple<T> extends StatefulWidget {
  const BottomSheetListMultiple({
    super.key,
    required this.label,
    required this.items,
    required this.displayText,
    this.selectedItems = const [],
    required this.onConfirm,
    this.confirmButtonText = 'Done',
  });

  final String label;
  final List<T> items;
  final String Function(T item) displayText;
  final List<T> selectedItems;
  final void Function(List<T> selectedItems) onConfirm;
  final String confirmButtonText;

  @override
  State<BottomSheetListMultiple<T>> createState() =>
      _BottomSheetListMultipleState<T>();
}

class _BottomSheetListMultipleState<T>
    extends State<BottomSheetListMultiple<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  void _toggleItem(T item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: kColorShadow,
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // DRAG HANDLE
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: kColorGray200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Row(
                children: [
                  ButtonAction(
                    onTap: Get.back<void>,
                    child: const Icon(Icons.close_rounded, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: TStyle.poppins16SemiBold.copyWith(
                            color: kColorGray900,
                          ),
                        ),
                        if (_selectedItems.isNotEmpty)
                          Text(
                            '${_selectedItems.length} selected',
                            style: TStyle.poppins12Regular.copyWith(
                              color: kColorGray600,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // LIST ITEMS
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 4),
                shrinkWrap: true,
                itemCount: widget.items.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: kColorGray300, height: 1),
                ),
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isSelected = _selectedItems.contains(item);

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _toggleItem(item),
                      highlightColor: kColorGray100.withValues(alpha: 0.4),
                      splashColor: kColorGray100.withValues(alpha: 0.3),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            // Checkbox
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? kColorPrimary
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? kColorPrimary
                                      : kColorGray400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: kColorWhite,
                                      size: 14,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                widget.displayText(item),
                                style: TStyle.poppins14Regular.copyWith(
                                  color: kColorGray700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // CONFIRM BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onConfirm(_selectedItems);
                    Get.back<void>();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.confirmButtonText,
                    style: TStyle.poppins14SemiBold.copyWith(
                      color: kColorWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
