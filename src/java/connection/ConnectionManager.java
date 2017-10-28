package connection;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * To create a Connection object for use
 */
public class ConnectionManager {

  private static final String PROPS_FILENAME = "connection.properties";
  private static String dbUser;
  private static String dbPassword;
  private static String dbURL;

  static {
    // grab environment variable
    String host = System.getenv("OPENSHIFT_MYSQL_DB_HOST");
    if (host != null) {
      // this is production environment
      // obtain database connection properties from environment variables
      String port = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
      String dbName = System.getenv("OPENSHIFT_APP_NAME");
      dbUser = System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
      dbPassword = System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");

      dbURL = "jdbc:mysql://" + host + ":" + port + "/" + dbName;

    } else {
      // this is development environment
      // obtain database connection properties from properties file

      try {
        // Retrieve properties from connection.properties via the CLASSPATH
        // WEB-INF/classes is on the CLASSPATH
        InputStream is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
        Properties props = new Properties();
        props.load(is);

        // load database connection details
        host = props.getProperty("db.host").trim();
        String port = String.valueOf(props.getProperty("db.port")).trim();
        String dbName = props.getProperty("db.name").trim();
        dbUser = props.getProperty("db.user").trim();
        dbPassword = props.getProperty("db.password").trim();

        dbURL = "jdbc:mysql://" + host + ":" + port + "/" + dbName;
      } catch (Exception ex) {
        // unable to load properties file
        String message = "Unable to load '" + PROPS_FILENAME + "'.";

        System.out.println(message);
        Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, message, ex);
        throw new RuntimeException(message, ex);
      }

    }

    try {
      Class.forName("com.mysql.jdbc.Driver").newInstance();
    } catch (Exception ex) {
      // unable to load properties file
      String message = "Unable to find JDBC driver for MySQL.";

      System.out.println(message);
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, message, ex);
      throw new RuntimeException(message, ex);
    }
  }


  /**
   * Get a database connection object.
   *
   * @return Connection object to the database.
   * @throws SQLException
   */
  public static Connection getConnection() throws SQLException {
    Connection conn = null;
    try {

      Class.forName("com.mysql.jdbc.Driver");
      System.out.println("CONN:" + dbURL);
      conn = DriverManager
              .getConnection(dbURL, dbUser, dbPassword);

    } catch (ClassNotFoundException ex) {
      String msg = "Unable to load MySQL JDBC Driver.";

      // Note that I'm using Logger as per default.
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, msg, ex);

      throw new RuntimeException(msg, ex);
    }
    return conn;
  }
  
  
  
  /**
   * close the given connection, statement and resultset
   *
   * @param conn the connection object to be closed
   * @param stmt the statement object to be closed
   * @param rs the resultset object to be closed
   */
  public static void close(Connection conn, Statement stmt, ResultSet rs) {
    try {
      if (rs != null) {
        rs.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
              "Unable to close ResultSet", ex);
    }
    
    close(conn,stmt);
  }
  
  
  /**
   * close the given connection, statement
   *
   * @param conn the connection object to be closed
   * @param stmt the statement object to be closed
   */
  public static void close(Connection conn, Statement stmt) {
    try {
      if (stmt != null) {
        stmt.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
              "Unable to close Statement", ex);
    }
    try {
      if (conn != null) {
        conn.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
              "Unable to close Connection", ex);
    }
  }
}
