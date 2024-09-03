import 'package:flutter/material.dart';




class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(backgroundColor: Color.fromARGB(255, 21, 21, 21),
    
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          children: [ homePageNavBar(),
          Expanded(child: SingleChildScrollView(child: scrollableHome()))
         
            /*ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Exit Placeholder'),
            ),*/
          ],
        ),
      ),
    );
  }
}

class scrollableHome extends StatelessWidget {
  const scrollableHome({
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {
    return Container( 
      
      
      color: const Color.fromARGB(255, 21, 21, 21),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
              Text("Revolutionize Your Learning. Here & Now.", style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: 30),
              Text("""Leave the tech stuff to us. We make learning simple and effective for you.\n
          How do we do it you ask? You give us the material, we chop it up and make it easy for you.""", 
              style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
          
              const SizedBox(height: 30),
              ElevatedButton(onPressed: () => print("Skibidi"), child: const Text("Get Started", )),
          
              const SizedBox(height: 30),
              Container(
                
                height: 500, //disgusting magic number
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/flashcardsMock.png"), fit: BoxFit.contain))),
              
              
              Text("Here is a nifty tool, our AI-powered flashcards.", style: Theme.of(context).textTheme.headlineMedium,  textAlign: TextAlign.center),
              
              const SizedBox(height: 30),
              Text("""Summarizes your documents into bite-sized cards? Check.\n
              Integrated with quizlets? Check.\n
              Saveable for offline use? Check.""", 
              style: Theme.of(context).textTheme.labelMedium,  textAlign: TextAlign.center),
              
              const SizedBox(height: 30),
          
              Container(),
             
              
              ],),
              
          ),
         Container(
         decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 32, 32, 32),
                        border: Border(
                         top:BorderSide(width: 1.0,
                          // assign the color to the border color
                          color: Color.fromARGB(255, 102, 102, 102),
                        )),)
         , child: Padding(
           padding: const EdgeInsets.symmetric(vertical: 15),
           child: Row(mainAxisAlignment: MainAxisAlignment.center, 
            
            children: [
            
            Text("""About""", 
            style: Theme.of(context).textTheme.bodyMedium,  textAlign: TextAlign.center),
            const SizedBox(width: 30),
            
            Text("""XYZ""", 
            style: Theme.of(context).textTheme.bodyMedium,  textAlign: TextAlign.center),
            const SizedBox(width: 30),
            
            
            Text("""YYZ""", 
            style: Theme.of(context).textTheme.bodyMedium,  textAlign: TextAlign.center),
            const SizedBox(width: 30),
            
            
            ],),
         ))],
      ),
    );
  }
}

class homePageNavBar extends StatelessWidget {
  const homePageNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(color: const Color.fromARGB(255, 21, 21, 21),
      child: Row(
        children: [ Expanded(flex: 5, child: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text("Summer Proj", style: Theme.of(context).textTheme.bodyMedium),
        )),
          const Expanded(flex: 1,
            child: DefaultTabController(
              
                length: 3, // Number of tabs
                child: TabBar(
                  dividerColor: Colors.transparent,
                 

                  isScrollable: true,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  indicatorPadding:  EdgeInsets.only(left: 10, right: 10),
                  labelPadding:  EdgeInsets.only(left: 10, right: 10),
                  tabs: <Widget>[
                    Tab(child: Text("XYZ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Raleway'))),
                    Tab(child: Text("YYZ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Raleway'))),
                    Tab(child: Text("ZZX", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Raleway')))
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}



