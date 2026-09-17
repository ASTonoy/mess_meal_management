import 'package:flutter/material.dart';

class MealDetails extends StatelessWidget {
  final String totalPerson;
  final String totalMeal;
  final String totalMoney;
  final double mealRate;
  final List<Map<String, dynamic>> memberSummary;

  const MealDetails({
    super.key,
    required this.totalPerson,
    required this.totalMeal,
    required this.totalMoney,
    required this.mealRate,
    required this.memberSummary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E4C4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Top Summary Box
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF5B297),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Person
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('lib/images/group.png', width: 40, height: 40),
                        Text(
                          totalPerson,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    // Divider 1
                    const VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),

                    // Meal
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('lib/images/breakfast.png', width: 40, height: 40),
                        Text(
                          totalMeal,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    // Divider 2
                    const VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),

                    // Money
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('lib/images/bangladesh-taka-coin.png', width: 40, height: 40),
                        Text(
                          totalMoney,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Meal Rate Display Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Meal Rate: ৳${mealRate.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Member Details List
            Expanded(
              child: ListView.builder(
                itemCount: memberSummary.length,
                itemBuilder: (context, index) {
                  final member = memberSummary[index];
                  final double balance = member['balance'] ?? 0.0;
                  final bool getsBack = balance >= 0;

                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        member['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Meals: ${member['meals']} | Paid: ৳${member['moneyGiven']}',
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            getsBack ? 'Gets Back' : 'Owes',
                            style: TextStyle(
                              fontSize: 12,
                              color: getsBack ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '৳${balance.abs().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: getsBack ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}