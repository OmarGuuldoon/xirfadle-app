import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xirfadle_app/models/orders_model.dart';
import '../../components/global_methods.dart';
import '../../providers/service_provider.dart';
import '../../widgets/text_widget.dart';
import '../product_details_screen.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrderModel>(context);
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final getCurrentService =
        ServiceProvider().FindServiceById(ordersModel.serviceId);
    final Color color = Colors.black87;
    double _size = MediaQuery.of(context).size.width;
    return ListTile(
      subtitle: const Text(''),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading: FancyShimmerImage(
        width: _size * 0.2,
        imageUrl: ordersModel.imageUrl,
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
          text: '${getCurrentService.title}', color: color, textSize: 18),
      trailing: TextWidget(text: orderDateToShow, color: color, textSize: 18),
    );
  }
}
