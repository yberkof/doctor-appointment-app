import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicare/generated/l10n.dart';
import 'package:medicare/models/app_model.dart';
import 'package:medicare/models/child_model.dart';
import 'package:medicare/services/child_service.dart';
import 'package:medicare/styles/colors.dart';

import '../screens/add_child_screen.dart';
import '../screens/child_vaccines_screen.dart';

class HomeTab extends StatefulWidget {
  final void Function() onPressedScheduleCard;

  const HomeTab({
    Key? key,
    required this.onPressedScheduleCard,
  }) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        onPressed: () {
          showBottomSheet(context: context, builder: (c) => AddChildScreen());
        },
      ),
      body: FutureBuilder<List<Child>>(
          future: ChildService.shared.getChildren(context),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      UserIntro(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        S.current.yourChildren,
                        style: TextStyle(
                          color: Color(MyColors.header01),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapShot.data!.length,
                          itemBuilder: (context, index) {
                            return ChildCard(
                              childModel: snapShot.data![index],
                            );
                          })
                    ],
                  ),
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class ChildCard extends StatelessWidget {
  final Child childModel;

  const ChildCard({Key? key, required this.childModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (c) => ChildVaccinesScreen(
                    child: childModel,
                  ));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ' + childModel.childName,
                      style: TextStyle(
                        color: Color(MyColors.header01),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Date Of Birth: ' + childModel.childDateOfBirth,
                      style: TextStyle(
                        color: Color(MyColors.grey02),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Age: ' +
                          (DateTime.now()
                                      .difference(DateFormat("dd/MM/yyyy")
                                          .parse(childModel.childDateOfBirth))
                                      .inDays ~/
                                  365)
                              .toString(),
                      style: TextStyle(
                        color: Color(MyColors.grey02),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              if (AppModel.shared.currentUser.value!.role == '3')
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.vaccines),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map> categories = [
  {'icon': Icons.coronavirus, 'text': 'Covid 19'},
  {'icon': Icons.local_hospital, 'text': 'Hospital'},
  {'icon': Icons.car_rental, 'text': 'Ambulance'},
  {'icon': Icons.local_pharmacy, 'text': 'Pill'},
];

class CategoryIcons extends StatelessWidget {
  const CategoryIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var category in categories)
          CategoryIcon(
            icon: category['icon'],
            text: category['text'],
          ),
      ],
    );
  }
}

class CategoryIcon extends StatelessWidget {
  IconData icon;
  String text;

  CategoryIcon({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(MyColors.bg01),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(MyColors.bg),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: Color(MyColors.primary),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(MyColors.primary),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(MyColors.bg),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              Icons.search,
              color: Color(MyColors.purple02),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search a doctor or health issue',
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserIntro extends StatelessWidget {
  const UserIntro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = AppModel.shared.currentUser.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.hello,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              '${user!.firstName} ${user.lastName} 👋',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        Obx(
          () {
            var image2 = AppModel.shared.currentUser.value!.image;
            return CircleAvatar(
              radius: 25.0,
              backgroundImage: image2 != null
                  ? CachedNetworkImageProvider(image2)
                  : Image.asset("assets/user.png").image,
            );
          },
        ),
      ],
    );
  }
}
