import java.sql.*;
// for specifically flightdata
// TODO: more error handling

class DataFile {
  Connection c;
  Statement s;
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
      String sql = "SELECT COUNT(" + DESTINATION_STATE_ABBREVIATION + ")"
        + "AS total FROM flights WHERE " + CANCELLED + "=\"1.00\" AND " + DESTINATION_STATE_ABBREVIATION + " = \"" + state + "\"";
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
      String sql = "SELECT COUNT(" + DESTINATION_STATE_ABBREVIATION + ")"
        + "AS total FROM flights WHERE " + DIVERTED + "=\"1.00\" AND " + DESTINATION_STATE_ABBREVIATION + " = \"" + state + "\"";
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
      String sql = "SELECT COUNT(" + ORIGIN_STATE_ABBREVIATION + ")"
        + "AS total FROM flights WHERE " + CANCELLED + "=\"1.00\" AND " + ORIGIN_STATE_ABBREVIATION + " = \"" + state + "\"";
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
      String sql = "SELECT COUNT(" + ORIGIN_STATE_ABBREVIATION + ")"
        + "AS total FROM flights WHERE " + DIVERTED + "=\"1.00\" AND " + ORIGIN_STATE_ABBREVIATION + " = \"" + state + "\"";
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
