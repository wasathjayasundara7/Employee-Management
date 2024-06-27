<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.controller.Employee" %>
<% List<Employee> employees = (List<Employee>) request.getAttribute("employees"); %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Employee Management</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
          crossorigin="anonymous">
    <!-- Custom Styles -->
    <style>
        body {
            padding: 20px;
            background-color: #f8f9fa;
        }

        .container {
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            text-align: left;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
        }

        th {
            background-color: red;
            color: black;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .btn-group {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 class="mt-4 mb-4">Employee Management</h1>

    <!-- Button group for CRUD operations -->
    <div class="btn-group">
        <button type="button" class="btn btn-success" data-toggle="modal" onclick="openAddEmployeeModal()" data-target="#addEmployeeModal">Add Employee</button>
    </div>

    <!-- Display employees -->
    <table class="table table-striped" id="employeesTable">
        <thead>
        <tr>
            <th>Employee ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Date of Birth</th>
            <th>Phone Number</th>
            <th>Email</th>
            <th>Username</th>
            <th>Password</th>
            <th>Job Title</th>
            <th>Department</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (employees != null) {
            for (Employee employee : employees) { %>
                <tr>
                    <td><%= employee.getEmployeeId() %></td>
                    <td><%= employee.getFirstName() %></td>
                    <td><%= employee.getLastName() %></td>
                    <td><%= employee.getDob() %></td>
                    <td><%= employee.getPhoneNo() %></td>
                    <td><%= employee.getEmail() %></td>
                    <td><%= employee.getUsername() %></td>
                    <td><%= employee.getPassword() %></td>
                    <td><%= employee.getJobTitle() %></td>
                    <td><%= employee.getDepartment() %></td>
                    <td>
                        <!-- Add buttons for actions (update, delete) if needed -->
                       <button type="button" class="btn btn-primary" onclick="openUpdateModal(<%= employee.getEmployeeId() %>)">Edit</button>

                        <a href="<%= request.getContextPath() %>/EmployeeServlet?action=delete&employeeId=<%= employee.getEmployeeId() %>" type="button" class="btn btn-danger">Delete</a>
                    </td>
                </tr>
            <% }
        } %>
        </tbody>
    </table>
</div>

<!-- Add Employee Modal -->
<div class="modal fade" id="addEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addEmployeeModalLabel">Add Employee</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Your form for adding employees -->
                <form id="addEmployeeForm" action="<%= request.getContextPath() %>/EmployeeServlet?action=add" method="POST">
                    <div class="form-group">
                        <label for="firstName">First Name:</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name:</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                    </div>
                    <div class="form-group">
                        <label for="dob">Date of Birth:</label>
                        <input type="date" class="form-control" id="dob" name="dob" required>
                    </div>
                    <div class="form-group">
                        <label for="phoneNo">Phone Number:</label>
                        <input type="tel" class="form-control" id="phoneNo" name="phoneNo" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="jobTitle">Job Title:</label>
                        <input type="text" class="form-control" id="jobTitle" name="jobTitle" required>
                    </div>
                    <div class="form-group">
                        <label for="department">Department:</label>
                        <input type="text" class="form-control" id="department" name="department" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Add Employee</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Update Employee Modal -->
<div class="modal fade" id="updateEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="updateEmployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateEmployeeModalLabel">Update Employee</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Your form for updating employees -->
                <form id="updateEmployeeForm">
                    <input type="hidden" id="updateEmployeeId" name="employeeId">
                    <div class="form-group">
                        <label for="updateFirstName">First Name:</label>
                        <input type="text" class="form-control" id="updateFirstName" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="updateLastName">Last Name:</label>
                        <input type="text" class="form-control" id="updateLastName" name="lastName" required>
                    </div>
                    <div class="form-group">
                        <label for="updateDob">Date of Birth:</label>
                        <input type="date" class="form-control" id="updateDob" name="dob" required>
                    </div>
                    <div class="form-group">
                        <label for="updatePhoneNo">Phone Number:</label>
                        <input type="tel" class="form-control" id="updatePhoneNo" name="phoneNo" required>
                    </div>
                    <div class="form-group">
                        <label for="updateEmail">Email:</label>
                        <input type="email" class="form-control" id="updateEmail" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="updateUsername">Username:</label>
                        <input type="text" class="form-control" id="updateUsername" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="updatePassword">Password:</label>
                        <input type="password" class="form-control" id="updatePassword" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="updateJobTitle">Job Title:</label>
                        <input type="text" class="form-control" id="updateJobTitle" name="jobTitle" required>
                    </div>
                    <div class="form-group">
                        <label for="updateDepartment">Department:</label>
                        <input type="text" class="form-control" id="updateDepartment" name="department" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Update Employee</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-XrEUWmON8ZlVaCz9dILC7NjuEfnN6gngVrj4yzgF3HcqTQp0FqRIpswqLQlmh/jW"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyO2BUbuKRcJNoN9vI82+cO+hXO1NQPD8X"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>

<script>
    // Implement JavaScript functions for CRUD operations, including opening modals and handling form submissions
    // For example, use AJAX to interact with the server and update the table dynamically

    // Function to open the update modal and pre-fill the form
    function openUpdateModal(employeeId) {
        // Use AJAX to fetch the employee details based on employeeId and pre-fill the form
        $.ajax({
            type: 'GET',
            url: '<%= request.getContextPath() %>/EmployeeServlet?action=getEmployee&id=' + employeeId,
            success: function (employee) {
                // Populate the form fields with employee details
                $('#updateEmployeeId').val(employee.employeeId);
                $('#updateFirstName').val(employee.firstName);
                $('#updateLastName').val(employee.lastName);
                $('#updateDob').val(employee.dob);
                $('#updatePhoneNo').val(employee.phoneNo);
                $('#updateEmail').val(employee.email);
                $('#updateUsername').val(employee.username);
                $('#updatePassword').val(employee.password);
                $('#updateJobTitle').val(employee.jobTitle);
                $('#updateDepartment').val(employee.department);

                // Open the update modal
                $('#updateEmployeeModal').modal('show');
            },
            error: function (error) {
                console.error('Error fetching employee details:', error);
            }
        });
    }

    // Function to handle form submission for adding employees
    $('#addEmployeeForm').submit(function (event) {
        event.preventDefault();

        // Use AJAX to submit the form data to the server
        $.ajax({
            type: 'POST',
            url: '<%= request.getContextPath() %>/EmployeeServlet?action=add',
            data: $('#addEmployeeForm').serialize(),
            success: function (response) {
                // Reload the table after successful add
                location.reload();

                // Close the add modal
                $('#addEmployeeModal').modal('hide');
            },
            error: function (error) {
                console.error('Error adding employee:', error);
            }
        });
    });

    // Function to handle form submission for updating employees
    $('#updateEmployeeForm').submit(function (event) {
        event.preventDefault();

        // Use AJAX to submit the form data to the server
        $.ajax({
            type: 'POST',
            url: '<%= request.getContextPath() %>/EmployeeServlet?action=update',
            data: $('#updateEmployeeForm').serialize(),
            success: function (response) {
                // Reload the table after successful update
                location.reload();

                // Close the update modal
                $('#updateEmployeeModal').modal('hide');
            },
            error: function (error) {
                console.error('Error updating employee:', error);
            }
        });
    });

    // Function to confirm and delete an employee
    function confirmDelete(employeeId) {
        var result = confirm('Are you sure you want to delete this employee?');
        if (result) {
            // Use AJAX to delete the employee based on employeeId
            $.ajax({
                type: 'GET',
                url: '<%= request.getContextPath() %>/EmployeeServlet?action=deleteEmployee&id=' + employeeId,
                success: function (response) {
                    // Reload the table after successful delete
                    location.reload();
                },
                error: function (error) {
                    console.error('Error deleting employee:', error);
                }
            });
        }
    }

    // Function to open the add employee modal
    function openAddEmployeeModal() {
        // Clear the form fields when opening the modal
        $('#addEmployeeForm')[0].reset();

        // Open the add modal
        $('#addEmployeeModal').modal('show');
    }

    // Load employees table on page load
    $(document).ready(function () {
        // You can perform additional actions on page load if needed
    });
</script>

</body>
</html>
