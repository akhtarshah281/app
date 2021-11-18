import 'package:api_fetch_data/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ApiFetchData(),
  ));
}

class ApiFetchData extends StatefulWidget {
  const ApiFetchData({Key? key}) : super(key: key);

  @override
  _ApiFetchDataState createState() => _ApiFetchDataState();
}

class _ApiFetchDataState extends State<ApiFetchData> {
  late String stringResponse;

  List list = [];

  Future fetchData() async {
    Dio dio = Dio();
    Response response;
    response = await dio.get(ApiString().userUrls);
    if (response.statusCode == 200) {
      setState(() {
        list = response.data['data'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('API Demo'),
        ),
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(obj: list[index])),
                  );
                  // Add the index to function call
                },
                
                // leading: CircleAvatar(
                //   child: Image.network(list[index]['avatar'],fit: BoxFit.cover),
                // ),
                // title: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       list[index]['email'],
                //       style: TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //     Text(
                //         '${list[index]['first_name']} ${list[index]['last_name']}')
                //   ],
                // ),
                // trailing: Icon(Icons.keyboard_arrow_right),
              );
            }));
  }
}

class DetailPage extends StatelessWidget {
  final dynamic obj;

  DetailPage({required this.obj});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Column(
  children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Image.network(obj['avatar']),


        ),
    Text('${obj['first_name']} ${obj['last_name']}'),
  ],
),
    );
  }
}

// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// class UserModel {
//   UserModel({
//     required this.page,
//     required this.perPage,
//     required this.total,
//     required this.totalPages,
//     required this.data,
//   });
//
//   int page;
//   int perPage;
//   int total;
//   int totalPages;
//   List<Datum> data;
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//     page: json["page"],
//     perPage: json["per_page"],
//     total: json["total"],
//     totalPages: json["total_pages"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "page": page,
//     "per_page": perPage,
//     "total": total,
//     "total_pages": totalPages,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     required this.id,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.avatar,
//   });
//
//   int id;
//   String email;
//   String firstName;
//   String lastName;
//   String avatar;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     email: json["email"],
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     avatar: json["avatar"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "email": email,
//     "first_name": firstName,
//     "last_name": lastName,
//     "avatar": avatar,
//   };
// }
