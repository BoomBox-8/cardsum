import 'package:flutter/material.dart';
import 'flashcardsPage.dart';
import 'summarizerPage.dart';

class toolPage extends StatefulWidget
{
  const toolPage({super.key});

  @override
  State<toolPage> createState() => _toolPageState();
}

class _toolPageState extends State<toolPage> {
  int selectedIndex = 0;


  @override
  Widget build(BuildContext context)
  
  {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const Placeholder();
        break;
      case 1:
        page = const FlashcardScreenContainer();
        break;
      
      case 2:
        page = ChatScreen();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }




    return Scaffold(
      body: Row(children: 
      [
        NavigationRail(
          extended: true,
          leading:  Container(
                  
                  height: 128,
                  width: 128, //disgusting magic number
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/placeholder.png"), fit: BoxFit.fill))),
          
          backgroundColor:  const Color.fromARGB(255, 23, 23, 31),
          
          destinations: [
          NavigationRailDestination(icon: const Icon(Icons.sticky_note_2), label: Text("View Cards", style: Theme.of(context).textTheme.bodyMedium)),
          NavigationRailDestination(icon: const Icon(Icons.recycling), label: Text("Edit Cards", style: Theme.of(context).textTheme.bodyMedium)),
          NavigationRailDestination(icon: const Icon(Icons.recycling), label: Text("Summarize Text", style: Theme.of(context).textTheme.bodyMedium)),

          ], selectedIndex: selectedIndex, onDestinationSelected: (value) {setState(()
          {
            selectedIndex = value;
          });
          
          },), 
      
      Expanded(child: Container( 
        color: const Color.fromARGB(255, 21, 21, 21,), 
        child: page  ),)]),);
  }
}

class FlashcardScreenContainer extends StatelessWidget {
  const FlashcardScreenContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                            onPressed: ()=>print("Placeholder"),
        
                            style: ElevatedButton.styleFrom(minimumSize: const Size(36, 45), backgroundColor: const Color.fromARGB(255, 81, 81, 163), padding: const EdgeInsets.all(12)),
                            child: Text('Delete Flashcard', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: const Color.fromARGB(255, 221,219,255), height: 1.3, fontSize: 20), textAlign: TextAlign.center,),
                          ),
      
              const SizedBox(height: 180),          
              IconButton.filled(onPressed: () {
                print("skibidi");
                } , icon: const Icon(Icons.arrow_back_rounded)),
            ],
          ),
      
          const SizedBox(width: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
      
      
            children: [
              const FlashcardScreen(),
      
              const SizedBox(height: 30),
      
              ElevatedButton(
                            onPressed: ()=>print("Placeholder"),
        
                            style: ElevatedButton.styleFrom(minimumSize: const Size(36, 45), backgroundColor: const Color.fromARGB(255, 81, 81, 163), padding: const EdgeInsets.all(12)),
                            child: Text('Regenerate Text', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: const Color.fromARGB(255, 221,219,255), height: 1.3, fontSize: 20), textAlign: TextAlign.center,),
                          ),
            ],
          ),
        
        const SizedBox(width: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [ElevatedButton(
                            onPressed: ()=>print("Placeholder"),
        
                            style: ElevatedButton.styleFrom(minimumSize: const Size(36, 45), backgroundColor: const Color.fromARGB(255, 81, 81, 163), padding: const EdgeInsets.all(12)),
                            child: Text('Edit Flashcard', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: const Color.fromARGB(255, 221,219,255), height: 1.3, fontSize: 20), textAlign: TextAlign.center,),
                          ),
      
              const SizedBox(height: 180),   
            IconButton.filled(onPressed: () {
                print("skibidi");
                } , icon: const Icon(Icons.arrow_forward_rounded)),
          ],
        ),
      
          const SizedBox(width: 30),],
      ),
    );
  }
}