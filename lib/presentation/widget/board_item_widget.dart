// import 'package:flutter/material.dart';
// import 'package:byte_budget/domain/entities/operation.dart';
//
// class BoardItemWidget extends StatefulWidget {
//   const BoardItemWidget({
//     super.key,
//     this.isEnabled = true,
//     required this.operation,
//   });
//
//   final Operation operation;
//   final bool isEnabled;
//
//   @override
//   State<BoardItemWidget> createState() => _BoardItemWidgetState();
// }
//
// class _BoardItemWidgetState extends State<BoardItemWidget> {
//   OperationType? _selectedType;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Center(
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             width: MediaQuery.of(context).size.width * 0.4,
//             height: 168,
//             decoration: BoxDecoration(
//               gradient: widget.isEnabled
//                   ? const LinearGradient(
//                 colors: [Colors.blue, Colors.purple],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               )
//                   : LinearGradient(
//                 colors: [Colors.grey[300]!, Colors.grey[400]!],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: _getBorderColor(), width: 5),
//               boxShadow: [
//                 if (widget.isEnabled)
//                   BoxShadow(
//                     color: Colors.grey[500]!,
//                     spreadRadius: 2,
//                     blurRadius: 8,
//                     offset: const Offset(1, 1),
//                   ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         widget.operation.merchantName,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         widget.operation.amount.toStringAsFixed(2),
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     widget.operation.date.toString(),
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         if (widget.isEnabled)
//           Positioned.fill(
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 borderRadius: const BorderRadius.all(Radius.circular(12)),
//                 onTap: () => _showPaymentTypeModal(context),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   void _showPaymentTypeModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Тип платежа',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               ListTile(
//                 title: const Text('Регулярный платеж'),
//                 onTap: () {
//                   setState(() {
//                     _selectedType = OperationType.regular;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text('Одиночный платеж'),
//                 onTap: () {
//                   setState(() {
//                     _selectedType = OperationType.single;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text('Дополнить платеж'),
//                 onTap: () {
//                   setState(() {
//                     _selectedType = OperationType.topUp;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Color _getBorderColor() {
//     if (_selectedType == null) {
//       return Colors.white;
//     }
//     switch (_selectedType!) {
//       case OperationType.regular:
//         return Colors.red;
//       case OperationType.single:
//         return Colors.green;
//       case OperationType.topUp:
//         return Colors.yellow;
//       default:
//         return Colors.white;
//     }
//   }
// }