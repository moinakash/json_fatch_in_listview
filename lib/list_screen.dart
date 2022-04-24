import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_fatch_in_listview/constant.dart';

class ListScreen extends StatefulWidget {

  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {


  List AllDataList =[];

  @override
  void initState() {
    // TODO: implement initState
    getData(Constants.API_URL, "01-01-2022");

  }


  Future getData(String url,String date) async {

    var apiUrl = Uri.parse(url);
    var response = await http.post(apiUrl, headers: {
      'Authorization': 'Bearer ${Constants.API_KEY}'},
        body: {"date": date});
    if (response.statusCode == 200) {

      List DataList = json.decode(response.body)['data'][0];

      setState(() {
        AllDataList = DataList.expand((x) => x).toList();
      });

    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllDataList.isEmpty ? Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20),
          child: const CircularProgressIndicator()
      ):
      ListView.builder(
        itemCount: AllDataList.length,
          itemBuilder: (context,index){
            return Container(
              color: Colors.amberAccent,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),

              child: Text(
                  "employee_id : ${AllDataList[index]["employee_id"]}"+"\n"+
                  "in_time : ${AllDataList[index]["in_time"]}"+"\n"+
                  "is_late : ${AllDataList[index]["is_late"]}"+"\n"+
                  "is_present : ${AllDataList[index]["is_present"]}"+"\n"+
                  "out_time : ${AllDataList[index]["out_time"]}"+"\n"+
                  "date : ${AllDataList[index]["date"]}"+"\n"+
                  "day : ${AllDataList[index]["day"]}"+"\n"+
                  "isHoliday : ${AllDataList[index]["isHoliday"]}"

              ),

            );
          },

      ),
    );
  }
}