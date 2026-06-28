DELIMITER $$

CREATE PROCEDURE AddEmployee(
    IN p_name VARCHAR(100),
    IN p_phone VARCHAR(20),
    IN p_birthdate DATE,
    IN p_address VARCHAR(200),
    IN p_marital_status VARCHAR(30),
    IN p_position_id INT,
    IN p_salary DECIMAL(10,2)
)
BEGIN
    DECLARE emp_count INT;
    DECLARE emp_id INT;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO emp_count
    FROM Employees
    WHERE Name = p_name;

    IF emp_count > 0 THEN
        ROLLBACK;
    ELSE
        INSERT INTO Employees(Name, Phone)
        VALUES(p_name, p_phone);

        SET emp_id = LAST_INSERT_ID();

        INSERT INTO Employee_Details
        (
            Employee_Id,
            BirthDate,
            Address,
            Marital_Status
        )
        VALUES
        (
            emp_id,
            p_birthdate,
            p_address,
            p_marital_status
        );

        INSERT INTO Employees_Positions_Salaries
        (
            Employee_Id,
            Position_Id,
            Salary,
            begin_date,
            end_date
        )
        VALUES
        (
            emp_id,
            p_position_id,
            p_salary,
            CURDATE(),
            NULL
        );
        COMMIT;
    END IF;
END $$

DELIMITER ;