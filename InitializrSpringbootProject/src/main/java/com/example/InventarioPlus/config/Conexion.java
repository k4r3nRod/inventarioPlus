package com.example.InventarioPlus.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@Configuration
public class Conexion {
    
    // Propiedades de conexión desde application.properties
    @Value("${spring.datasource.url}")
    private String url;
    
    @Value("${spring.datasource.username}")
    private String username;
    
    @Value("${spring.datasource.password}")
    private String password;
    
    @Value("${spring.datasource.driver-class-name}")
    private String driverClassName;
    
    /**
     * Configuración del DataSource principal
     * @return DataSource configurado para MySQL
     */
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(driverClassName);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        return dataSource;
    }
    
    /**
     * Bean para JdbcTemplate que usa el DataSource configurado
     * @param dataSource el DataSource configurado
     * @return JdbcTemplate para consultas SQL directas
     */
    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }
    
    /**
     * Método para obtener una conexión directa a la base de datos
     * @return Connection a la base de datos MySQL
     * @throws SQLException si hay error en la conexión
     */
    public Connection obtenerConexion() throws SQLException {
        return dataSource().getConnection();
    }
    
    /**
     * Método para probar la conexión a la base de datos
     * @return true si la conexión es exitosa, false en caso contrario
     */
    public boolean probarConexion() {
        try (Connection connection = obtenerConexion()) {
            return connection != null && !connection.isClosed();
        } catch (SQLException e) {
            System.err.println("Error al probar la conexión: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Método para obtener información de la conexión actual
     * @return String con información de la base de datos
     */
    public String obtenerInfoConexion() {
        try (Connection connection = obtenerConexion()) {
            if (connection != null) {
                return String.format(
                    "Base de datos: %s%nURL: %s%nUsuario: %s%nEsquema: %s%nDriver: %s",
                    connection.getMetaData().getDatabaseProductName(),
                    connection.getMetaData().getURL(),
                    connection.getMetaData().getUserName(),
                    connection.getCatalog(),
                    connection.getMetaData().getDriverName()
                );
            }
            return "No se pudo obtener información de la conexión";
        } catch (SQLException e) {
            return "Error al obtener información: " + e.getMessage();
        }
    }
    
    // Getters para acceder a las propiedades
    public String getUrl() {
        return url;
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getDriverClassName() {
        return driverClassName;
    }
    
    // Nota: No incluimos getter para password por seguridad
}