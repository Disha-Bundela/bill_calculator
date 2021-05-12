import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillSplit extends StatefulWidget {
  @override
  _BillSplitState createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue, title: Text("Bill Split Calculator")),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(21.0),
          children: <Widget>[
            Container(
              width: 250,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.16),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total Rs. Per Person ",style: TextStyle(color: Colors.blue , fontWeight: FontWeight.w400 , fontSize: 17.0)),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Rs. ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800 , fontSize: 25.0)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueAccent.shade700,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12.5)),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.blue , fontSize: 20.0 , fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount : ",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Split",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 23.0,
                            color: Colors.blue.shade700),
                      ),


                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                }
                              });

                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.blueAccent.withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 40.0),
                                ),
                              ),
                            ),
                          ),

                          Text(
                            "$_personCounter",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),

                          InkWell(
                            onTap: () {
                              setState(() {
                                  _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.blueAccent.withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 40.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  //Tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tip",
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Rs . ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0),
                        ),
                      )
                    ],
                  ),

                  //slider
                  Column(
                    children: <Widget>[
                      Text(
                        "$_tipPercentage %",
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                      Slider(
                        min: 0,
                          max: 100,
                          activeColor: Colors.blue,
                          inactiveColor: Colors.blueGrey,
                          value: _tipPercentage.toDouble(),
                          divisions: 10,
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercentage = newValue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount , int splitBy , int tipPercentage){
    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) / splitBy ;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount , int splitBy  , int tipPercentage){
    double totalTip = 0.0;
    if(billAmount < 0 ||  billAmount.toString().isEmpty || billAmount == null){
      //error
    }
    else{
      totalTip = (billAmount * tipPercentage) / 100 ;
    }
    return totalTip;
  }
}
