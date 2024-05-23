import 'package:assignment_liveintuition/Provider/quotes_provider.dart';
import 'package:assignment_liveintuition/Ui_elements/custome_button.dart';
import 'package:assignment_liveintuition/layout/app_bar.dart';
import 'package:flutter/material.dart';

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  String _quote = '';
  String _author = '';

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }


  Future<void> fetchQuote() async {
    try {

      final quoteData = await QuoteProvider().getRandomQuote();

      setState(() {
        _quote = quoteData['content'];
        _author = quoteData['originator']['name'];

      });
    } catch (e) {
      setState(() {
        _quote = 'Failed to fetch quote';
        _author = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body:Center(
        child:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _quote,
                        style: TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        '- $_author',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.lightGreen,
                            fontStyle: FontStyle.italic
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Get Another quotes",
                onPressed: fetchQuote,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
