import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/FlightBookingHomePage.dart';

class loginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF3F9FB),
      appBar: AppBar(
        elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor:  Color(0xFF1BAEC6),

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 30,),
                Column(
                  children: <Widget>[
                    Text("Login" , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: 20,),
                    Text("Login to your account", style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    inputFile(label: "Email:"),
                    inputFile(label: "Password:" , obsecureText: true)
                  ],
                ),
                ),
                Padding(padding:
                EdgeInsets.symmetric(horizontal: 40,),
                child: Container(
                  padding: EdgeInsets.only(top: 30,left: 3),
                  decoration: BoxDecoration(
      
                    borderRadius: BorderRadius.circular(50),
                

                  ),
                  child:       MaterialButton(


                  minWidth: double.infinity,
                  height: 60,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>FlightBookingHomePage()));
                  },
                  elevation: 0,
                  color: Color.fromARGB(255, 104, 204, 220),

                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                     child: Text("Login",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
               
                    

                  ),),
      

                ),
                ),
                ),

              
                
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?" ,style: TextStyle(color: Colors.black),),
                    Text(" Sign up" , style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                      
                    ),),

                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 100), //here i can adjust
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(image:AssetImage("images/logImg.png"),
                    fit: BoxFit.fitHeight,)
                  ),

                )
              ],


            ),)


          ],
        ),

      ),



    );
 
  }


}
//creating text wifgect

Widget inputFile({label , obsecureText=false}){
return Column(

  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Text(
      label,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.black87,


      ),

    ),
    SizedBox(height: 5,
    ),
    TextField(
      obscureText: obsecureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0 , horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(

            color: Colors.grey,

          ),
        ),
        border:  OutlineInputBorder(
          borderSide: BorderSide(

            color: Colors.grey,

          ),
        ),
      ),
    ),
    SizedBox(height: 10,),


  ],
);

}

/*class _loginPageState  extends State<loginPage>{
  @override
  Widget build(BuildContext context) {
   return Container();
  }


}*/