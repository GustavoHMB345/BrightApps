import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

    

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
            title: const Text("Url launcher"),
        ),
        body:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                InkWell(
                    onTap: () {},
                    child: Container(
                        margin: const EdgeInsets.all(20),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                                "Abra a URL no navegador externo",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                ),
                                )),

                    ),
                )
            ],
            ),
        );
        
        
    }
}