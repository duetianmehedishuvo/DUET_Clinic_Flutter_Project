import 'package:duet_clinic/services/backend.dart';
import 'package:duet_clinic/services/testProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key? key}) : super(key: key);

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  String search = '';
  bool showSearchResult = false;
  Backend backend = Backend();

  checkClearSearchResult(String key) {
    if (search.trim().isEmpty) {
      setState(() => showSearchResult = false);
    }
  }

  handleSearchResult(String key) {
    if (key.trim().isNotEmpty) {
      setState(() {
        showSearchResult = true;
        search = key.trim().toLowerCase();
      });
    } else {
      setState(() => showSearchResult = false);
    }
  }



  showHospitalAccordingly1(String category) {
    return showSearchResult ? backend.searchHospital1(search,category) : backend.showAllHospitalCard1(category);
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: ListView(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(4)),
            child: DropdownButton(
              value: Provider.of<TestProvider>(context).selectCategory,
              icon: const Icon(Icons.keyboard_arrow_down),
              underline: const SizedBox.shrink(),
              isExpanded: true,
              items: Provider.of<TestProvider>(context, listen: false).categoryLists.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (String? newValue) {
                Provider.of<TestProvider>(context, listen: false).changeSelectCategory(newValue!);
                showHospitalAccordingly1(newValue);
                setState(() {

                });
              },
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(4)),
            child: TextField(
              controller: searchController,
              onChanged: (val) {
                checkClearSearchResult(val);
              },
              onSubmitted: (val) {
                handleSearchResult(val);
              },
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    color: Colors.black,
                    onPressed: () {
                      searchController.clear();
                    },
                  ),
                  hintText: "Search By Clinic Name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none),
            ),
          ),
          showHospitalAccordingly1(Provider.of<TestProvider>(context).selectCategory),
        ]),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
