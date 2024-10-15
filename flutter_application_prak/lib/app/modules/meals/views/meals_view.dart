import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/meals_controller.dart'; // Adjust the path as necessary

class MealsView extends StatelessWidget {
  final MealsController mealsController = Get.put(MealsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              mealsController
                  .fetchMeals(''); // Replace '' with your desired query
            },
          ),
        ],
      ),
      body: Obx(() {
        // Check if it's loading
        if (mealsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // If the list is empty, show a message
        if (mealsController.meals.isEmpty) {
          return const Center(child: Text('No meals found.'));
        }

        // Otherwise, show the list of meals
        return ListView.builder(
          itemCount: mealsController.meals.length,
          itemBuilder: (context, index) {
            final meal = mealsController.meals[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(meal.result[0]
                    .name), // Assuming meals have a list of results and using the first one
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Calories: ${meal.result[0].calories} kcal'),
                    Text('Carbohydrates: ${meal.result[0].carbohidrates} g'),
                    Text('Proteins: ${meal.result[0].proteins} g'),
                    Text('Fat: ${meal.result[0].fat} g'),
                    Text('Fibres: ${meal.result[0].fibres} g'),
                    Text('Salt: ${meal.result[0].salt} g'),
                    Text('Sugar: ${meal.result[0].sugar} g'),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
