import 'package:banking/autentication/signingoogle.dart';
import 'package:banking/screen/loggin/customerlist.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/image/login_bg.jpg",
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const SafeArea(child: Body()),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.center,
      widthFactor: 1,
      heightFactor: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/image/logo.png"),
                height: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Basic Banking",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "by",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900]),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Atiqur Rahman Sumon",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[800]),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 200,
                child: MaterialButton(
                  color: Colors.white,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.all(10),
                  onPressed: (() {
                    Signingoogle().then((value) {
                      if (value != null) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CustomersList(userDetails: value)),
                          (Route<dynamic> route) => false,
                        );
                        
                      }else{
                        print ("error");
                      }
                    });
                  }),
                  
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage("assets/image/google_logo.png"),
                          height: 32,
                        ),
                        Text("Sign in with Google")
                      ]),
                ),
              )
            ],
          ),
          const SizedBox(height: 70,)
        ],
      ),
    );
  }
}
