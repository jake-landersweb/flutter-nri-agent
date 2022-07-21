import 'package:http/http.dart' as http;
import 'package:integration_test/newrelic.dart';

// function for testing api response times
Future<bool> sendRequest() async {
  try {
    // start a timer
    final stopwatch = Stopwatch()..start();
    // use sample api from sampleapis.com
    var response = await http.get(
      Uri.parse('https://api.sampleapis.com/codingresources/codingResources'),
    );
    print(response.body);
    print("Response excecuted in: ${stopwatch.elapsed.inMilliseconds}ms");

    // send the custom event of the time
    var nriresponse = await NRIFlutter.setCustomValue(
      "Flutter",
      name: "Flutter",
      attributes: {
        "networkLatency": stopwatch.elapsed.inMilliseconds.toDouble()
      },
    );

    print("NRI Response = $nriresponse");

    return true;
  } catch (error) {
    return false;
  }
}
