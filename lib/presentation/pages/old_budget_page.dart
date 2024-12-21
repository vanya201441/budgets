// import 'package:byte_budget/domain/entities/operation.dart';
// import 'package:byte_budget/main.dart';
// import 'package:byte_budget/presentation/bloc/budget_cubit.dart';
// import 'package:byte_budget/presentation/colors.dart';
// import 'package:byte_budget/presentation/helpers.dart';
// import 'package:byte_budget/presentation/widget/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
// import 'package:skeletonizer/skeletonizer.dart';
//
// class BudgetPage extends StatefulWidget {
//   const BudgetPage({super.key});
//
//   @override
//   State<BudgetPage> createState() => _BudgetPageState();
// }
//
// class _BudgetPageState extends State<BudgetPage> {
//   @override
//   void initState() {
//     getIt<BudgetCubit>().fetchOperations();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BudgetCubit, BudgetState>(
//       bloc: getIt<BudgetCubit>(),
//       builder: (context, state) => Skeletonizer(
//         enabled: state.isLoading,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(height: 128),
//             Expanded(
//               child: ListView.separated(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 physics: const BouncingScrollPhysics(),
//                 separatorBuilder: (context, index) =>
//                     const SizedBox(height: 16),
//                 itemCount: state.isLoading ? 9 : state.operations.length,
//                 itemBuilder: (context, index) => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                   child: _OperationListTile(
//                     isLoading: state.isLoading,
//                     isExtended: false,
//                     operation: state.isLoading
//                         ? state.loadingOperation
//                         : state.operations[index],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 1),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _OperationListTile extends StatelessWidget {
//   const _OperationListTile({
//     required this.operation,
//     required this.isExtended,
//     required this.isLoading,
//     // required this.balance,
//   });
//
//   final bool isExtended;
//   final bool isLoading;
//   final Operation operation;
//
//   // TODO: implement balance
//   // final bool balance;
//
//   @override
//   Widget build(BuildContext context) {
//     final sign = operation.type == OperationType.topUp ? '+' : '–';
//
//     return Glassmorphic(
//       blur: 4,
//       borderRadius: 18,
//       borderStyle: GlassmorphicBorderStyle(
//         strokeWidth: 2,
//         gradient: AppColors.borderGradient,
//       ),
//       bodyGradient: operation.type == OperationType.topUp
//           ? AppColors.greenGradient
//           : AppColors.redGradient,
//       child: Padding(
//           padding:
//               const EdgeInsets.only(right: 16.0, left: 9, top: 8, bottom: 8),
//           child: Row(
//             children: [
//               Skeleton.leaf(
//                 enabled: isLoading,
//                 child: Neumorphic(
//                   style: NeumorphicStyle(
//                     shape: NeumorphicShape.flat,
//                     boxShape:
//                         NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
//                     depth: -2,
//                     intensity: 0.8,
//                     lightSource: LightSource.topLeft,
//                     // border: NeumorphicBorder(
//                     //   color: AppColors.primaryLight.withOpacity(0.1),
//                     //   width: 1,
//                     // ),
//                     // color: Colors.white30.withOpacity(0.2),
//                     color: Colors.transparent,
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.only(
//                       top: 2,
//                       bottom: 4,
//                       left: 4,
//                       right: 4,
//                     ),
//                     child: Icon(
//                       Icons.apple_outlined,
//                       color: Colors.black87,
//                       size: 44,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(Icons.payment_outlined),
//                       const SizedBox(width: 8),
//                       Skeleton.leaf(
//                         child: Text(
//                           operation.merchantName,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     Helpers.fromDateTimeToFormattedString(
//                       operation.paymentDate,
//                     ),
//                     style: const TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Neumorphic(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 8,
//                     ),
//                     style: NeumorphicStyle(
//                       depth: -2,
//                       intensity: 0.8,
//                       lightSource: LightSource.topLeft,
//                       // color: Colors.white.withOpacity(0.3),
//                       color: Colors.transparent,
//                       boxShape: NeumorphicBoxShape.roundRect(
//                           BorderRadius.circular(8)),
//                     ),
//                     child: Text(
//                       '$sign ${operation.amount} ₽',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         // operation.type == OperationType.topUp
//                         //     ? AppColors.primaryDark
//                         //     : Colors.red[900],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )),
//     );
//   }
// }
//
// // const Icon(Icons.payment_outlined),
// //                     const SizedBox(width: 8),
// //                     Text(
// //                       operation.merchantName,
// //                       style: const TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     // const Spacer(),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 8,
// //                         vertical: 4,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.5),
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                       child: Text(
// //                         '$sign ${operation.amount} ₽',
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                           color: operation.type == OperationType.topUp
// //                               ? AppColors.primaryDark
// //                               : Colors.red[800],
// //                         ),
// //                       ),
// //                     ),
