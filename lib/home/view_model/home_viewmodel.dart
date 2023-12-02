import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machine_test/home/model/model.dart';
import 'package:mobx/mobx.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  @observable
  ObservableList<User> users = ObservableList();

  @action
  Future<void> fetchUsers() async {
    try {
      var response = await http.get(
          Uri.parse('https://randomuser.me/api/?results=100&gender=male'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> results = data['results'];

        List<User> fetchedUsers = [];

        for (var user in results) {
          String firstName = user['name']['first'];
          String lastName = user['name']['last'];
          String fullName = '$firstName $lastName';
          String userPic = user['picture']['thumbnail'];

          fetchedUsers.add(User(name: fullName, profileImage: userPic));
        }

        // Update the observable list
        users = ObservableList.of(fetchedUsers);
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
