import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/model_view/state_droplist.dart';

// ignore: non_constant_identifier_names
void SelectBank(BuildContext context) {
  final bankstate = Get.put(DropListState());
  // ignore: no_leading_underscores_for_local_identifiers
  const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  // ignore: unused_element
  String currency() {
    return NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  }

  var banks = [
    'MB Bank',
    'Viettel Money',
    'VP Bank',
    'HACOM Bank',
    'NOPE Bank',
  ];
  var idbank = TextEditingController();
  var money = TextEditingController();
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Lựa Chọn Ngân Hàng"),
                Obx(
                  () => DropdownButton(
                    // Initial Value
                    value: bankstate.BankState.value,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: banks.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      bankstate.BankState.value = newValue!;
                    },
                  ),
                ),
                const Text("Số Tài Khoản"),
                TextField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Số tài khoản'),
                  controller: idbank,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                  ],
                ),
                const Text("Nhập Số Tiền Muốn Nạp"),
                TextField(
                  onChanged: (string) {

                  },
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Số tiền'),
                  controller: money,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (int.parse(money.text) < 1000) {
                      } else {
                        var user = Get.put(Userid());
                        user.user.value!.wallet =
                            int.parse(money.text) + user.user.value!.wallet;
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Nạp"))
              ],
            ),
          ),
        );
      });
}
