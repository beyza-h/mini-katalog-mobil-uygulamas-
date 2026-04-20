 import 'package:first_app/models/product_model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List <Data> products;
  final Set<int> cardIds;
  const CartScreen({super.key, required this.products,required this.cardIds});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
    .where((product) =>widget.cardIds.contains(product.id))
    .toList();
      
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Cart"),backgroundColor: Colors.white),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
              child: cartProducts.isEmpty 
              ?
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_bag_outlined,size:64, 
                    color: Colors.grey),
                    SizedBox(height: 20,),
                    Text("Your cart is empty.", style: TextStyle(color:Colors.grey,fontSize: 18),
                    ),
                  ],
                )
              )
              : ListView.builder(
               itemCount: cartProducts.length,
                itemBuilder: (context, index){
                  final product = cartProducts[index];
              
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(product.image ?? "",width: 70,height: 70)),
                        SizedBox(width: 16),
                         Expanded(
                           child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(product.name ?? "", style:TextStyle(
                                        fontWeight: FontWeight.bold
                                      )),
                                      SizedBox(height: 1),
                                       Text(product.tagline ?? "", style:TextStyle(
                                        fontSize: 12,color: Colors.grey),
                                      ),
                                      SizedBox(height: 1,),
                                       Text(product.price ?? "", style:TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.blue.shade700,
                                      ),
                                      ),
                                    ],
                                               ),
                         ),
                        IconButton(onPressed: (){
                          setState(() {
                            widget.cardIds.remove(product.id);
                          });
                        }, icon: Icon(Icons.remove_circle_outline_outlined),
                        ),
                      ],
                    ),
                  );
                }),
            ),
        
            SizedBox(height: 20,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
             backgroundColor: Colors.black,
             minimumSize: Size(double.infinity, 45),
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
             )
                ),
                onPressed: (){},
               child: Text("Checkout",
                style: TextStyle(color: Colors.white),
               ),
               ),
            
        
          ],),
        ),
      ) ,
    );
  }
}