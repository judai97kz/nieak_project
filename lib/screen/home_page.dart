import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nieak_project/model/shoes_model.dart';

import '../services/shoes_database.dart';

final List<String> entries = <String>['All','Nike', 'Puma', 'C'];
String catelogy='All';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    addShoes();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Shoes>?>(
        future: ShoesDatabaseHelper.getShoesBybrand('Puma'),
        builder: (context,AsyncSnapshot<List<Shoes>?> snapshot){
          return Column(
            children: [
              Container(
                  height: 40,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: entries.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: (){catelogy=entries[index];},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                            ),
                            child: Center(
                              child: Text(entries[index]),
                            ),
                          ),
                        ),
                      ))
              ),
              Expanded(
              child: GridView.count(
                  crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait?2:3,
                children: List.generate(snapshot.data!.length, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.black)
                    ),
                    child: Column(
                      children: [
                        Container(height: 10,),
                       Container(
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.black)
                         ),
                           child:  Image.asset(
                             "assets/${snapshot.data![index].idshoes}.jpg",
                             height: MediaQuery.of(context).orientation == Orientation.portrait?110:160,
                             width: MediaQuery.of(context).orientation == Orientation.portrait?110:160,),),
                        Text(snapshot.data![index].nameshoes,textAlign: TextAlign.center,),
                        Text(snapshot.data![index].price)
                      ],
                    ),
                  ),
                )),
              )
              )
            ],
          );
        },
      ),
    );
  }
}
Future<void> addShoes() async {
  Shoes shoes2 = Shoes(idshoes: "Puma1", nameshoes: "Giày Thể Thao Puma Astro Kick Màu Đen Size 42", price: "1.790.000", color: "Black", size: "39", brand: "Puma");
  await ShoesDatabaseHelper.addShoes(shoes2);
}
