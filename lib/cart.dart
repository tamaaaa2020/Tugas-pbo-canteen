import 'package:flutter/material.dart';
import 'cart_data.dart'; // Import the cart data
import 'main.dart';

class CartPage extends StatefulWidget {
 const CartPage({Key? key}) : super(key: key);

 @override
 State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
 void _removeItem(int index) {
   setState(() {
     CartData.cartItems.removeAt(index); // Use the global cart list
   });
 }

 void _checkout() {
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text('Order placed successfully!')),
   );

   Navigator.of(context).pushAndRemoveUntil(
     MaterialPageRoute(builder: (context) => const FoodDeliveryScreen()),
     (Route<dynamic> route) => false,
   );
 }

 double _calculateSubtotal() {
   return CartData.cartItems.fold(0.0, (total, item) => total + (item.price * item.count));
 }

 double _calculateTax() {
   return _calculateSubtotal() * 0.12;
 }

 double _calculateTotal() {
   return _calculateSubtotal() + _calculateTax();
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color.fromARGB(255, 75, 75, 75),
     appBar: AppBar(
       leading: IconButton(
         onPressed: () {
           Navigator.pop(context);
         },
         icon: const Icon(Icons.arrow_back_ios),
       ),
       title: const Text('Cart'),
     ),
     body: Column(
       children: [
         Expanded(
           child: ListView.builder(
             itemCount: CartData.cartItems.length,
             itemBuilder: (context, index) {
               return Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: CartItemWidget(
                   item: CartData.cartItems[index],
                   onIncrement: () {
                     setState(() {
                       CartData.cartItems[index].count++;
                     });
                   },
                   onDecrement: () {
                     setState(() {
                       if (CartData.cartItems[index].count > 1) {
                         CartData.cartItems[index].count--;
                       }
                     });
                   },
                   onDelete: () => _removeItem(index),
                 ),
               );
             },
           ),
         ),
         Container(
           padding: const EdgeInsets.all(16.0),
           decoration: BoxDecoration(
             color: Colors.black,
             boxShadow: [
               BoxShadow(
                 color: Colors.grey.withOpacity(0.2),
                 spreadRadius: 1,
                 blurRadius: 5,
                 offset: Offset(0, -2),
               ),
             ],
           ),
           child: Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text('Subtotal:', style: TextStyle(fontSize: 16,color: Colors.white,)),
                   Text('Rp. ${_calculateSubtotal().toStringAsFixed(2)}', style: TextStyle(fontSize: 16,color: Colors.white,)), 
                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text('Tax (12%):', style: TextStyle(fontSize: 16, color: Colors.white,)),
                   Text('Rp. ${_calculateTax().toStringAsFixed(2)}', style: TextStyle(fontSize: 16,color: Colors.white,)),
                 ],
               ),
               Divider(),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,)),
                   Text('Rp. ${_calculateTotal().toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                 ],
               ),
               SizedBox(height: 16),
               ElevatedButton(
                 onPressed: _checkout,
                 child: Text('Checkout'),
                 style: ElevatedButton.styleFrom(
                   minimumSize: Size(double.infinity, 50),
                 ),
               ),
             ],
           ),
         ),
       ],
     ),
   );
 }
}


class CartItemWidget extends StatelessWidget {
 final CartItem item;
 final VoidCallback onIncrement;
 final VoidCallback onDecrement;
 final VoidCallback onDelete;

 const CartItemWidget({
   Key? key,
   required this.item,
   required this.onIncrement,
   required this.onDecrement,
   required this.onDelete,
 }) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return Row(
     children: [
       Image.asset(
         item.image,
         width: 80,
         height: 80,
         fit: BoxFit.cover,
       ),
       const SizedBox(width: 16),
       Expanded(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               item.title,
               style: const TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.bold,
               ),
             ),
             const SizedBox(height: 4),
             Text(
               'Rp. ${item.price.toStringAsFixed(2)}',
               style: const TextStyle(
                 fontSize: 14,
                 color: Colors.white,
               ),
             ),
           ],
         ),
       ),
       Row(
         children: [
           IconButton(
             onPressed: onDecrement,
             icon: const Icon(Icons.remove),
           ),
           Text(
             item.count.toString(),
             style: const TextStyle(
               fontSize: 16,
               fontWeight: FontWeight.bold,
             ), 
           ),
           IconButton(
             onPressed: onIncrement,
             icon: const Icon(Icons.add),
           ),
         ],
       ),
       IconButton(
         onPressed: onDelete,
         icon: const Icon(Icons.delete),
         color: Colors.red,
       ),
     ],
   );
 }
}