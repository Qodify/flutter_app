import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(children: <Widget>[
        Card(
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100)),
          ),
          margin: const EdgeInsets.only(bottom: 7.5),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  'Total',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                OrderButton(cart: cart)
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        cart.itemCount <= 0
            ? Center(child: Text('No items in the shopping cart'))
            : Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) {
                    return CartItem(
                      id: cart.items.values.toList()[i].id,
                      price: cart.items.values.toList()[i].price,
                      quantity: cart.items.values.toList()[i].quantity,
                      title: cart.items.values.toList()[i].title,
                      productId: cart.items.keys.toList()[i],
                    );
                  },
                ),
              ),
      ]),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : const Text('ORDER NOW'),
      onPressed: widget.cart.totalAmount <= 0 || _isLoading
          ? null
          : () async {
              setState(() => _isLoading = true);
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() => _isLoading = false);

              widget.cart.clear();
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
