import java.sql.*;
// for specifically flightdata
// TODO: more error handling

class DataFile {
  Connection c;
  Statement s;
  SearchBar  search = new SearchBar();
  DataFile(String fileName) {
    c = null;
    s = null;
    try {
      Class.forName("org.sqlite.JDBC");
      c = DriverManager.getConnection("jdbc:sqlite:" +fileName);
      s = c.createStatement();
    }
    catch ( Exception e ) {
      System.err.println( e.getClass().getName() + ": " + e.getMessage() );
      System.exit(0);
    }
  }

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

  int getTotalCancelled() {
    return getEqualsCount(CANCELLED, "1.00");
  }

  int getTotalDiverted() {
    return getEqualsCount(DIVERTED, "1.00");
  }

  // return how many flights have this destination state
  int getTotalDestState(String state) {
    return getEqualsCount(DESTINATION_STATE_ABBREVIATION, state);
  }

  // return how many flights have this origin state
  int getTotalOriginState(String state) {
    return getEqualsCount(ORIGIN_STATE_ABBREVIATION, state);
  }

  // return how many cancelled flights with this destination state
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

  String[][] getResults(int interval, int offset, String field, String query) {
    try {
      // SQL INJECTION BABEYYYYYYY WOOOOOOOOOOOOOO
      String sql = String.format("SELECT ROWID, * FROM flights WHERE %s LIKE \"%%%s%%\" LIMIT %s OFFSET %s", field, query, interval, offset);
      ResultSet rs = s.executeQuery(sql);
      int i = 0;
      ArrayList<String[]> returnValue = new ArrayList<String[]>();
      while ( rs.next() ) {
        String[] strings = {
          rs.getString("rowid"),
          rs.getString(FLIGHT_DATE),
          rs.getString(CARRIER),
          rs.getString(CARRIER_ID),
          rs.getString(ORIGIN),
          rs.getString(ORIGIN_CITY),
          rs.getString(ORIGIN_STATE_ABBREVIATION),
          rs.getString(ORIGIN_WORLD_AREA_CODE),
          rs.getString(DESTINATION),
          rs.getString(DESTINATION_CITY),
          rs.getString(DESTINATION_STATE_ABBREVIATION),
          rs.getString(DESTINATION_WORLD_AREA_CODE),
          rs.getString(SCHEDULED_DEPARTURE),
          rs.getString(DEPARTURE),
          rs.getString(SCHEDULED_ARRIVAL),
          rs.getString(CANCELLED),
          rs.getString(DIVERTED),
          rs.getString(DISTANCE)
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

  float getAverageDistance() {
    return getAverage(DISTANCE);
  }

  private int getEqualsCount(String query, String equality) {
    return getEqualsCount(query, query, equality);
  }

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

  private void handleSQLException(SQLException e) {
    System.err.println("Something went wrong. " + e.getMessage());
  }
}
