-- Step 1: Create the Users Table --
-- CREATE DATABASE 

CREATE TABLE Users 
(
    UserID INT IDENTITY(1,1) PRIMARY KEY, -- Auto-incremented primary key
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    DateOfBirth DATE,
    CreatedAt DATETIME DEFAULT GETDATE() -- Automatically set the creation timestamp
);


-- Step 2: Enable CDC on this table --
exec msdb.dbo.rds_cdc_enable_db 'database_name';


EXEC sys.sp_cdc_enable_table  
    @source_schema = 'dbo',  
    @source_name = 'Users',  
    @role_name = NULL;

SELECT * FROM sys.sp_cdc_help_change_data_capture;


-- Step 3: Insert 10 Records into the Users Table --
INSERT INTO Users (FirstName, LastName, Email, DateOfBirth)
VALUES 
('John', 'Doe', 'john.doe@example.com', '1990-01-01'),
('Jane', 'Smith', 'jane.smith@example.com', '1992-02-14'),
('Alice', 'Johnson', 'alice.johnson@example.com', '1988-03-10'),
('Bob', 'Williams', 'bob.williams@example.com', '1995-04-25'),
('Charlie', 'Brown', 'charlie.brown@example.com', '1985-05-05'),
('David', 'Clark', 'david.clark@example.com', '1993-06-12'),
('Emma', 'Davis', 'emma.davis@example.com', '1991-07-18'),
('Frank', 'Garcia', 'frank.garcia@example.com', '1989-08-22'),
('Grace', 'Martinez', 'grace.martinez@example.com', '1994-09-30'),
('Hannah', 'Lopez', 'hannah.lopez@example.com', '1996-10-15');
