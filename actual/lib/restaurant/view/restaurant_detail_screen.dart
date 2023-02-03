import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/component/product_card.dart';
import 'package:actual/restaurant/model/resaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../component/restaurant_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  RestaurantDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get(
      'http://$ip/restaurant/$id',
      options: Options(headers: {
        'authorization': 'Bearer $accessToken',
      }),
    );
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "불타는 떡볶이",
        child: FutureBuilder<Map<String, dynamic>>(
          future: getRestaurantDetail(),
          builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            // 데이터가 있으면
            final item = RestaurantDetailModel.fromJson(json: snapshot.data!);

            return CustomScrollView(
              slivers: [
                renderTop(model: item),
                renderLabel(),
                renderProducts(products: item.products),
              ],
            );
          },
        ));
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      sliver: SliverToBoxAdapter(
        child: Text("메뉴",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantDetailModel model}) {
    return SliverToBoxAdapter(
        child: ResturantCard.fromModel(
      model: model,
      isDetail: true,
    ));
  }

  renderProducts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(
                model: model,
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}