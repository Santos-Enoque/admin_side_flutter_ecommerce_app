import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../db/category.dart';
import '../db/brand.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;





  @override
  void initState() {
    _getCategories();
//    _getBrands();
    categoriesDropDown = getCategoriesDropdown();
  }

 getCategoriesDropdown(){
    List<DropdownMenuItem<String>> items = new List();
    for(int i = 0; i < categories.length; i++){
      setState(() {
        categoriesDropDown.insert(0, DropdownMenuItem(child: Text(categories[i]['category']),
            value: categories[i]['category']));
      });
    }
    print(items.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(Icons.close, color: black,),
        title: Text("add product", style: TextStyle(color: black),),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                          child: new Icon(Icons.add, color: grey,),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                          child: new Icon(Icons.add, color: grey,),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                          child: new Icon(Icons.add, color: grey,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('enter a product name with 10 characters at maximum',textAlign: TextAlign.center ,style: TextStyle(color: red, fontSize: 12),),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    hintText: 'Product name'
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'You must enter the product name';
                    }else if(value.length > 10){
                      return 'Product name cant have more than 10 letters';
                    }
                  },
                ),
              ),

//              select category

              Visibility(
                visible: _currentCategory != null || _currentCategory == '',
                child: Text(_currentCategory ?? "null", style: TextStyle(color: red)),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'add category'
                      )
                  ),
                  suggestionsCallback: (pattern) async {
                    return await _categoryService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(suggestion['category']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _currentCategory = suggestion['category'];
                    });
                  },
                ),
              ),

//            select brand

              Visibility(
                visible: _currentBrand != null || _currentBrand == '',
                child: Text(_currentBrand ?? "null", style: TextStyle(color: red)),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      decoration: InputDecoration(
                          hintText: 'add brand'
                      )
                  ),
                  suggestionsCallback: (pattern) async {
                    return await _brandService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(suggestion['brand']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _currentBrand = suggestion['brand'];
                    });
                  },
                ),
              ),

              FlatButton(
                color: red,
                textColor: white,
                child: Text('add product'),
                onPressed: (){},
              )
            ],
          ),
        ),
      ),
    );
  }

   _getCategories() async{
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      print(categories.length);
    });
   }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }
}
