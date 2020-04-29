import 'dart:convert';
import 'package:http/http.dart' as http;

Future getAffectedCountry() async {
  print("getting the affectedCountry");
  var response = await http.get(
    "https://coronavirus-monitor.p.rapidapi.com/coronavirus/affected.php",
    headers: {
      "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
      "x-rapidapi-key": "cc05c34800mshe3478569f3ce412p10039cjsn6cc35bc2595c"
    },
  );
  var data = json.decode(response.body);
  //print(data);
  data = data["affected_countries"];
  return data;
}

Future getTotalStat() async {
  print("getting the total affected");
  var response = await http.get(
    "https://coronavirus-monitor.p.rapidapi.com/coronavirus/worldstat.php",
    headers: {
      "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
      "x-rapidapi-key": "cc05c34800mshe3478569f3ce412p10039cjsn6cc35bc2595c"
    },
  );
  var data = json.decode(response.body);
  return data;
}

Future getCasesByCountry() async {
  print("getting the cases by Country");
  var response = await http.get(
    "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_country.php",
    headers: {
      "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
      "x-rapidapi-key": "cc05c34800mshe3478569f3ce412p10039cjsn6cc35bc2595c"
    },
  );
  var data = json.decode(response.body);
  return data;
}

Future getStateData() async {
  var url =
      "https://script.googleusercontent.com/macros/echo?user_content_key=XWRFkjV-cpz_EyBAdSsTDEi2dh2I1mEWL-z6mz8zVDpYvJIxFgi4aTxF0sD70WAGSL3io3LtO3BKZ21WJJlfvZqLkNSxYYrDm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnKXFvsR88vL4WiBr168omFadgngDnj25DLpEvLRaiIpzZr1NvbW-Bo38vshdDBv10tpytj_A4aoE&lib=Mm1FD1HVuydJN5yAB3dc_e8h00DPSBbB3";
  var response = await http.get(url);
  return json.decode(response.body);
}
