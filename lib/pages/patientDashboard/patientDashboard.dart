import 'package:duet_clinic/services/backend.dart';
import 'package:flutter/material.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key? key}) : super(key: key);

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  String search='';
  bool showSearchResult = false;
  Backend backend = Backend();

  checkClearSearchResult(String key){
      if(search.trim().isEmpty){
        setState(()=>showSearchResult = false);
      }
  }

  handleSearchResult(String key){
      if(key.trim().isNotEmpty){
        setState((){
          showSearchResult = true;
          search = key.trim().toLowerCase();
        });
      }else{
         setState(()=>showSearchResult = false);
      }
  }

  showHospitalAccordingly(){
     return showSearchResult?backend.searchHospital(search):backend.showAllHospitalCard();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: ListView(
          children:[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 2.0, color: Colors.black45)
              ),
              child: TextField(
                controller: searchController,
                onChanged: (val){checkClearSearchResult(val);},
                onSubmitted: (val){handleSearchResult(val);},
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon:const Icon(Icons.clear),
                      color:Colors.black,
                      onPressed: (){searchController.clear();},
                    ),
                    hintText: "Search By Clinic Name",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
            showHospitalAccordingly(),
          ]
        ),
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
