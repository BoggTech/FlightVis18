import java.sql.*;
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
  
  private void handleSQLException(SQLException e) {
    System.err.println("Something went wrong. " + e.getMessage());
  }
}
