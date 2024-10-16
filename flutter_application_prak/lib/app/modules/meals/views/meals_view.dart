import 'package:flutter/material.dart';
import 'package:flutter_application_prak/app/modules/meals/views/meals_web_view.dart';
import 'package:get/get.dart';
import '../../../data/services/meals_controller.dart'; // Adjust the path as necessary

class MealsView extends StatelessWidget {
  final MealsController mealsController = Get.put(MealsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set background color to blue
      appBar: AppBar(
        title: const Text(
          'Meals',
          style: TextStyle(fontWeight: FontWeight.bold), // Make title bold
        ),
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

            // Ensure there is at least one result
            if (meal.result.isEmpty) {
              return const Text('No results available.');
            }

            final firstMeal = meal.result[0];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Align items
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(firstMeal.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Calories: ${firstMeal.calories} kcal'),
                          Text('Carbohydrates: ${firstMeal.carbohidrates} g'),
                          Text('Proteins: ${firstMeal.proteins} g'),
                          Text('Fat: ${firstMeal.fat} g'),
                          Text('Fibres: ${firstMeal.fibres} g'),
                          Text('Salt: ${firstMeal.salt} g'),
                          Text('Sugar: ${firstMeal.sugar} g'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('LIHAT DETAIL'),
                      onPressed: () {
                        Get.to(() => MealDetailWebView(
                            url:
                                'https://reps-id.com/beef-steak-blacky-sauce/'));
                      },
                    ),
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
