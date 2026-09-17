import 'package:flutter/material.dart';
import 'package:mess_meal_management/pages/individuals_meals_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // define controller for each input

  final TextEditingController _personController = TextEditingController();
  final TextEditingController _mealController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers when widget is destroyed
    _personController.dispose();
    _mealController.dispose();
    _moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Image.asset('lib/images/breakfast.png'),
        ),
        title: Text('Meal Management', 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // number of people

          Text('Total Person', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          ),
          SizedBox(
            width: 400,
          child: 
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: TextField(
              controller: _personController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'e.g. 5',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ),
          SizedBox(height: 20),

          // total meal

          Text('Total Meal', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          ),
          
          SizedBox(
            width: 400,
          child: 
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: TextField(
              controller: _mealController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'e.g. 5',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ),

          // total money
          SizedBox(height: 20),

          Text('Total Money Spent', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          ),
          
          SizedBox(
            width: 400,
          child: 
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: TextField(
              controller: _moneyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'e.g. 5',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ),
          SizedBox(height: 40),

          // submit button

          SizedBox(
            height: 60,
            width: 125,
            child: ElevatedButton(
              onPressed: () {
                          final int? persons = int.tryParse(_personController.text);
                          final double? totalMeals = double.tryParse(_mealController.text);
                          final double? totalMoney = double.tryParse(_moneyController.text);

                          if (persons != null && persons > 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IndividualMealsPage(
                                  totalPerson: persons,
                                  totalMeal: totalMeals ?? 0.0,
                                  totalMoney: totalMoney ?? 0.0,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter a valid number of persons')),
                            );
                          }
                        }, 
            child: const Text('submit')),
          ),
        ],
      ),
    );
  }
}