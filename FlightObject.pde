class FlightObject {
  final String flightDate;
  final double IATACode;
  final double flightNumber;
  final String originAirport;
  final String originCity;
  final String originState;
  final double originWac;
  final String dest;
  final String destCity;
  final String destState;
  final double destWac;
  final double depTime;
  final double crsArrTime;
  final double arrTime;
  final double cancelled;
  final double distance;
  
  FlightObject() {
    flightDate = null;
    originAirport = null;
    originCity = null;
    originState = null;
    dest = null;
    destCity = null;
    destState = null;
    IATACode = Double.MAX_VALUE;
    flightNumber = Double.MAX_VALUE;
    originWac = Double.MAX_VALUE;
    destWac = Double.MAX_VALUE;
    depTime = Double.MAX_VALUE;
    crsArrTime = Double.MAX_VALUE;
    arrTime = Double.MAX_VALUE;
    cancelled = Double.MAX_VALUE;
    distance = Double.MAX_VALUE;
  }
  
  FlightObject(String flightDate, String originAirport,  String originCity, String originState, String dest, String destCity, String destState, Double IATACode, Double flightNumber, Double originWac, Double destWac, Double cancelled, Double distance, Double arrTime, Double depTime, Double crsArrTime) {
    this.flightDate = flightDate;
    this.originAirport = originAirport;
    this.originCity = originCity;
    this.originState = originState;
    this.dest = dest;
    this.destCity = destCity;
    this.destState = destState;
    this.IATACode = IATACode;
    this.flightNumber = flightNumber;
    this.originWac = originWac;
    this.destWac = destWac;
    this.cancelled = cancelled;
    this.distance = distance;
    this.arrTime = arrTime;
    this.depTime = depTime;
    this.crsArrTime = crsArrTime;
  }
  
  String getFlightDate() {
      return flightDate;
  }
  
  String getOriginAirport() {
        return originAirport;
  }
  
  String getOriginCity() {
    return originCity;
  }
  
   String getOriginState() {
    return originState;
  }
  
  String getDest() {
     return dest;
  }
  
  String getDestCity() {
     return destCity;
  }
  
  String getDestState() {
     return destState;
  }
  
  Double getIATACode() {
    return IATACode;
  }
  
  Double getFlightNumber() {
    return flightNumber;
  }
  
  Double getOriginWac() {
    return originWac;
  }
  
  Double getDestWac() {
    return flightNumber;
  }
  
  Double getDepTime() {
    return depTime;
  }
  
  Double getArrTime() {
    return arrTime;
  }
  
  Double getCrsArrTime() {
    return crsArrTime;
  }
  
  Double getDistance() {
    return distance;
  }
  
  Double getCancelled() {
    return cancelled;
  }
  
}  
