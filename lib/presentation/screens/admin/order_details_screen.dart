import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/data/model/order_model.dart';
// Assuming your custom widgets are in these paths
// import '../../widgets/admin/Orders_Screen_Widgets/...';

class AdminOrderDetailsScreen extends StatefulWidget {
  const AdminOrderDetailsScreen({
    super.key,
    required this.order,
    required this.orderId,
  });

  final OrderModel order;
  final String orderId;

  @override
  State<AdminOrderDetailsScreen> createState() =>
      _AdminOrderDetailsScreenState();
}

class _AdminOrderDetailsScreenState extends State<AdminOrderDetailsScreen> {
  late String _currentStatus;
  final List<String> _statusOptions = ['Pending', 'Delivered', 'Cancelled'];
  Duration? _estimatedDuration;

  @override
  void initState() {
    super.initState();
    // Get the status from the widget, defaulting to 'pending' if null.
    final initialStatus = widget.order.status?.toLowerCase() ?? 'pending';

    // Find the correctly capitalized version from our options list.
    // This prevents the case-sensitivity crash.
    _currentStatus = _statusOptions.firstWhere(
      (option) => option.toLowerCase() == initialStatus,
      orElse: () => _statusOptions
          .first, // Fallback to the first option if no match is found
    );
  }

  // Helper to get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green.shade700;
      case 'pending':
        return Colors.orange.shade700;
      case 'cancelled':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF7F9FC,
      ), // A clean, professional background
      body: CustomScrollView(
        slivers: [
          // --- Dynamic Header ---
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 160.0,
            backgroundColor: const Color(0xFF4E342E),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Order #${widget.orderId}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              background: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5D4037), Color(0xFF3E2723)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(_currentStatus).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _currentStatus.toUpperCase(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 45), // Space for the title to settle
                  ],
                ),
              ),
            ),
          ),

          // --- Content Panels ---
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildInfoPanel(
                  icon: IconlyBold.document,
                  title: 'Order Information',
                  children: [
                    _buildInfoRow(
                      'Order Date',
                      formatDate(widget.order.timestamp),
                    ),
                    _buildInfoRow(
                      'Order Time',
                      formatTime(widget.order.timestamp),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoPanel(
                  icon: IconlyBold.profile,
                  title: 'Customer Details',
                  children: [
                    _buildInfoRow('Name', widget.order.customerName!),
                    _buildInfoRow(
                      'Phone',
                      widget.order.customerPhone!.isEmpty
                          ? 'N/A'
                          : widget.order.customerPhone!,
                    ),
                    _buildInfoRow(
                      'Address',
                      widget.order.customerAddress!.isEmpty
                          ? 'N/A'
                          : widget.order.customerAddress!,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildProductsPanel(),
                const SizedBox(height: 16),
                _buildActionsPanel(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // --- Reusable Panel Widget ---
  Widget _buildInfoPanel({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4E342E), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3E2723),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  // --- Reusable Info Row Widget ---
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // --- Products Panel ---
  Widget _buildProductsPanel() {
    return _buildInfoPanel(
      icon: IconlyBold.bag_2,
      title: 'Products Summary',
      children: [
        // Products List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.order.items!.length,
          itemBuilder: (context, index) {
            final item = widget.order.items![index];
            return _ProductListItem(
              name: item["name"]!,
              quantity: item["quantity"]!,
              price: item["price"]!,
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
        const Divider(height: 24),
        // Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'EGP ${widget.order.totalPrice!.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- Actions Panel ---
  // Place this helper method inside your _AdminOrderDetailsScreenState class
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      // Start from 00:00 to feel like a duration picker
      initialTime: const TimeOfDay(hour: 0, minute: 15),
      // This builder is the key to make it a duration picker
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          // Force 24-hour format for duration selection
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        // Convert the picked TimeOfDay into a Duration
        _estimatedDuration = Duration(
          hours: picked.hour,
          minutes: picked.minute,
        );
      });
    }
  }

  // This is the redesigned Actions Panel
  Widget _buildActionsPanel() {
    return _buildInfoPanel(
      icon: IconlyBold.setting,
      title: 'Order Management',
      children: [
        // 1. Set Preparation Time - More intuitive UI
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            IconlyLight.time_circle,
            color: Color(0xFF8D6E63),
          ),
          title: Text('Preparation Time', style: GoogleFonts.poppins()),
          trailing: InkWell(
            onTap: () => _selectTime(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                // Use the new formatter function here
                _estimatedDuration != null
                    ? _formatDuration(_estimatedDuration!)
                    : 'Set Time',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4E342E),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 2. Update Status Dropdown
        DropdownButtonFormField<String>(
          value: _currentStatus,
          items: _statusOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: GoogleFonts.poppins()),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _currentStatus = newValue!;
            });
          },
          decoration: InputDecoration(
            labelText: 'Update Order Status',
            labelStyle: GoogleFonts.poppins(),
            prefixIcon: const Icon(IconlyLight.edit),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        // 3. Visual separator
        const Divider(height: 32),

        // 4. Final Action Buttons
        // ... inside _buildActionsPanel, after the Divider ...

        // Action Buttons in a Row for a more compact and professional look
        Row(
          children: [
            // Delete Button (Secondary, Destructive)
            Expanded(
              child: OutlinedButton.icon(
                icon: Icon(
                  IconlyBold.delete,
                  color: Colors.red.shade700,
                  size: 20,
                ),
                label: Text(
                  'Delete', // Shorter label
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade700,
                  ),
                ),
                // ✨ This now shows a confirmation dialog ✨
                onPressed: () => _showDeleteConfirmationDialog(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.shade300, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Confirm Button (Primary)
            Expanded(
              flex: 2, // Give more space to the primary action
              child: ElevatedButton.icon(
                icon: const Icon(IconlyBold.tick_square, size: 20),
                label: Text(
                  'Confirm & Update', // Shorter label
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  /* Update logic here */
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E342E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// A new widget for the product list item for a cleaner look
class _ProductListItem extends StatelessWidget {
  final String name;
  final int quantity;
  final double price;

  const _ProductListItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$quantity x',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4E342E),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: GoogleFonts.poppins())),
          const SizedBox(width: 12),
          Text(
            'EGP ${(price * quantity).toStringAsFixed(2)}',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// --- Helper Functions ---
String formatDate(DateTime? timestamp) {
  if (timestamp == null) return '---';
  return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
}

String formatTime(DateTime? timestamp) {
  if (timestamp == null) return '---';
  final String period = timestamp.hour < 12 ? 'AM' : 'PM';
  final int hour = timestamp.hour % 12 == 0 ? 12 : timestamp.hour % 12;
  return '$hour:${timestamp.minute.toString().padLeft(2, '0')} $period';
}

// Helper to format Duration into a readable string like "1 hr 30 min"
String _formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  String result = '';
  if (hours > 0) {
    result += '$hours hr ';
  }
  if (minutes > 0) {
    result += '$minutes min';
  }
  return result.isEmpty ? '0 min' : result.trim();
}

// Helper method to show a confirmation dialog before deleting.
Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button to dismiss
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: const Icon(IconlyBold.delete, color: Colors.red, size: 32),
        title: Text(
          'Delete Order?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to permanently delete this order? This action cannot be undone.',
          style: GoogleFonts.poppins(),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
          TextButton(
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              // --- ACTUAL DELETE LOGIC GOES HERE ---
              Navigator.of(context).pop(); // Dismiss the dialog
              // Optionally, pop the screen as well after deletion
              // Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
