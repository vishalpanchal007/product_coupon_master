import 'package:flutter/material.dart';
import 'package:product_coupon_master/globle.dart';
import '../product.dart';
import '../product_helper.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

late Future<List<Product>> getAllData;

class _Home_PageState extends State<Home_Page> {
  @override
  void initState() {
    super.initState();
    getAllData = Product_Helper.product_helper.fetchRecord();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    double _width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        body: Container(
          color: Color.fromARGB(255, 219, 219, 219),
          child: FutureBuilder(
            future: getAllData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("ERROR : ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                List<Product>? data2 = snapshot.data;
                List<Product> data = [];

                for (var product in data2!) {
                  if (Globle.addProductId == product.id) {
                    data.add(product);
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 260,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xffBAB63B),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(80)
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 60),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    'assets/boy.png',
                                    height: 30,
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.all(10),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                        Icons.search
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "Search Foodstuffs",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: Globle.fruits.map((e) {
                                    return InkWell(
                                      onTap: () {
                                        Globle.addProductId = e["id"];
                                        setState(() {});
                                      },
                                      child: Ink(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 210,
                                              left: 15
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 15
                                          ),
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius
                                                  .circular(10)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                e["image"],
                                                height: 30,
                                                width: 30,
                                              ),
                                              Spacer(),
                                              Text(e["name"])
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          const Text(
                            "Popular Foodstuffs",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.of(context).pushNamed('Cart_Page');
                              });
                            },
                            child: Ink(
                              child: Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    const Icon(
                                      size: 25,
                                      Icons.shopping_bag_outlined,
                                      color: Color.fromARGB(255, 57, 39, 39),
                                    ),
                                    const SizedBox(width: 2),
                                    Container(
                                      height: 33,
                                      width: 33,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffBAB63B),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        Globle.cartData.length.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    Container(
                      height: _height * 0.500,
                      width: _width,
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        itemCount: data.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: (context, i) {
                          return Container(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 0,
                              left: 15,
                              right: 0,
                            ),
                            height: 185,
                            width: 157,
                            decoration: BoxDecoration(
                              color: Colors.amber[100],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      data[i].image,
                                      height: 70,
                                      width: 70,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  data[i].productName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "\$${data[i].price} /-",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        if (data[i].isAdd == "false") {
                                          int? id = await Product_Helper
                                              .product_helper
                                              .updateRecord(
                                            data: Product(
                                              id: data[i].id,
                                              image: data[i].image,
                                              productName: data[i].productName,
                                              price: data[i].price,
                                              stock: data[i].stock,
                                              isAdd: "true",
                                            ),
                                            id: data[i].id,
                                          );

                                          Globle.cartData.add(
                                            Product(
                                              id: data[i].id,
                                              image: data[i].image,
                                              productName: data[i].productName,
                                              price: data[i].price,
                                              stock: data[i].stock,
                                              isAdd: "true",
                                            ),
                                          );
                                        }
                                      },
                                      child: Ink(
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffBAB63B),
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "+",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )
    );
  }
}
