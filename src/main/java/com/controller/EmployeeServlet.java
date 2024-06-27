package com.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class EmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDao employeeDao;

    @Override
    public void init() throws ServletException {
        super.init();
        employeeDao = new EmployeeDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if(action!=null) {
        	if ("delete".equalsIgnoreCase(action)) {
                int employeeId = Integer.parseInt(request.getParameter("employeeId"));
                employeeDao.deleteEmployee(employeeId);
                response.sendRedirect(request.getContextPath() + "/EmployeeServlet");
            }
            else if("getEmployee".equals(action)) {
            	int employeeId = Integer.parseInt(request.getParameter("id"));
                Employee employee = employeeDao.getEmployeeById(employeeId);

                // Convert the employee object to JSON
                String employeeJson = convertEmployeeToJson(employee);

                // Set the response type to JSON
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                // Write the JSON data to the response
                response.getWriter().write(employeeJson);
            }
            else {
                List<Employee> employees = employeeDao.getAllEmployees();
                System.out.println("getting " +employees.size() );
                request.setAttribute("employees", employees);
                request.getRequestDispatcher("listEmployees.jsp").forward(request, response);
            }
        }else {
        	List<Employee> employees = employeeDao.getAllEmployees();
            System.out.println("getting " +employees.size() );
            request.setAttribute("employees", employees);
            request.getRequestDispatcher("listEmployees.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            Employee employee = createEmployeeFromRequest(request);
            employeeDao.addEmployee(employee);
        } else if ("update".equalsIgnoreCase(action)) {
            Employee employee = createEmployeeFromRequest(request);
            employeeDao.updateEmployee(employee);
        }

        response.sendRedirect(request.getContextPath() + "/EmployeeServlet");
    }

    private Employee createEmployeeFromRequest(HttpServletRequest request) {
        Employee employee = new Employee();
        try {
        	employee.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
        }catch(Exception e) {
        	
        }
        employee.setFirstName(request.getParameter("firstName"));
        employee.setLastName(request.getParameter("lastName"));
        employee.setDob(request.getParameter("dob"));
        employee.setPhoneNo(request.getParameter("phoneNo"));
        employee.setEmail(request.getParameter("email"));
        employee.setUsername(request.getParameter("username"));
        employee.setPassword(request.getParameter("password"));
        employee.setJobTitle(request.getParameter("jobTitle"));
        employee.setDepartment(request.getParameter("department"));
        return employee;
    }

    @Override
    public void destroy() {
        // Close resources, if any
        super.destroy();
    }
    private String convertEmployeeToJson(Employee employee) {
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("{");
        jsonBuilder.append("\"employeeId\":").append(employee.getEmployeeId()).append(",");
        jsonBuilder.append("\"firstName\":\"").append(employee.getFirstName()).append("\",");
        jsonBuilder.append("\"lastName\":\"").append(employee.getLastName()).append("\",");
        jsonBuilder.append("\"dob\":\"").append(employee.getDob()).append("\",");
        jsonBuilder.append("\"phoneNo\":\"").append(employee.getPhoneNo()).append("\",");
        jsonBuilder.append("\"email\":\"").append(employee.getEmail()).append("\",");
        jsonBuilder.append("\"username\":\"").append(employee.getUsername()).append("\",");
        jsonBuilder.append("\"password\":\"").append(employee.getPassword()).append("\",");
        jsonBuilder.append("\"jobTitle\":\"").append(employee.getJobTitle()).append("\",");
        jsonBuilder.append("\"department\":\"").append(employee.getDepartment()).append("\"");
        jsonBuilder.append("}");

        return jsonBuilder.toString();
    }
}
