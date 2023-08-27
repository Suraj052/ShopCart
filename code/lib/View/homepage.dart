
import 'package:code/View/Drawer/my_account.dart';
import 'package:code/View/Drawer/my_cart.dart';
import 'package:code/View/Drawer/my_orders.dart';
import 'package:code/View/Drawer/notification.dart';
import 'package:code/View/electronics_screen.dart';
import 'package:code/View/jewelery_screen.dart';
import 'package:code/View/mens_screen.dart';
import 'package:code/View/womens_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor("#fe5858"),
              statusBarIconBrightness: Brightness.light),
          iconTheme: IconThemeData(color: HexColor("#fe5858")),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(child: Text("SHOPCART",style: TextStyle(color: Color(0xFF25262d),fontSize: 18,fontFamily: 'Recoleta'))),
          actions: [
          IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications())),
                  icon: Icon(Icons.notifications_active,color: HexColor("#fe5858"))
              ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              children:[
                Container(
                  height: size.height*0.05,
                  child: TabBar(
                      isScrollable: true,
                      indicator: BoxDecoration(
                      color: HexColor("#39b5fd"),
                      borderRadius: BorderRadius.circular(5.0)
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text: "Electronics"),
                        Tab(text: "Jewelery"),
                        Tab(text: "Men's Clothing"),
                        Tab(text: "Women's Clothing"),
                      ]
                  ),
                ),
                SizedBox(height: size.height*0.03),
                Expanded(
                  child: TabBarView(
                      children: [
                        ElectronicsScreen(),
                        JeweleryScreen(),
                        MenScreen(),
                        WomensScreen()
                      ]
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(
      top : MediaQuery.of(context).padding.top
    ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(24, 10, 24, 0),
    child: Wrap(
      runSpacing: 5,
      children: [
        Center(
          child: Column(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Icons/drawercart.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text(textAlign: TextAlign.center,"Let's buy something to bring a smile \non someone's face",style: TextStyle(fontFamily:'ProductSans',color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500))
            ],
          ),
        ),
        Divider(thickness: 2,color: Colors.black),
        ListTile(
          leading: Icon(Icons.file_copy_rounded),
          title: Text("My Orders",style: TextStyle(color: HexColor("#39b5fd"))),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders())),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("My Cart",style: TextStyle(color: HexColor("#39b5fd"))),
          onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => MyCart())),
        ),
        ListTile(
          leading: Icon(Icons.verified_user_rounded),
          title: Text("My Account",style: TextStyle(color: HexColor("#39b5fd"))),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccount())),
        ),
        Divider(thickness: 1),
        ListTile(
          leading: ImageIcon(AssetImage('assets/Icons/amazon.png'), size: 35),
          title: Text("More on Amazon",style: TextStyle(color: HexColor("#39b5fd"))),
          onTap: () => _launchInBrowser(Uri.parse("https://www.amazon.in/"))
        ),
        ListTile(
          leading: ImageIcon(AssetImage('assets/Icons/myntra.png'), size: 25),
          title: Text("More on Myntra",style: TextStyle(color: HexColor("#39b5fd"))),
          onTap: ()=> _launchInBrowser(Uri.parse("https://www.myntra.com/"))
        ),
        ListTile(
          leading: ImageIcon(AssetImage('assets/Icons/flipkart.png'), size: 40),
          title: Text("More on Flipkart",style: TextStyle(color: HexColor("#39b5fd"))),
          onTap: () => _launchInBrowser(Uri.parse("https://www.flipkart.com/"))
        ),
        Divider(thickness: 1),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout",style: TextStyle(color: HexColor("#39b5fd"))),
          onTap: ()=>FirebaseAuth.instance.signOut(),
        ),
      ],
    ),
  );

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}



//RED : fe5858
//BLUE : 39b5fd
// YELLOW : ffde59