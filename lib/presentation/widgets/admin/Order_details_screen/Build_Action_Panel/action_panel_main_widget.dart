import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/Build_Action_Panel/custom_buttons_row.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/Build_Action_Panel/custom_drop_down.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/Build_Action_Panel/custom_list_tile.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/custom_info_panel.dart';

class ActionPanelMainWidget extends StatelessWidget {
  const ActionPanelMainWidget({
    super.key,
    this.estimatedDuration,
    required this.statusOptions,
    this.currentStatus,
    required this.onDelete,
    required this.onConfirm,
    required this.onTap,
    this.onStatusChanged,
  });

  final Duration? estimatedDuration;
  final List<String> statusOptions;
  final String? currentStatus;
  final Function() onDelete;
  final Function() onConfirm;
  final Function() onTap;
  final Function(String? status)? onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return CustomInfoPanel(
      icon: IconlyBold.setting,
      title: 'Order Management',
      children: [
        CustomListTile(onTap: onTap, estimatedDuration: estimatedDuration),
        const SizedBox(height: 16),

        CustomDropDown(
          currentStatus: currentStatus!,
          statusOptions: statusOptions,
          onChanged: onStatusChanged,
        ),

        const Divider(height: 32),
        CustomButtonsRow(onConfirm: onConfirm, onDelete: onDelete),
      ],
    );
  }
}
