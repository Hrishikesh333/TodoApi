import 'package:api_using_flutter/products_api/product_api_services.dart';
import 'package:api_using_flutter/products_api/product_details_page.dart';
import 'package:api_using_flutter/products_api/product_model.dart';
import 'package:flutter/material.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {

  // Stream<List<ProductModel>?> fetchProducts(BuildContext context) async* {
  //   while (true) {
  //     try {
  //       final products = await ProductApiServices().getdata(context);
  //       yield products;
  //     } catch (e) {
  //       yield null; // or handle error more gracefully
  //     }
  //     await Future.delayed(Duration(seconds: 1)); // reasonable polling delay
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Products"),centerTitle: true,),body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder(
        future: ProductApiServices().getdata(context),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          final data = asyncSnapshot.data;
          if (data == null) {
            return Center(child: Text("No products found"));
          }

          return GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(product: data[index],)));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Center(child: Image.network(data[index].images[0].toString(),errorBuilder: (context, error, stackTrace) => Center(child: CircularProgressIndicator(),)))),
                        Expanded(
                          flex: 4,
                          child: ListTile(
                            title: Text(data[index].title.toString(),overflow: TextOverflow.ellipsis,),
                            subtitle: Text('\$${data[index].price}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                fontSize: 20
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );

              },);
        }
      ),
    ),);
  }
}
