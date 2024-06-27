package com.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDao {

    private String jdbcUrl = "jdbc:mysql://localhost:3306/employee_db";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String INSERT_EMPLOYEE_SQL = "INSERT INTO Employee (firstName, lastName, dob, phoneNo, email, username, password, jobTitle, department) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_EMPLOYEE_BY_ID_SQL = "SELECT * FROM Employee WHERE employeeId=?";
    private static final String SELECT_ALL_EMPLOYEES_SQL = "SELECT * FROM Employee";
    private static final String UPDATE_EMPLOYEE_SQL = "UPDATE Employee SET firstName=?, lastName=?, dob=?, phoneNo=?, email=?, username=?, password=?, jobTitle=?, department=? WHERE employeeId=?";
    private static final String DELETE_EMPLOYEE_SQL = "DELETE FROM Employee WHERE employeeId=?";

    public EmployeeDao() {
        // You can initialize your database connection here
    }

    public void addEmployee(Employee employee) {
        try (Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_EMPLOYEE_SQL)) {

            preparedStatement.setString(1, employee.getFirstName());
            preparedStatement.setString(2, employee.getLastName());
            preparedStatement.setString(3, employee.getDob());
            preparedStatement.setString(4, employee.getPhoneNo());
            preparedStatement.setString(5, employee.getEmail());
            preparedStatement.setString(6, employee.getUsername());
            preparedStatement.setString(7, employee.getPassword());
            preparedStatement.setString(8, employee.getJobTitle());
            preparedStatement.setString(9, employee.getDepartment());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Employee getEmployeeById(int employeeId) {
        Employee employee = null;
        try (Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMPLOYEE_BY_ID_SQL)) {

            preparedStatement.setInt(1, employeeId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                employee = extractEmployeeFromResultSet(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employee;
    }

    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_EMPLOYEES_SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Employee employee = extractEmployeeFromResultSet(resultSet);
                employees.add(employee);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("sending " +employees.size());
        return employees;
    }

    public void updateEmployee(Employee employee) {
        try (Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_EMPLOYEE_SQL)) {

            preparedStatement.setString(1, employee.getFirstName());
            preparedStatement.setString(2, employee.getLastName());
            preparedStatement.setString(3, employee.getDob());
            preparedStatement.setString(4, employee.getPhoneNo());
            preparedStatement.setString(5, employee.getEmail());
            preparedStatement.setString(6, employee.getUsername());
            preparedStatement.setString(7, employee.getPassword());
            preparedStatement.setString(8, employee.getJobTitle());
            preparedStatement.setString(9, employee.getDepartment());
            preparedStatement.setInt(10, employee.getEmployeeId());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteEmployee(int employeeId) {
        try (Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_EMPLOYEE_SQL)) {

            preparedStatement.setInt(1, employeeId);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Employee extractEmployeeFromResultSet(ResultSet resultSet) throws SQLException {
        Employee employee = new Employee();
        employee.setEmployeeId(resultSet.getInt("employeeId"));
        employee.setFirstName(resultSet.getString("firstName"));
        employee.setLastName(resultSet.getString("lastName"));
        employee.setDob(resultSet.getString("dob"));
        employee.setPhoneNo(resultSet.getString("phoneNo"));
        employee.setEmail(resultSet.getString("email"));
        employee.setUsername(resultSet.getString("username"));
        employee.setPassword(resultSet.getString("password"));
        employee.setJobTitle(resultSet.getString("jobTitle"));
        employee.setDepartment(resultSet.getString("department"));
        return employee;
    }
}
