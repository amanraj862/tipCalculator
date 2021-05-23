import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class BillSplit extends StatefulWidget {
  @override
  _BillSplitState createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  int _personCounter = 0;
  double _billAmount = 0.0;
  int _tipPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("##dff9fb"),
      appBar: AppBar(
        title: Center(child: Text("Tip calculator")),
        backgroundColor: HexColor("#2C3A47"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Per Person",
                      style: GoogleFonts.getFont(
                        'Acme',
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "₹ ${calculateTotalPerson(_billAmount, _personCounter, _tipPercentage)}",
                        style: GoogleFonts.getFont(
                          'Acme',
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: HexColor("##58B19F").withOpacity(0.5),
                border:
                    Border.all(color: Colors.black12, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: HexColor("##58B19F").withOpacity(0.5),
                    border: Border.all(
                        color: Colors.black12, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  children: [
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor("#58B19F"), width: 1.0),
                        ),
                        hintText: '₹ Bill Amount',
                      ),
                      cursorColor: HexColor("#58B19F"),
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
                      children: [
                        Text(
                          "Split",
                          style: GoogleFonts.getFont(
                            'Acme',
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_personCounter > 1) {
                                    _personCounter--;
                                  }
                                });
                              },
                              child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: HexColor("#58B19F").withOpacity(0.8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  )),
                            ),
                            Text(
                              "$_personCounter",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _personCounter++;
                                });
                              },
                              child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: HexColor("#58B19F").withOpacity(0.8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tip",
                          style: GoogleFonts.getFont(
                            'Acme',
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "₹ ${calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}",
                            style: GoogleFonts.getFont(
                              'Acme',
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "$_tipPercentage%",
                          style: GoogleFonts.getFont(
                            'Acme',
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Slider(
                            min: 0,
                            max: 30,
                            activeColor: HexColor("#58B19F"),
                            inactiveColor: HexColor("#58B19F").withOpacity(0.5),
                            value: _tipPercentage.toDouble(),
                            onChanged: (double newValue) {
                              setState(() {
                                _tipPercentage = newValue.round();
                              });
                            }),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  calculateTotalPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
