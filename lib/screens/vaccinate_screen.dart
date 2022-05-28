import 'package:flutter/material.dart';

import '../models/child_model.dart';
import '../services/child_service.dart';
import '../tabs/HomeTab.dart';

class VaccinateScreen extends StatefulWidget {
  const VaccinateScreen({Key? key}) : super(key: key);

  @override
  _VaccinateScreenState createState() => _VaccinateScreenState();
}

class _VaccinateScreenState extends State<VaccinateScreen> {
  var editingController = TextEditingController();
  List<Child>? children;

  List<Child> filteredList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChildren();
  }

  void getChildren() async {
    children = await ChildService.shared.getChildren(context);
    setState(() {
      filterSearchResults('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              UserIntro(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search By National ID",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              children != null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            return ChildCard(
                              childModel: filteredList[index],
                            );
                          }),
                    )
                  : CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      filteredList.clear();
      children!.forEach((item) {
        if (item.nationalId.contains(query)) {
          filteredList.add(item);
        }
      });
      setState(() {});
      return;
    } else {
      setState(() {
        filteredList.clear();
        filteredList.addAll(children!);
      });
    }
  }
}
