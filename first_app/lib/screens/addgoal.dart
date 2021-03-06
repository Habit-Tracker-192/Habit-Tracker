
import 'package:flutter/material.dart';
import 'dart:developer';

class AddGoal extends StatefulWidget {
  const AddGoal({Key? key}) : super(key: key);


  @override
  _AddGoalState createState() => _AddGoalState();
}

Map<int, Color> purple =
{
50:const Color.fromRGBO(100, 88, 204, .1),
100:const Color.fromRGBO(100, 88, 204, .2),
200:const Color.fromRGBO(100, 88, 204, .3),
300:const Color.fromRGBO(100, 88, 204, .4),
400:const Color.fromRGBO(100, 88, 204, .5),
500:const Color.fromRGBO(100, 88, 204, .6),
600:const Color.fromRGBO(100, 88, 204, .7),
700:const Color.fromRGBO(100, 88, 204, .8),
800:const Color.fromRGBO(100, 88, 204, .9),
900:const Color.fromRGBO(100, 88, 204, 1),
};


class _AddGoalState extends State<AddGoal> with TickerProviderStateMixin  {
  List<String> category = [];
  List<String> goal = [];
  final frequencies = [
      'Daily',
      'Weekly',
      'Monthly'
    ];

  late TabController _controller = TabController(length: 2, vsync:this);

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }
  
  TextEditingController _timesController = TextEditingController(text:1.toString());
  TextEditingController _durationController = TextEditingController(text:1.toString());
  TextEditingController _goalNameController = TextEditingController();
  TextEditingController _goalDescriptionController = TextEditingController();
  TextEditingController _categoryNameController = TextEditingController();
  TextEditingController _targetHoursController = TextEditingController(text:1.toString());
  TextEditingController _categoryDescriptionController = TextEditingController();
  TextEditingController _coverController = TextEditingController();

  
  String frequency = 'Daily';

  var _textformfield_times = GlobalKey<FormFieldState>();
  var _textformfield_duration = GlobalKey<FormFieldState>();
  var _textformfield_frequency = GlobalKey<FormFieldState>();
  var _textformfield_goalName = GlobalKey<FormFieldState>();
  var _textformfield_goalDescription = GlobalKey<FormFieldState>();
  var _textformfield_categoryName = GlobalKey<FormFieldState>();
  var _textformfield_targetHours = GlobalKey<FormFieldState>();
  var _textformfield_categoryDescription = GlobalKey<FormFieldState>();
  var _textformfield_cover = GlobalKey<FormFieldState>();
  String? value;

  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();

  Widget _buildPopupDialogGoal(BuildContext context) {
  return AlertDialog(
    title: const Text('Successfully added a Goal!'),
    content:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(goal.last),
        const Text("has been added to your Goal List"),
      ],
    ),
    actions: <Widget>[
       FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

  Widget _buildPopupDialogCategory(BuildContext context) {
  return AlertDialog(
    title: const Text('Successfully added a Category!'),
    content:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(category.last),
        const Text("has been added to your Category List"),
      ],
    ),
    actions: <Widget>[
       FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    
    DropdownMenuItem<String> buildMenuItem(String some) => DropdownMenuItem(
        value: some,
        child: Text(
          some, 
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 18,
          ),
        ),
      );

    MaterialColor themeColor= MaterialColor(0xFF5462CF, purple);
    return MaterialApp(
    theme: ThemeData(
      primarySwatch: themeColor,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor:const Color.fromRGBO(176,156,220, 1),
      shadowColor: Colors.grey,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row( 
          children: <Widget>[
            Image.asset('assets/images/habit_tracker_logo.png', fit: BoxFit.cover, width: 60, height:60, ),
            const Text('Habit Tracker'),
          ],
          ),
        ),
        body: 
              Container(
                alignment: Alignment.center,
                child: Container(
                  decoration: const BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                  height: 600.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  width: 360,
                  child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TabBar(controller: _controller,
                      indicatorColor: Colors.grey,
                      labelStyle: const TextStyle(
                        color:Colors.white,
                        fontSize: 22,
                        fontFamily: 'Poppins',
                      ),
                      indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // Creates border
                      color: const Color.fromRGBO(100, 88, 204, 1)),
                      unselectedLabelColor: Colors.grey,
                      tabs: const[
                        Tab(
                          text:'Category',
                        ),

                        Tab(
                          text:'Goal'
                        ),
                      ]
                    ),
                  Container(
                  height: 542.0,
                  width:360,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)
                    )
                  ),
                  child:  TabBarView(
                    controller: _controller,
                    children:  <Widget>[
                      Card(
                        child: Form(
                          key: _formKey3,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              TextFormField(
                                key: _textformfield_categoryName,
                                controller: _categoryNameController,
                                decoration: InputDecoration(
                                  hintText: 'Your Category Name',
                                  labelText: 'Category Name',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                ),
                                textInputAction: TextInputAction.done,
                                validator: (value){
                                  if (category.contains(value)){
                                    return 'Category Name already exists!';
                                  }
                                  else if (value!.isNotEmpty && value.length <= 14 ){
                                    return null;
                                  }
                                  else if (value.isEmpty){
                                    return 'Please add a category name';
                                  } 
                                  else {
                                    return 'Category Name is too long!';
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField( 
                                key: _textformfield_targetHours,
                                controller: _targetHoursController,
                                decoration:  InputDecoration(
                                  hintText: 'Total number of hours you want to achieve for this Category',
                                  labelText: 'Target Hours',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                ),
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'Please input your target hours';
                                  }
                                  else if (int.tryParse(value)! > 744){
                                    return 'You have exceeded the maximum target hours';
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),
                                              
                              SizedBox(height: 10),
                              TextFormField(
                                key: _textformfield_cover,
                                controller: _coverController,
                                decoration:  InputDecoration(
                                  hintText: 'Choose a cover for this category',
                                  labelText: 'Cover',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                  // errorText: _timesError,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                key: _textformfield_categoryDescription,
                                controller: _categoryDescriptionController,
                                decoration:  InputDecoration(
                                  hintText: 'Detailed description of your category.',
                                  labelText: 'Description',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                ),
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'Please add a goal description';
                                  }
                                  else if (value.isNotEmpty && value.length <= 99 ){
                                    return null;
                                  } 
                                  else {
                                    return 'Category description is too long!';
                                  }
                                },
                                keyboardType: TextInputType.multiline,
                              ),
                              SizedBox(height: 10),
                              MaterialButton(
                                minWidth: 40,
                                onPressed: (){
                                  if (_formKey3.currentState!.validate()) {
                                    category.add(_categoryNameController.text);
                                    showDialog(
                                       context: context,
                                       builder: (BuildContext context) => _buildPopupDialogCategory(context),
                                    );
                                    print(category);
                                  }
                                  else{
                                    return null;
                                  }
                                },  
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                                  ),
                                child: const Text('Add'),
                                textColor: Colors.white,
                                color: const Color.fromRGBO(100, 88, 204, 1),
                              ),
                            ]
                          ),
                        ),
                      ),
                      Card(
                        child: Form(
                          key: _formKey4,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              TextFormField(
                                key: _textformfield_goalName,
                                controller: _goalNameController,
                                decoration: InputDecoration(
                                  hintText: 'Your Goal Name',
                                  labelText: 'Goal Name',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                ),
                                textInputAction: TextInputAction.done,
                                validator: (value){
                                  if (goal.contains(value)){
                                    return 'Goal Name already exists!';
                                  }
                                  else if (value!.isNotEmpty && value.length <= 24 ){
                                    return null;
                                  }
                                  else if (value.isEmpty){
                                    return 'Please add a goal name';
                                  } 
                                  else {
                                    return 'Goal Name is too long!';
                                  }
                                },
                              ),
                                              
                              TextFormField(   
                                decoration:  InputDecoration(
                                  
                                  hintText: 'Which one of your Categories does this Goal belong?',
                                  labelText: 'Category',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                ),
                              ),
                                              
                              DropdownButtonFormField<String>(
                                value: value,
                                key: _textformfield_frequency,
                                dropdownColor: Color.fromARGB(255 ,221,223,245),
                                isExpanded: true,
                                items: frequencies.map(buildMenuItem).toList(),
                                onChanged: (value) => setState(() => frequency = value!),
                                iconEnabledColor:  const Color.fromRGBO(100, 88, 204, 1),
                                style: const TextStyle(
                                  color:  Color.fromRGBO(100, 88, 204, 1),
                                ),
                                decoration:  InputDecoration(
                                  hintText: 'How often would you like to achieve your goal?',
                                  labelText: 'Frequency',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                ),
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'you must choose a frequency';
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),
                                              
                              TextFormField(
                                key: _textformfield_times,
                                controller: _timesController,
                                decoration:  InputDecoration(
                                  hintText: 'Adjust if you want more than once a day/week/month',
                                  labelText: 'Times',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                  // errorText: _timesError,
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val){
                                  if (val!.isEmpty){
                                    return 'Please put your desired number of repetition/s';
                                  }
                                              
                                  else if (frequency == 'Daily' && double.tryParse(val)!<= 24 ){
                                    return null;
                                  }
                                  
                                  else if (frequency == 'Weekly' && double.tryParse(val)!<= 6 ){
                                    return null;
                                  }
                                              
                                  else if (frequency == 'Monthly' && double.tryParse(val)!<= 30 ){
                                    return null;
                                  }
                                              
                                  else {
                                    return 'You have exceeded the maximum amount of repetitions';
                                  } 
                                },
                              ),
                                              
                              TextFormField(
                                key: _textformfield_duration,
                                controller: _durationController,
                                decoration:  InputDecoration(
                                  hintText: 'How many hours would it take?',
                                  labelText: 'Duration',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'Please enter duration';
                                  }
                                  else if (frequency == 'Daily' && (int.tryParse(value)!*int.tryParse(_timesController.text)!)  > 24){
                                    return 'Duration exceeded number of hours per day!';
                                  }
                                  else if (frequency == 'Weekly' && (int.tryParse(value)!*int.tryParse(_timesController.text)!) > 168){
                                    return 'Duration exceeded number of hours per week!';
                                  }
                                  else if (frequency == 'Monthly' && (int.tryParse(value)!* int.tryParse(_timesController.text)!) > 744){
                                    return 'Duration exceeded number of hours per month!';
                                  }
                                },
                              ),
                                              
                              TextFormField(
                                key: _textformfield_goalDescription,
                                controller: _goalDescriptionController,
                                decoration:  InputDecoration(
                                  hintText: 'Detailed description of your goal.',
                                  labelText: 'Description',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color:  Color.fromRGBO(100, 88, 204, 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color.fromARGB(255 ,221,223,245),
                                  filled: true,
                                ),
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'Please add a goal description';
                                  }
                                  else if (value.isNotEmpty && value.length <= 99 ){
                                    return null;
                                  } 
                                  else {
                                    return 'Goal description is too long!';
                                  }
                                },
                                keyboardType: TextInputType.multiline,
                              ),
                              
                              MaterialButton(
                                minWidth: 40,
                                onPressed: (){
                                  if (_formKey4.currentState!.validate()){
                                     goal.add(_goalNameController.text);
                                     showDialog(
                                       context: context,
                                       builder: (BuildContext context) => _buildPopupDialogGoal(context),
                                     );
                                  }
                                  else{}
                                },  
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                                  ),
                                child: const Text('Add'),
                                textColor: Colors.white,
                                color: const Color.fromRGBO(100, 88, 204, 1),
                              ),
                            ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  ],
                          ),
                ),
              ),
        ),     
      );
  }
}
