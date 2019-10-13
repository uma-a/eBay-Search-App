import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loader_search_bar/loader_search_bar.dart';
import 'dart:convert';


Future<Welcome> fetchResults() async {
  final response =
  await http.get('https://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0&SECURITY-APPNAME=UmaAnnam-FlutterA-PRD-792db9319-4a8eee03&RESPONSE-DATA-FORMAT=JSON&keywords=nikeshoes&GLOBAL-ID=EBAY-US');
  if (response.statusCode == 200) {   //Check the response code to determine whether the JSON returned from the API call can be parsed
    var welcome = Welcome.fromJson(json.decode(response.body));
    return Welcome.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to retrieve data from API');
  }
}

//Serializing JSON inside model classes
Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<FindItemsByKeywordsResponse> findItemsByKeywordsResponse;

  Welcome({
    this.findItemsByKeywordsResponse,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    findItemsByKeywordsResponse: List<FindItemsByKeywordsResponse>.from(json["findItemsByKeywordsResponse"].map((x) => FindItemsByKeywordsResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "findItemsByKeywordsResponse": List<dynamic>.from(findItemsByKeywordsResponse.map((x) => x.toJson())),
  };
}

class FindItemsByKeywordsResponse {
  List<SearchResult> searchResult;

  FindItemsByKeywordsResponse({
  this.searchResult,
  });

  factory FindItemsByKeywordsResponse.fromJson(Map<String, dynamic> json) => FindItemsByKeywordsResponse(
      searchResult: List<SearchResult>.from(json["searchResult"].map((x) => SearchResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
  "searchResult": List<dynamic>.from(searchResult.map((x) => x.toJson())),
  };
}

class SearchResult {
  String count;
  List<Item> item;

  SearchResult({
    this.count,
    this.item,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
    count: json["@count"],
    item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "@count": count,
    "item": List<dynamic>.from(item.map((x) => x.toJson())),
  };
}

class Item {
  List<String> title;
  List<String> galleryUrl;
  List<SellingStatus> sellingStatus;
  List<String> paymentMethod;
  List<String> location;
  List<String> country;
  List<Condition> condition;

  Item({
    this.title,
    this.galleryUrl,
    this.sellingStatus,
    this.paymentMethod,
    this.condition,
    this.location,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    title: List<String>.from(json["title"].map((x) => x)),
    galleryUrl: List<String>.from(json["galleryURL"].map((x) => x)),
    sellingStatus: List<SellingStatus>.from(json["sellingStatus"].map((x) => SellingStatus.fromJson(x))),
    paymentMethod: List<String>.from(json["paymentMethod"].map((x) => x)),
    location: List<String>.from(json["location"].map((x) => x)),
    condition: List<Condition>.from(json["condition"].map((x) => Condition.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": List<dynamic>.from(title.map((x) => x)),
    "galleryURL": List<dynamic>.from(galleryUrl.map((x) => x)),
    "sellingStatus": List<dynamic>.from(sellingStatus.map((x) => x.toJson())),
    "paymentMethod": List<dynamic>.from(paymentMethod.map((x) => x)),
    "location": List<dynamic>.from(location.map((x) => x)),
    "condition": List<dynamic>.from(condition.map((x) => x.toJson())),
  };
}

class Condition {
  List<String> conditionId;
  List<String> conditionDisplayName;

  Condition({
    this.conditionId,
    this.conditionDisplayName,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    conditionId: List<String>.from(json["conditionId"].map((x) => x)),
    conditionDisplayName: List<String>.from(json["conditionDisplayName"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "conditionId": List<dynamic>.from(conditionId.map((x) => x)),
    "conditionDisplayName": List<dynamic>.from(conditionDisplayName.map((x) => x)),
  };
}

class SellingStatus {
  List<ConvertedCurrentPrice> currentPrice;
  List<ConvertedCurrentPrice> convertedCurrentPrice;
  List<String> sellingState;
  List<String> timeLeft;

  SellingStatus({
    this.currentPrice,
    this.convertedCurrentPrice,
    this.sellingState,
    this.timeLeft,
  });

  factory SellingStatus.fromJson(Map<String, dynamic> json) => SellingStatus(
    currentPrice: List<ConvertedCurrentPrice>.from(json["currentPrice"].map((x) => ConvertedCurrentPrice.fromJson(x))),
    convertedCurrentPrice: List<ConvertedCurrentPrice>.from(json["convertedCurrentPrice"].map((x) => ConvertedCurrentPrice.fromJson(x))),
    sellingState: List<String>.from(json["sellingState"].map((x) => x)),
    timeLeft: List<String>.from(json["timeLeft"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "currentPrice": List<dynamic>.from(currentPrice.map((x) => x.toJson())),
    "convertedCurrentPrice": List<dynamic>.from(convertedCurrentPrice.map((x) => x.toJson())),
    "sellingState": List<dynamic>.from(sellingState.map((x) => x)),
    "timeLeft": List<dynamic>.from(timeLeft.map((x) => x)),
  };
}

class ConvertedCurrentPrice {
  String currencyId;
  String value;

  ConvertedCurrentPrice({
    this.currencyId,
    this.value,
  });

  factory ConvertedCurrentPrice.fromJson(Map<String, dynamic> json) => ConvertedCurrentPrice(
    currencyId: json["@currencyId"],
    value: json["__value__"],
  );

  Map<String, dynamic> toJson() => {
    "@currencyId": currencyId,
    "__value__": value,
  };
}

class DetailScreen extends StatelessWidget {
  final Item item; // Declaring an Item class object to access and display item specific info fields

  // In the constructor
  DetailScreen({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the  to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title[0]),
      ),
      body: //Padding(
       Column(
         //padding: EdgeInsets.all(16.0),
        children: [
          Padding(padding: EdgeInsets.only(right: 200.0)),
          Image.network(
            item.galleryUrl[0],
            width: 200,
            height: 200
          ),
          Text('\$' + item.sellingStatus[0].convertedCurrentPrice[0].value),
          Text('Payment method: ' + item.paymentMethod[0]),
          Text('Current condition: ' + item.condition[0].conditionDisplayName[0]),
          Text('Location: ' + item.location[0])
        ],
      ),
    );
  }
}

void main() => runApp(MyApp(results: fetchResults()));
class MyApp extends StatelessWidget {
  final Future <Welcome> results;
MyApp({Key key, this.results}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print (results);
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
      appBar: SearchBar(
      defaultBar: AppBar(
        leading: IconButton(
       icon: Icon(Icons.menu),
       ),
       title: Text('ebay'),
       ),
      ),
        body: Center (
         child: FutureBuilder<Welcome>(
            future: results,
            builder: (context, snapshot) {
              if (snapshot.connectionState== ConnectionState.waiting){ //Displaying progress indicator until connection is in "done" state
                return CircularProgressIndicator();
              }
              if(snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              else if (snapshot.hasData) {
                print(snapshot.data.findItemsByKeywordsResponse[0].searchResult[0].item[0].title[0]);
                //return Text(snapshot.data.findItemsByKeywordsResponse[0].searchResult[0].item[0].title[0]);
              }

               return ListView.builder(
                 padding: const EdgeInsets.all(16.0),
                 itemBuilder: (context, index){
                   return ListTile(
                     title: Text(snapshot.data.findItemsByKeywordsResponse[0].searchResult[0].item[index].title[0]), //item[index] allows us to iterate to each item returned from the API call
                     onTap: () { //Setting up to take action when user taps on a specific tile within the displayed list
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => DetailScreen(item: snapshot.data.findItemsByKeywordsResponse[0].searchResult[0].item[index]), //When a tile is tapped, take the user to a screen with more details on the item
                         ),
                       );
                     },
                   );
                 },
               );
            },
          ),
        ),
      ),
    );
  }
}
