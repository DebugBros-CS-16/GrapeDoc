import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Grape Doc',
          style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 28.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),

      body:  Center(
        child: Column(
          children:  <Widget>[
            const SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                Image.asset("assets/images/grapedoclogo1.png"),
                // const SizedBox(
                //   height: 25.0,
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username',
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25.0,
                ),

                TextButton(
                    child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.green,)
                            )
                        )
                    ),
                    onPressed: () => null
                ),

                const SizedBox(
                  height: 30.0,
                ),

                const Text(
                    'Dont have an account? Sign up' ,
                    textAlign: TextAlign.center),
              ],
            )
          ],
        ),
      ),
    );

  }
}
