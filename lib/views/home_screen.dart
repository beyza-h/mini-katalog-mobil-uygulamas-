import 'package:first_app/components/product_card.dart';
import 'package:first_app/models/product_model.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/views/cart_screen.dart';
import 'package:first_app/views/product_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<Data> allProducts = [];
 bool isloading = false;
 String errorMessage = "";
 ApiService apiService = ApiService();
Set<int> cardIds={};

 Future<void> loadData () async {
try{
setState(() {
  isloading = true;

});
final data = await apiService.fetchProducts();
setState(() {
  allProducts = data.data ?? [];
  isloading = false;
});
}catch (e){
setState(() {
  errorMessage = "Failed to load products.";
  isloading = false;

});
}

 }

@override
  void initState() {
   loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discover",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen(products: allProducts, cardIds: cardIds)));
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    iconSize: 32,
                ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Find your perfect device.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff5f5f7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search products",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                   
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 80,
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: NetworkImage("https://www.wantapi.com/assets/banner.png"),
               fit:BoxFit.fitWidth ,),
              
              )
               ),
               SizedBox(height:16),
               
               if(isloading)
               Center(child:CircularProgressIndicator())
               else if (errorMessage.isNotEmpty)
               Center(child: Text(errorMessage))
               else
               Expanded(
                 child: GridView.builder(
                  itemCount: allProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    ),
                   itemBuilder: (context, index){
                    final product = allProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailScreen(
                          product: product,
                           cardIds: cardIds,
                           ),
                           ),
                           );
                      },
                      child: ProductCard(product: product));
                     },
                   ),
               )
            ],
          ),
        ),
      ),
    );
  }
}

