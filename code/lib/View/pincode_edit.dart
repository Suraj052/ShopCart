import 'package:code/Services/firebase_services.dart';
import 'package:code/View/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
class PincodeEdit extends StatefulWidget {
  const PincodeEdit({Key? key}) : super(key: key);

  @override
  State<PincodeEdit> createState() => _PincodeEditState();
}

class _PincodeEditState extends State<PincodeEdit> {

  final pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor("#fe5858"),
            statusBarIconBrightness: Brightness.light),
        backgroundColor: HexColor("#fe5858"),
        elevation: 0,
        leading: IconButton(onPressed: ()=>Navigator.pop(context),icon: Icon(Icons.arrow_back_ios,color: Colors.white)),
        title: Text("Address of Delivery",style: TextStyle(fontSize: 18,color: Colors.white)),
        actions: [
          IconButton(onPressed: (){
            pincodeController.text.trim().isEmpty ?
                    showToast("Invalid Input !"):
                    FirebaseApi.updateAddress(pincodeController.text.trim());
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
              icon: Icon(Icons.check)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(22.0,20.0, 22.0,0.0),
                child:Container(
                  height: size.height*0.06,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        offset: Offset(0.0,2.0),
                      )]
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: pincodeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your pincode',
                      ),
                    ),
                  ),
                )
            ),
            SizedBox(height: size.height*0.1),
            Container(
                width: 250,
                height: 300,
                child: Image.asset("assets/Icons/air-delivery.png")
            ),
          ],
        ),
      ),
    );
  }
}

void showToast(String text) => Fluttertoast.showToast
  (
  msg: text,
  fontSize: 13.0,
  backgroundColor: HexColor("#fe5858"),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);
