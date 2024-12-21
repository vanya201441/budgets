import 'package:byte_budget/domain/entities/operation.dart';
import 'package:byte_budget/main.dart';
import 'package:byte_budget/presentation/bloc/operations_cubit.dart';
import 'package:byte_budget/presentation/widget/currency_button/currency_button_widget.dart';
import 'package:byte_budget/presentation/widget/form/text_field_form_widget.dart';
import 'package:byte_budget/presentation/widget/swipe/swipe_widget.dart';
import 'package:byte_budget/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class OperationsPage extends StatefulWidget {
  const OperationsPage({super.key});

  @override
  State<OperationsPage> createState() => _OperationsPageState();
}

class _OperationsPageState extends State<OperationsPage> {
  late final OperationsCubit operationsCubit;
  final TextEditingController merchantNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController paymentDate = TextEditingController();
  Currency selectedCurrency = Currency.rub;

  @override
  void initState() {
    super.initState();
    operationsCubit = getIt<OperationsCubit>();
    operationsCubit.fetchOperations();
  }

  @override
  void dispose() {
    merchantNameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<OperationsCubit, OperationsState>(
        bloc: operationsCubit,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('Error: ${state.error!}'));
          }

          return ListView.builder(
            itemCount: state.operations.length,
            itemBuilder: (context, index) {
              final operation = state.operations[index];
              return SwipeCardWidget(
                content: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Glassmorphic(
                    blur: 10,
                    borderRadius: 16,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    operation.merchantName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Tooltip(
                                    message: _getOperationTypeTooltip(
                                        operation.type),
                                    child: IconButton(
                                      icon: Icon(
                                        _getOperationTypeIcon(operation.type),
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        final tooltip =
                                            _getOperationTypeTooltip(
                                                operation.type);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text(tooltip)),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                DateFormat('dd.MM.yyyy')
                                    .format(operation.paymentDate),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${operation.amount.toStringAsFixed(2)} ${operation.currency.symbol}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: operation.amount >= 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onDelete: () => operationsCubit.removeOperation(operation.id),
                onEdit: () {
                  // Логика редактирования операции
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOperationDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddOperationDialog(BuildContext context) {
    final merchantNameController = TextEditingController();
    final amountController = TextEditingController();
    final paymentDateController = TextEditingController();
    OperationType selectedType = OperationType.regular;
    showDialog(
      context: context,
      builder: (context) {
        final formKey = GlobalKey<FormState>();
        return AlertDialog(
          title: const Text(
            'Добавление операции',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldWidget(
                      formControlName: 'merchantName',
                      title: 'Название магазина/Сервис',
                      // errorText: 'Название обязательно',
                      controller: merchantNameController,
                    ),
                    TextFieldWidget(
                      formControlName: 'amount',
                      title: 'Сумма',
                      // errorText: 'Неверная сумма',
                      keyboardType: TextInputType.number,
                      controller: amountController,
                    ),
                    TextFieldWidget(
                      formControlName: 'paymentDate',
                      title: 'Дата списания',
                      // errorText: 'Дата обязательна',
                      keyboardType: TextInputType.number,
                      controller: paymentDateController,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<OperationType>(
                      value: selectedType,
                      items: OperationType.values.map((OperationType type) {
                        return DropdownMenuItem<OperationType>(
                          value: type,
                          child: Text(type.title),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedType = newValue!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Тип платежа',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    CurrencyToggleButton(
                      selectedCurrency: selectedCurrency,
                      onCurrencyChanged: (currency) {
                        setState(() {
                          selectedCurrency = currency;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final merchantName = merchantNameController.text;
                  final amount = double.tryParse(amountController.text);
                  final paymentDate = DateFormat('dd.MM.yyyy')
                      .parse(paymentDateController.text);

                  if (merchantName.isNotEmpty && amount != null) {
                    final newOperation = Operation(
                      id: 0,
                      merchantId: '1',
                      type: selectedType,
                      bankId: null,
                      accountId: null,
                      bankCardId: null,
                      currency: selectedCurrency,
                      daysPeriod:
                          selectedType == OperationType.regular ? 30 : null,
                      merchantName: merchantNameController.text,
                      amount: double.parse(amountController.text),
                      paymentDate: paymentDate,
                    );

                    operationsCubit.addOperation(newOperation);
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  String _getOperationTypeTooltip(OperationType type) {
    switch (type) {
      case OperationType.regular:
        return 'Регулярный платеж';
      case OperationType.single:
        return 'Разовый платеж';
      case OperationType.topUp:
        return 'Пополнение';
      default:
        return 'Неизвестный тип';
    }
  }

  IconData _getOperationTypeIcon(OperationType type) {
    switch (type) {
      case OperationType.regular:
        return FontAwesomeIcons.repeat;
      case OperationType.single:
        return FontAwesomeIcons.dollarSign;
      case OperationType.topUp:
        return FontAwesomeIcons.arrowUp;
      default:
        return Icons.help_outline;
    }
  }
}
