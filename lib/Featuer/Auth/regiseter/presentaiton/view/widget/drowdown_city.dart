import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class City {
  final int id;
  final String name;
  final List<City> childrens;

  City({required this.id, required this.name, required this.childrens});

  factory City.fromJson(Map<String, dynamic> json) {
    var childrensFromJson = json['childrens'] as List? ?? [];
    List<City> childrens =
        childrensFromJson.map((childJson) => City.fromJson(childJson)).toList();
    return City(
      id: json['id'],
      name: json['name'],
      childrens: childrens,
    );
  }
}

typedef OnAreaChanged = void Function(String? areaId);

class DropdownPage extends StatefulWidget {
  final OnAreaChanged onAreaChanged;
  const DropdownPage({super.key, required this.onAreaChanged});

  //int? idcity;

  @override
  DropdownPageState createState() => DropdownPageState();
}

class DropdownPageState extends State<DropdownPage> {
  City? selectedCity;
  City? selectedArea;
  List<City> cities = [];
  final Dio _dio = Dio();
  int? selectedAreaId;
  //int? idcity;

  @override
  void initState() {
    super.initState();
    fetchCities();
  }

  Future<void> fetchCities() async {
    try {
      final response = await _dio
          .get('https://backend.almowafraty.com/api/v1/markets/auth/register');
      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> &&
            data.containsKey('cities') &&
            data['cities'] is List) {
          final citiesJson = data['cities'] as List;
          setState(() {
            cities =
                citiesJson.map((cityJson) => City.fromJson(cityJson)).toList();
            // تعيين القيمة الأولى لـ selectedCity إذا كانت القائمة ليست فارغة
            if (cities.isNotEmpty) {
              selectedCity = cities.first;
              // تحديث القائمة المنسدلة للمناطق بناءً على المدينة المختارة
              selectedArea = selectedCity!.childrens.isNotEmpty
                  ? selectedCity!.childrens.first
                  : null;
            }
          });
        } else {}
      } else {}
    } on DioException {
      rethrow;
      // print(
      // 'DioError: ${e.response?.statusCode} - ${e.response?.statusMessage}');
    } catch (e) {
      // print('An unexpected error occurred: $e');
    }
  }

  TextEditingController idddm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<City>(
              decoration: const InputDecoration(
                labelText: 'اختر المدينه  ',
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE32020), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE32020), width: 1.0),
                ),
              ),
              hint: const Text("اختر مدينة"),
              value: selectedCity,
              onChanged: (City? newValue) {
                setState(() {
                  selectedCity = newValue;
                  selectedArea = null;
                });
              },
              items: cities.map((City city) {
                return DropdownMenuItem<City>(
                  value: city,
                  child: Text(city.name),
                );
              }).toList(),
            ),
            if (selectedCity != null)
              DropdownButtonFormField<City>(
                decoration: const InputDecoration(
                  // labelText: 'اختر المنطقه ',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffE32020), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffE32020), width: 1.0),
                  ),
                ),
                hint: const Text("اختر منطقة"),
                value: selectedArea,
                onChanged: (City? newValue) {
                  setState(() {
                    selectedArea = newValue;
                    selectedAreaId = newValue?.id;
                    //  print(selectedAreaId);
                    //  widget.idcity = selectedAreaId;
                    //   print('sssssaaa${widget.idcity}');
                  });
                  widget
                      .onAreaChanged('$selectedAreaId'); // استدعاء الـ callback
                },
                items: selectedCity!.childrens.map((City area) {
                  return DropdownMenuItem<City>(
                    value: area,
                    child: Text(area.name),
                    onTap: () {
                      // print(idmarket);
                      // print(category['id'].toString());
                    },
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
