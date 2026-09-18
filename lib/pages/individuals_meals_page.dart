import 'package:flutter/material.dart';
import 'package:mess_meal_management/pages/meal_details_page.dart';
class IndividualMealsPage extends StatefulWidget {
  final int totalPerson;
  final double totalMeal;
  final double totalMoney;
  const IndividualMealsPage({
    super.key, 
    required this.totalPerson, 
    required this.totalMeal, 
    required this.totalMoney});

  @override
  State<IndividualMealsPage> createState() => _IndividualMealsPageState();
}

class _IndividualMealsPageState extends State<IndividualMealsPage> {
// Lists to store controllers for each person row
  late List<TextEditingController> _nameControllers;
  late List<TextEditingController> _mealControllers;
  late List<TextEditingController> _moneyControllers;

  @override
  void initState() {
    super.initState();
    // Initialize a set of controllers for each person
    _nameControllers = List.generate(
      widget.totalPerson,
      (index) => TextEditingController(),
    );
    _mealControllers = List.generate(
      widget.totalPerson,
      (index) => TextEditingController(),
    );
    _moneyControllers = List.generate(
      widget.totalPerson,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.totalPerson; i++) {
      _nameControllers[i].dispose();
      _mealControllers[i].dispose();
      _moneyControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Member Details'),
      ),
      body: Column(
        children: [
          // Dynamic List of Inputs based on Total Persons
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.totalPerson,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Person ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Name Input
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: _nameControllers[index],
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Individual Meals
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: _mealControllers[index],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Meals',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Individual Money Given
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: _moneyControllers[index],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Money (৳)',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Action Button to process data or navigate to final summary
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                    onPressed: () {
                      // 1. Direct use of widget double values (no double.tryParse needed)
                      double totalMeal = widget.totalMeal;
                      double totalMoney = widget.totalMoney;
                      
                      // Prevent division by zero
                      double mealRate = totalMeal > 0 ? totalMoney / totalMeal : 0.0;

                      List<Map<String, dynamic>> memberSummary = [];
                      for (int i = 0; i < widget.totalPerson; i++) {
                        double individualMeal = double.tryParse(_mealControllers[i].text) ?? 0.0;
                        double individualMoney = double.tryParse(_moneyControllers[i].text) ?? 0.0;
                        double mealCost = individualMeal * mealRate;
                        double balance = individualMoney - mealCost;

                        memberSummary.add({
                          'name': _nameControllers[i].text.isEmpty ? 'Person ${i + 1}' : _nameControllers[i].text,
                          'meals': individualMeal,
                          'moneyGiven': individualMoney,
                          'mealCost': mealCost,
                          'balance': balance,
                        });
                      }

                      // Pass data to MealDetails page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealDetails(
                            totalPerson: widget.totalPerson.toString(),
                            totalMeal: widget.totalMeal.toString(),
                            totalMoney: widget.totalMoney.toString(),
                            mealRate: mealRate,
                            memberSummary: memberSummary,
                          ),
                        ),
                      );
                    },
                    child: const Text('Calculate Final Results'),
                  )
            ),
          ),
        ],
      ),
    );
  }
}