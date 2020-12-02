import 'dart:convert';

class LocalRestaurant {
  LocalRestaurant({
    this.restaurants,
  });

  List<Restaurant> restaurants;

  LocalRestaurant.fromJson(Map<String, dynamic> localrestaurant){
    restaurants = localrestaurant['restaurants'];
  }
}

List<LocalRestaurant> parseLocalRestaurants(String json){
  if (json == null){
    return [];
  }
  final List parsed = jsonDecode(json);
  return parsed.map((json) => LocalRestaurant.fromJson(json)).toList();
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  String rating;
  Menus menus;

  Restaurant.fromJson(Map<String, dynamic> restaurant){
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'].toString();
    // menus = restaurant['menus'] != null
    //   ? new Menus.fromJson(restaurant['menus'])
    //   : null;
  }
}

List<Restaurant> parseRestaurants(String json){
  if (json == null){
    return [];
  }
  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Food> foods;
  List<Drink> drinks;

  Menus.fromJson(Map<String, dynamic> menus){
    foods = menus['foods'] ;
    drinks = menus['drinks'];
  }
}

List<Menus> parseMenuss(String json){
  if (json == null){
    return [];
  }

  final List parsed = jsonDecode(json)['menus'];
  return parsed.map((json) => Menus.fromJson(json)).toList();
}

class Food{
  String nama;

  Food({
    this.nama,
  });

  Food.fromJson(Map<String, dynamic> foods){
    nama = foods['name'];
  }
}

List<Food> parseFood(String json){
  if (json == null){
    return [];
  }
  final List parsed = jsonDecode(json)['menus'];
  return parsed.map((json) => Food.fromJson(json)).toList();
}

class Drink {
    Drink({
        this.name,
    });

    String name;

  Drink.fromJson(Map<String, dynamic> drink){
    name = drink['name'];
  }
}

List<Drink> parseDrinks(String json){
  if (json == null){
    return [];
  }

  final List parsed = jsonDecode(json) ['menus'];
  return parsed.map((json) => Drink.fromJson(json)).toList();
}

