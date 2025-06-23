
-- Таблица ролей
CREATE TABLE Roles (
    Role_ID SERIAL PRIMARY KEY,
    RoleName VARCHAR(100) NOT NULL
);

-- Таблица пользователей
CREATE TABLE Users (
    User_ID SERIAL PRIMARY KEY,
    Username VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Role_ID INTEGER REFERENCES Roles(Role_ID),
    LastName VARCHAR(100),
    FirstName VARCHAR(100),
    MiddleName VARCHAR(100)
);

-- Таблица публичных пользователей
CREATE TABLE PublicUsers (
    PublicUser_ID SERIAL PRIMARY KEY,
    Username VARCHAR(100) NOT NULL,
    Email VARCHAR(255)
);

-- Таблица публичных заявок
CREATE TABLE PublicApplications (
    Application_ID SERIAL PRIMARY KEY,
    PublicUser_ID INTEGER REFERENCES PublicUsers(PublicUser_ID),
    Title VARCHAR(255),
    Description TEXT,
    Status VARCHAR(100),
    SubmissionDate TIMESTAMP
);

-- Назначения заявок
CREATE TABLE ApplicationAssignments (
    Assignment_ID SERIAL PRIMARY KEY,
    Application_ID INTEGER REFERENCES PublicApplications(Application_ID),
    User_ID INTEGER REFERENCES Users(User_ID),
    AssignedAt TIMESTAMP
);

-- Сообщения в поддержку
CREATE TABLE SupportMessages (
    Message_ID SERIAL PRIMARY KEY,
    Username VARCHAR(100),
    MessageText TEXT,
    CreatedAt TIMESTAMP
);

-- Запросы на сброс пароля
CREATE TABLE PasswordResetRequests (
    Request_ID SERIAL PRIMARY KEY,
    Username VARCHAR(100),
    Email VARCHAR(255),
    RequestedAt TIMESTAMP,
    Status VARCHAR(50)
);

-- Логи действий
CREATE TABLE Logs (
    Log_ID SERIAL PRIMARY KEY,
    Username VARCHAR(100),
    Action TEXT,
    ActionTime TIMESTAMP
);

-- Предустановленные роли
INSERT INTO Roles (Role_ID, RoleName) VALUES
    (1, 'manager'),
    (2, 'admin'),
    (3, 'developer'),
    (4, 'tester');

-- Вставка пользователя admin (пароль: 123, хэширован scrypt)
INSERT INTO Users (User_ID, Username, Password, Email, Role_ID, LastName, FirstName, MiddleName)
VALUES (
    1,
    'admin',
    'scrypt:32768:8:1$M/GYz3T8hgPZzqxMaSl7LA==$Zgtu+/S8wFZhxV02X4guxbAsfAxDbNtbKXWrMIRc0uQ=',
    'admin@example.com',
    2,
    'Добров',
    'Вячеслав',
    'Эдуардович'
);
