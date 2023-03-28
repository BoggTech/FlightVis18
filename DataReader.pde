import java.io.FileReader;
import java.util.Scanner;

 ArrayList<FlightObject> flightObjects = new ArrayList<>();
class DataReader {
  String fileAddress = "flights2k.csv";

  DataReader() {
    read_in_the_file();
  }

  void read_in_the_file() {
    String flightDate;
    double IATACode;
    double flightNumber;
    String originAirport;
    String originCity;
    String originState;
    double originWac;
    String dest;
    String destCity;
    String destState;
    double destWac;
    double depTime;
    double crsArrTime;
    double arrTime;
    double cancelled;
    double distance;


    int flightDateLocal = -1;
    int iataCodeLocal = -1;
    int flightNumberLocal = -1;
    int originLocal = -1;
    int originCityLocal = -1;
    int originStateLocal = -1;
    int originWacLocal = -1;
    int destLocal = -1;
    int destCityLocal = -1;
    int destStateLocal = -1;
    int destWacLocal = -1;
    int depTimeLocal = -1;
    int crsArrTimeLocal = -1;
    int arrTimeLocal = -1;
    int cancelledLocal = -1;
    int distanceLocal = -1;

    try {
      BufferedReader br = createReader(fileAddress);
      String line = null;
      line = br.readLine();
      String[] lineSplit = line.split(",");
      for (int i = 0; i < lineSplit.length; i++) {
        if (lineSplit[i].equalsIgnoreCase("fl_date")) {
          flightDateLocal = i;
        }
        if (lineSplit[i].equalsIgnoreCase("mkt_carrier")) {
          iataCodeLocal = i;
        }
        if (lineSplit[i].equalsIgnoreCase("mkt_Carrier_fl_num")) {
          flightNumberLocal = i;
        }
        if (lineSplit[i].equalsIgnoreCase("origin")) {
          originLocal = i;
        }
        if (lineSplit[i].equalsIgnoreCase("origin_city_name")) {
          originCityLocal = i;
        }
        if (lineSplit[i].equalsIgnoreCase("origin_state_ABR")) {
          originStateLocal = i + 1;
        }
        if (lineSplit[i].equalsIgnoreCase("origin_WAC")) {
          originWacLocal = i + 1;
        }
        if (lineSplit[i].equalsIgnoreCase("dest")) {
          destLocal = i + 1;
        }
        if (lineSplit[i].equalsIgnoreCase("dest_city_name")) {
          destCityLocal = i + 1;
        }
        if (lineSplit[i].equalsIgnoreCase("dest_state_abr")) {
          destStateLocal = i + 2;
        }
        if (lineSplit[i].equalsIgnoreCase("dest_WAC")) {
          destWacLocal = i + 2;
        }
        if (lineSplit[i].equalsIgnoreCase("dep_time")) {
          depTimeLocal = i + 2;
        }
        if (lineSplit[i].equalsIgnoreCase("CRS_arr_time")) {
          crsArrTimeLocal = i + 2;
        }
        if (lineSplit[i].equalsIgnoreCase("arr_time")) {
          arrTimeLocal = i + + 2;
        }
        if (lineSplit[i].equalsIgnoreCase("cancelled")) {
          cancelledLocal = i + 2;
        }
        if (lineSplit[i].equalsIgnoreCase("distance")) {
          distanceLocal = i + 2;
        }
      }

      while ((line = br.readLine()) != null) {
        lineSplit = line.split(",");

        flightDate = lineSplit[flightDateLocal];
        originAirport = lineSplit[originLocal];
        originCity = lineSplit[originCityLocal];
        originCity = originCity + ", " + lineSplit[originCityLocal+1];
        originState= lineSplit[originStateLocal];
        dest = lineSplit[destLocal];
        destCity = lineSplit[destCityLocal];
        destState = lineSplit[destStateLocal];
        destCity = destCity + ", " + lineSplit[destCityLocal +1];

        try {
          IATACode = Double.parseDouble(lineSplit[iataCodeLocal]);
        }
        catch (NumberFormatException e) {
          IATACode = Double.MIN_VALUE;
        }
        try {
          flightNumber = Double.parseDouble(lineSplit[flightNumberLocal]);
        }
        catch (NumberFormatException e) {
          flightNumber = Double.MIN_VALUE;
        }
        try {
          originWac = Double.parseDouble(lineSplit[originWacLocal]);
        }
        catch (NumberFormatException e) {
          originWac = Double.MIN_VALUE;
        }
        try {
          destWac = Double.parseDouble(lineSplit[destWacLocal]);
        }
        catch (NumberFormatException e) {
          destWac = Double.MIN_VALUE;
        }
        try {
          originWac = Double.parseDouble(lineSplit[originWacLocal]);
        }
        catch (NumberFormatException e) {
          originWac = Double.MIN_VALUE;
        }
        try {
          depTime = Double.parseDouble(lineSplit[depTimeLocal]);
        }
        catch (NumberFormatException e) {
          depTime = Double.MIN_VALUE;
        }
        try {
          crsArrTime = Double.parseDouble(lineSplit[crsArrTimeLocal]);
        }
        catch (NumberFormatException e) {
          crsArrTime = Double.MIN_VALUE;
        }
        try {
          arrTime = Double.parseDouble(lineSplit[arrTimeLocal]);
        }
        catch (NumberFormatException e) {
          arrTime = Double.MIN_VALUE;
        }
        try {
          cancelled = Double.parseDouble(lineSplit[cancelledLocal]);
        }
        catch (NumberFormatException e) {
          cancelled = Double.MIN_VALUE;
        }
        try {
          distance = Double.parseDouble(lineSplit[distanceLocal]);
        }
        catch (NumberFormatException e) {
          distance = Double.MIN_VALUE;
        }
        FlightObject f = new FlightObject(flightDate, originAirport, originCity, originState, dest, destCity, destState, IATACode, flightNumber, originWac, destWac, cancelled, distance, arrTime, depTime, crsArrTime);
        flightObjects.add(f);
      }

      br.close();
    }
    catch (Exception e) {
      println("The given file is not correct");
    }
  }
}
