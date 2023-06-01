import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/config/app.dart';
import 'package:intl/intl.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: primary.withOpacity(0.8),
      content: Text(content)
    )
  );
}

String toImage(String image) {
  return "https://$BASE_URL/storage/$image";
}

String formatCurrency(int? price) {
  final currencyFormatter = NumberFormat.currency(locale: 'vi');
  return currencyFormatter.format(price ?? 0);
}

String formatCurrencyDouble(double price) {
  final currencyFormatter = NumberFormat.currency(locale: 'vi');
  return currencyFormatter.format(price);
}

String formatTimeToString(DateTime time) {
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
  
  final now = DateTime.now();
  // time = DateTime.now().subtract(Duration(minutes: 15));
  final difference  = now.difference(time);
  return timeago.format(now.subtract(difference), locale: 'vi');
}

String formatTimeToString2(DateTime? time, [String text = ""]) {
  if (time == null) return text;

  return DateFormat("dd/MM/yyyy").format(time);
}

Future dialogEscape(BuildContext context, String title, String description) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Trở lại'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Buộc rời'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}

enum AlertEnum {
  success,
  warning,
  error
}

class AlertWidget extends ConsumerStatefulWidget {
  final AlertEnum type;
  const AlertWidget({required this.type, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends ConsumerState<AlertWidget> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  late String title = widget.type == AlertEnum.success ? "Tuyệt vời" : "Hỏng rồi";
  late String description = widget.type == AlertEnum.success 
    ? "Yêu cầu của bạn đã được xử lý thành công" 
    : "Yêu cầu của bạn không thành công, vui lòng thử lại sau";

  @override
  void initState() {
    super.initState();

    controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    scaleAnimation =
      CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    color: widget.type == AlertEnum.success ? Colors.blue : Colors.yellow
                  ),
                  alignment: Alignment.center,
                  child: const Icon(CupertinoIcons.check_mark_circled, color: Colors.white, size: 36,),
                ),
                Container(
                  width: 250,
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: Colors.white
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),),
                      const SizedBox(height: 7,),
                      Text(description, style: const TextStyle(
                        // fontSize: 14
                      ), textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {

    if (newValue.text == '') {
      return newValue;
    } else if (double.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return double.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}