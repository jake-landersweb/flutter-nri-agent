import 'package:http/http.dart' as http;
import 'package:integration_test/newrelic.dart';

Future<bool> sendRequest() async {
  try {
    // use sample api from sampleapis.com
    final stopwatch = Stopwatch()..start();
    var response = await http.get(
      Uri.parse('https://api.sampleapis.com/codingresources/codingResources'),
    );
    print(response.body);
    print("Response excecuted in: ${stopwatch.elapsed.inMilliseconds}ms");

    // send new relic event
    // var nriresponse = await NRIFlutter.setDoubleValue(
    //   "networkLatency",
    //   stopwatch.elapsed.inMilliseconds.toDouble(),
    // );
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
