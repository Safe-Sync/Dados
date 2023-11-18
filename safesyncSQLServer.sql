-- drop database safesync;

CREATE DATABASE safesync;

USE safesync;


 CREATE TABLE empresas(
        idEmpresa INT IDENTITY(1,1) PRIMARY KEY,
        nomeFantasia VARCHAR(100) NOT NULL,
        razaoSocial VARCHAR(100) NOT NULL,
        cnpj CHAR(18) NOT NULL UNIQUE,
        cep CHAR(9) NOT NULL,
        numero VARCHAR(5) NOT NULL,
        complemento VARCHAR(100),
        email VARCHAR(100) NOT NULL,
        telefone VARCHAR(20) NOT NULL,
        senhaEmpresa VARCHAR(20) NOT NULL
    );

    CREATE TABLE funcionarios (
        idFuncionario INT IDENTITY(1,1) PRIMARY KEY,
        nomeFuncionario VARCHAR(100) NOT NULL,
        cargo VARCHAR(50) NOT NULL,
        cpf CHAR(14) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        telefone VARCHAR(15) NOT NULL,
        senha VARCHAR(20) NOT NULL,
        fkEmpresa INT,
        FOREIGN KEY (fkEmpresa) REFERENCES empresas(idEmpresa)
    );

	select * from hardwares;

    CREATE TABLE hardwares(
        idHardware INT IDENTITY(1,1),
        sistemaOperacional VARCHAR(50),
        totalCpu FLOAT NOT NULL,
        totalDisco FLOAT NOT NULL,
        totalRam FLOAT NOT NULL,
        fkEmpresa INT,
        fkFuncionario INT,
        FOREIGN KEY (fkEmpresa) REFERENCES empresas(idEmpresa),
		FOREIGN KEY (fkFuncionario) REFERENCES funcionarios(idFuncionario),
		PRIMARY KEY (idHardware, fkEmpresa, fkFuncionario)
    );




    CREATE TABLE volateis(
        idVolatile INT IDENTITY(1,1) PRIMARY KEY,
        consumoCpu FLOAT NOT NULL,
        consumoDisco FLOAT NOT NULL,
        consumoRam FLOAT NOT NULL,
        totalJanelas INT NOT NULL,
        dataHora DATETIME,
        fkHardware INT,
		fkEmpresa INT,
		fkFuncionario INT,
		FOREIGN KEY (fkEmpresa) REFERENCES empresas(idEmpresa),
		FOREIGN KEY (fkFuncionario) REFERENCES funcionarios(idFuncionario),
        FOREIGN KEY (fkHardware, fkEmpresa,fkFuncionario) REFERENCES hardwares(idHardware, fkEmpresa, fkFuncionario)
    );



    CREATE TABLE limitador(
        idLimitador INT IDENTITY(1,1) PRIMARY KEY,
        tipoComponente VARCHAR(45),
        maxCpu INT NOT NULL,
        maxDisco INT NOT NULL,
        maxRam INT NOT NULL,
        fkEmpresa INT,
        FOREIGN KEY (fkEmpresa) REFERENCES empresas(idEmpresa)
    );

	

    CREATE TABLE tarefa (
        idTarefa INT IDENTITY(1,1),
        nome_tarefa NVARCHAR(MAX) NOT NULL,
        data_upload DATE NOT NULL,
        progresso VARCHAR(45) NOT NULL,
        CONSTRAINT check_progresso CHECK (progresso IN ('Não iniciado', 'Em Andamento', 'Concluído', 'A Fazer')),
        fkFuncionario INT,
        FOREIGN KEY (fkFuncionario) REFERENCES funcionarios(idFuncionario),
		PRIMARY KEY (idTarefa,fkFuncionario)
    );

	INSERT INTO empresas (nomeFantasia, razaoSocial, cnpj, cep, numero, complemento, email, telefone, senhaEmpresa) 
VALUES ('Empresa A', 'Razao Social A', '12345678901234', '12345678', '123', 'Sala 1', 'empresaA@email.com', '123456789', 'senha123'),
       ('Empresa B', 'Razao Social B', '56789012345678', '87654321', '456', 'Sala 2', 'empresaB@email.com', '987654321', 'senha456');

-- Inserts para a tabela funcionarios
INSERT INTO funcionarios (nomeFuncionario, cargo, cpf, email, telefone, senha, fkEmpresa) 
VALUES ('Funcionario 1', 'Cargo 1', '12345678901', 'funcionario1@email.com', '111222333', 'senhaFunc1', 1),
       ('Funcionario 2', 'Cargo 2', '98765432109', 'funcionario2@email.com', '444555666', 'senhaFunc2', 2);

-- Inserts para a tabela hardwares
INSERT INTO hardwares (sistemaOperacional, totalCpu, totalDisco, totalRam, fkEmpresa, fkFuncionario) 
VALUES ('Windows', 4.0, 1024.0, 8.0, 1, 1),
       ('Linux', 2.0, 512.0, 4.0, 2, 2);

-- Inserts para a tabela limitador
INSERT INTO limitador (tipoComponente, maxCpu, maxDisco, maxRam, fkEmpresa) 
VALUES ('CPU', 80, 1024, 16, 1),
       ('Disco', 512, 2048, 8, 2);

	   select * from funcionarios;