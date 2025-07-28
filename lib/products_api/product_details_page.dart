import 'package:flutter/material.dart';

import 'product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isExpanded = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Details"), centerTitle: true),
      body: Column(
        children: [
        SizedBox(
        height: 300, // or any height
        child: CarouselView(
            itemSnapping: true,
            itemExtent:MediaQuery.of(context).size.width, children: List.generate(widget.product.images.length, (index) {
     return   Image.network(
        widget.product.images[index],
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
        Center(child: CircularProgressIndicator()),
        );
        },)
      ),
    ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.title.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      Text(
        widget.product.description.toString(),
        maxLines: isExpanded ? null : 2,
        overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 15),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Text(
            isExpanded ? "Read less" : "Read more",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),),
      ),
                Text("\$ ${widget.product.price}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ]));
  }
}
