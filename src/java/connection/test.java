package connection;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author huamei
 */
public class test {
    private test(){
    
    }
    public static void main(String [] args) throws SQLException{
        getRemoteConnection();
    
    }
    private static Connection getRemoteConnection() throws SQLException {
    //if (System.getenv("RDS_HOSTNAME") != null) {
      try {
      Class.forName("com.mysql.jdbc.Driver");
      String dbName = "LouisVuitton";
      String userName = "admin";
      String password = "AceConsulting";
      String hostname = "louisvuitton.cgtjmvdgssir.us-west-2.rds.amazonaws.com";
      String port = "3306";
      String jdbcUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName + "?user=" + userName + "&password=" + password;
      
      System.out.println(jdbcUrl);
      //logger.trace("Getting remote connection with connection string from environment variables.");
      
      Connection con = (Connection) DriverManager.getConnection(jdbcUrl);
      System.out.printf("con"+con);
      
      
      System.out.println("conn:"+con);
          //logger.info("Remote connection successful.");
          try (Statement readStatement = con.createStatement()) {
              System.out.println(con);
              ResultSet resultSet = readStatement.executeQuery("SELECT * FROM LouisVuitton.event;");
              resultSet.first();
              String results = resultSet.getString("eventID");
              resultSet.next();
              results += ", " + resultSet.getString("eventID");
              System.out.print(results);
              resultSet.close();
          }
      
      return con;
    }
    catch (ClassNotFoundException e) {System.out.printf("Wrong1");}
    catch (SQLException e) { e.printStackTrace();
    }
    //}
    
    return null;
  
}
}

