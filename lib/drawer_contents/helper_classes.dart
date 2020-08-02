import 'package:durga_pooja/dummy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MealCard {
  String day;
  bool isBreakfast;
  bool isLunch;
  bool isDinner;
  int count;
  bool if_veg;
  bool if_guest;
  MealCard({this.day, this.count,this.if_guest, this.if_veg,this.isBreakfast,this.isDinner,this.isLunch});
}

class MealCardList extends ChangeNotifier {
  List<MealCard> mealCards = [];
  MealCardList({this.mealCards});

  getMealCard() => mealCards;

  void addMealCard(MealCard mealCard) {
    mealCards.add(mealCard);
    notifyListeners();
  }

  void removeMealCard(int index) {
    //print("inside remove meal card: ${key}");
    mealCards.removeAt(index);
    //print("yes");
    notifyListeners();
  }

  void updateMealCard(int index, String day){
    mealCards[index].day = day;
    notifyListeners();
  }

  void updateMealCardCount(int index){
    mealCards[index].count++;
    notifyListeners();
  }

  void changeBreakFastDetails(int index){
    mealCards[index].isBreakfast = !mealCards[index].isBreakfast;
  }

  void changeLunchDetails(int index){
    mealCards[index].isLunch = !mealCards[index].isLunch;
  }

  void changeDinnerDetails(int index){
    mealCards[index].isDinner = !mealCards[index].isDinner;
  }

}
