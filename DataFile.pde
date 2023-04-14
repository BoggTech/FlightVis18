import java.sql.*;

// DataFile // Author: Darryl Boggins //
// DataFile is where we'll wrap most of the SQLite queries for flights.db.
// It takes in the filename of the database and pull it, loads it, etc.
// Then, methods can be run to make different queries

class DataFile {
  Connection c;
  Statement s;
  DataFile(String fileName) {
    // we should set up our SQLite database.
    c = null;
    s = null;
    try {
      Class.forName("org.sqlite.JDBC");
      // JDBC driver required for this.
      c = DriverManager.getConnection("jdbc:sqlite:" +fileName);
      s = c.createStatement();
    }
    catch ( Exception e ) {
      System.err.println(e.getClass().getName() + ": " + e.getMessage());
      System.exit(0);
    }
  }

  // returns the overall total number of flights as an int
  int getTotal() {
    try {
      String sql = "SELECT COUNT(*) AS total FROM flights";
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }

  // returns the overall total number of cancelled flights as an int
  int getTotalCancelled() {
    return getEqualsCount(CANCELLED, "1.00");
  }

  // returns the overall total number of diverted flights as an int
  int getTotalDiverted() {
    return getEqualsCount(DIVERTED, "1.00");
  }

  // returns an int describing how many flights have this as an destination state
  int getTotalDestState(String state) {
    return getEqualsCount(DESTINATION_STATE_ABBREVIATION, state);
  }

  // returns an int describing how many flights have this as an origin state
  int getTotalOriginState(String state) {
    return getEqualsCount(ORIGIN_STATE_ABBREVIATION, state);
  }

  // returns an int describing how many flights have been cancelled in this state where it is the destination (use abbreviation)
  int countCancelledDestState(String state) {
    try {
      String sql = String.format("SELECT COUNT(%s) AS total FROM flights WHERE %s=\"1.00\" AND %s = \"%s\"",
        DESTINATION_STATE_ABBREVIATION, CANCELLED, DESTINATION_STATE_ABBREVIATION, state);
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }

  // returns an int describing how many flights have been diverted in this state where it is the destination (use abbreviation)
  int countDivertedDestState(String state) {
    try {
      String sql = String.format("SELECT COUNT(%s) AS total FROM flights WHERE %s=\"1.00\" AND %s = \"%s\"",
        DESTINATION_STATE_ABBREVIATION, DIVERTED, DESTINATION_STATE_ABBREVIATION, state);
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }

  // returns an int describing how many flights have been cancelled in this state where it is the origin (use abbreviation)
  int countCancelledOriginState(String state) {
    try {
      String sql = String.format("SELECT COUNT(%s) AS total FROM flights WHERE %s=\"1.00\" AND %s = \"%s\"",
        ORIGIN_STATE_ABBREVIATION, CANCELLED, ORIGIN_STATE_ABBREVIATION, state);
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }

  // returns an int describing how many flights have been diverted in this state where it is the origin (use abbreviation)
  int countDivertedOriginState(String state) {
    try {
      String sql = String.format("SELECT COUNT(%s) AS total FROM flights WHERE %s=\"1.00\" AND %s = \"%s\"",
        ORIGIN_STATE_ABBREVIATION, DIVERTED, ORIGIN_STATE_ABBREVIATION, state);
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }

  // returns how many flights have been cancelled in this state, where the flight is either dest or origin
  // (no duplicates; e.g. TX as dest and origin will be one flight.)
  int countCancelledState(String state) {
    try {
      String sql = String.format("SELECT COUNT(*) AS total FROM flights WHERE %s=\"1.00\" AND (%s = \"%s\" OR %s = \"%s\")",
        CANCELLED, ORIGIN_STATE_ABBREVIATION, state, DESTINATION_STATE_ABBREVIATION, state);
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }

  // returns how many flights have occured in this state, where the flight is either dest or origin
  // (no duplicates; e.g. TX as dest and origin will be one flight.)
  int countTotalState(String state) {
    try {
      String sql = String.format("SELECT COUNT(*) AS total FROM flights WHERE (%s = \"%s\" OR %s = \"%s\")",
        ORIGIN_STATE_ABBREVIATION, state, DESTINATION_STATE_ABBREVIATION, state);
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }

  // returns how many diverted flights have occured in this state, where the flight is either dest or origin
  // (no duplicates; e.g. TX as dest and origin will be one flight.)
  int countDivertedState(String state) {
    try {
      String sql = String.format("SELECT COUNT(*) AS total FROM flights WHERE %s=\"1.00\" AND (%s = \"%s\" OR %s = \"%s\")",
        DIVERTED, ORIGIN_STATE_ABBREVIATION, state, DESTINATION_STATE_ABBREVIATION, state);
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }


  // makes a query to the database and returns a 2d array of "interval" values, offset by "offset".
  // it will search in "field" for values that match the query, and may be strict (has to exactly match the search) or not (has to have the text SOMEWHERE)
  // based on the value of strict.
  String[][] getResults(int interval, int offset, String field, String query, boolean strict) {
    try {
      // SQL INJECTION BABEYYYYYYY WOOOOOOOOOOOOOO
      String condition;
      if ( !strict ) {
        condition = "%%%s%%";
      } else {
        condition = "%s";
      }
      String sql = String.format("SELECT ROWID, * FROM flights WHERE %s LIKE \"" + condition + "\" LIMIT %s OFFSET %s", field, query, interval, offset);
      ResultSet rs = s.executeQuery(sql);
      ArrayList<String[]> returnValue = new ArrayList<String[]>();
      while ( rs.next() ) {
        String[] strings = {
          rs.getString("rowid"), // 0
          rs.getString(FLIGHT_DATE), // 1
          rs.getString(CARRIER), // 2
          rs.getString(CARRIER_ID), // 3
          rs.getString(ORIGIN), // 4
          rs.getString(ORIGIN_CITY), // 5
          rs.getString(ORIGIN_STATE_ABBREVIATION), // 6
          rs.getString(ORIGIN_WORLD_AREA_CODE), // 7
          rs.getString(DESTINATION), // 8
          rs.getString(DESTINATION_CITY), // 9
          rs.getString(DESTINATION_STATE_ABBREVIATION), // 10
          rs.getString(DESTINATION_WORLD_AREA_CODE), // 11
          rs.getString(SCHEDULED_DEPARTURE), // 12
          rs.getString(DEPARTURE), // 13
          rs.getString(SCHEDULED_ARRIVAL), // 14
          rs.getString(CANCELLED), // 15
          rs.getString(DIVERTED), // 16
          rs.getString(DISTANCE)  // 17
        };

        returnValue.add(strings);
      }
      String[][] stringArray = new String[returnValue.size()][17];
      stringArray = returnValue.toArray(stringArray);
      return stringArray;
    }
    catch (SQLException e ) {
      handleSQLException(e);
      return null;
    }
  }

  // makes a query to the database and returns the TOTAL AMOUNT of results.
  // it will search in "field" for values that match the query, and may be strict (has to exactly match the search) or not (has to have the text SOMEWHERE)
  // based on the value of strict.
  int getResultsCount(String field, String query, boolean strict) {
    String condition;
    if ( !strict ) {
      condition = "%%%s%%";
    } else {
      condition = "%s";
    }
    try {
      String sql = String.format("SELECT COUNT(*) AS total FROM flights WHERE %s LIKE \"" + condition + "\"", field, query);
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }

  // returns the average distance travelled of all flights.
  float getAverageDistance() {
    return getAverage(DISTANCE);
  }

  // a variation of getEqualsCount that uses "query" for both query and checkValue
  private int getEqualsCount(String query, String equality) {
    return getEqualsCount(query, query, equality);
  }

  // private method that will return the count of fields "query" where "checkValue" equals to "equality"
  private int getEqualsCount(String query, String checkValue, String equality) {
    try {
      String sql = "SELECT COUNT(" + query + ") AS total FROM flights WHERE " + checkValue + "=\"" + equality + "\"";
      ResultSet rs = s.executeQuery(sql);
      return rs.getInt("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }

  // returns the average value of all values in the field "query"
  private float getAverage(String query) {
    try {
      String sql = "SELECT AVG(" + query + ") AS total FROM flights";
      ResultSet rs = s.executeQuery(sql);
      return rs.getFloat("total");
    }
    catch ( SQLException e ) {
      handleSQLException(e);
      return -1;
    }
  }
  
   
  // print info on an exception
  private void handleSQLException(SQLException e) {
    System.err.println("Something went wrong. " + e.getMessage());
  }
}
