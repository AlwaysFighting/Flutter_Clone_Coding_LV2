import 'package:flutter_river_project/model/shoppingItem_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shoppingListProvider = StateNotifierProvider<ShoppingListNotifier,
    List<ShoppingItemModel>>((ref) => ShoppingListNotifier());

class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  ShoppingListNotifier()
      : super(
    [
      ShoppingItemModel(
        name: "김치",
        quantitiy: 3,
        hasBought: false,
        isSpicy: true,
      ),
      ShoppingItemModel(
        name: "라면",
        quantitiy: 5,
        hasBought: false,
        isSpicy: true,
      ),
      ShoppingItemModel(
        name: "삼겹살",
        quantitiy: 10,
        hasBought: false,
        isSpicy: false,
      ),
      ShoppingItemModel(
        name: "수박",
        quantitiy: 2,
        hasBought: false,
        isSpicy: false,
      ),
      ShoppingItemModel(
        name: "카스테라",
        quantitiy: 5,
        hasBought: false,
        isSpicy: false,
      ),
    ],
  );

  void toggleHasBought({required String name}) {
    // 현재 위 ShoppingItemModel 을 불러오고 싶다면 다음과 같이 state 를 불러오면 된다.
    state = state
        .map((e) =>
    e.name == name
        ? ShoppingItemModel(
      name: e.name,
      quantitiy: e.quantitiy,
      hasBought: !e.hasBought,
      isSpicy: e.isSpicy,
    )
        : e)
        .toList();
  }

}
