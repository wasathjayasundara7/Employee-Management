CREATE TABLE Employee (
    employeeId INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    dob DATE,
    phoneNo VARCHAR(15),
    email VARCHAR(255),
    username VARCHAR(255),
    password VARCHAR(255) DEFAULT VALUE "1231",
    jobTitle VARCHAR(255), 
    department VARCHAR(255)
);
ALTER TABLE Employee MODIFY COLUMN dob Varchar(50);