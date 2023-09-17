import 'package:flutter/material.dart';
import 'package:product_coupon_master/globle.dart';
import 'package:product_coupon_master/product_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    
    return Scaffold(
         body: Container(
           padding: EdgeInsets.all(25),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 100),
               Text(
                 "Get\nOrganic Food",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 40,
                   fontWeight: FontWeight.bold,
                   letterSpacing: 2
                 ),
               ),
               SizedBox(height: 20),
               Text(
                 "Find the fresh food and get\nfree delivery in your town",
                 style: TextStyle(
                   color: Colors.white70,
                   fontSize: 15,
                   letterSpacing: 2
                 ),
               ),
               SizedBox(height: 25),
               InkWell(
                 onTap: () async {
                   SharedPreferences pres = await SharedPreferences.getInstance();
                   
                   if(Globle.data == false) {
                     Globle.products.forEach((e) {
                       Product_Helper.product_helper.insertRecord(data: e);
                     });
                     
                     Navigator.of(context).pushReplacementNamed('/');
                     pres.setBool('data', true);
                   } else {
                     Navigator.of(context).pushReplacementNamed('/');
                   }
                 },
                 child: Ink(
                   child: Container(
                     height: 50,
                     width: 240,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(13),
                     ),
                     alignment: Alignment.center,
                     child: Text(
                       "Get Started",
                       style: TextStyle(
                         fontSize: 20,
                         letterSpacing: 2,
                         color: Color(0xff84801F),
                       ),
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 72
               ),
               Image.asset(
                 "assets/buyer.png"
               )
             ],
           ),
         ),
      backgroundColor: Color(0xffBAB63B),
    );
  }
}
