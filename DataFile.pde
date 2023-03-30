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

  float getAverageDistance() {
    return getAverage(DISTANCE);
  }

  void testFunction() {
    try {
      String sql = "SELECT * FROM flights WHERE ORIGIN = \"JFK\"";
      ResultSet rs = s.executeQuery(sql);
      while ( rs.next() ) {
        println(rs.getString(ORIGIN_CITY));
        println(rs.getString(DESTINATION_CITY));
      }
    }
    catch ( SQLException e ) {
      handleSQLException(e);
    }
  }

  private int getEqualsCount(String query, String equality) {
    try {
      String sql = "SELECT COUNT(" + query + ") AS total FROM flights WHERE " + query + "=\"" + equality + "\"";
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
