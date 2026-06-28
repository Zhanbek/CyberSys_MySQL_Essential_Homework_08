DELIMITER $$

CREATE TRIGGER trg_DeleteEmployee
BEFORE DELETE
ON Employees
FOR EACH ROW
BEGIN
    DELETE FROM Employees_Positions_Salaries
    WHERE Employee_Id = OLD.Id;

    DELETE FROM Employee_Details
    WHERE Employee_Id = OLD.Id;
END $$

DELIMITER ;