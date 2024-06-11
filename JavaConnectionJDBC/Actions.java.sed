/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 *                     
 */

import lrapi.lr;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Actions
{
	public Connection connection = null;
	
	public int init() throws Throwable {
		
		
		// Configuraci�n de la conexi�n
        String jdbcURL = "jdbc:postgresql://172.20.196.3:5432/gestion_clientes";
        String username = "davidp";
        String password = "davidCT2015.";
        
        try{
        	// Registrar el controlador JDBC
        	Class.forName("org.postgresql.Driver");
            
        	lr.start_transaction("TRX01Conexi�n");
        	// Conectar a la base de datos
        	connection = DriverManager.getConnection(jdbcURL, username, password);
        	lr.end_transaction("TRX01Conexi�n", lr.AUTO);
            
        	// Confirmar la conexi�n
        	System.out.println("Conexi�n exitosa a la base de datos");
        	
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontr� el controlador JDBC");
            e.printStackTrace();
        }
                
		return 0;
	}//
	
	public int action() throws Throwable{
		
				
        try {

            // Crear una declaraci�n
            Statement statement = connection.createStatement();

            // Ejecutar una consulta
            String sql = "SELECT telefono From clientes where nombre='Juan'";
            
            lr.start_transaction("TRX02Consulta");
            ResultSet resultSet = statement.executeQuery(sql);
            lr.end_transaction("TRX02Consulta", lr.AUTO);

            // Procesar el resultado
            while (resultSet.next()) {
                String version = resultSet.getString(1);
                System.out.println("Resultado de la consulta: " + version);
            }

            // Cerrar el ResultSet y el Statement
            resultSet.close();
            statement.close();

        } catch (SQLException e) {
            System.out.println("Error de conexi�n a la base de datos");
            e.printStackTrace();
        } 
		
		return 0;
	}// end of method: public int action() throws Throwable


	public int end() throws Throwable {
		
        // Cerrar la conexi�n
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Conexi�n cerrada");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
		
		return 0;
	}//end of end
	

}
