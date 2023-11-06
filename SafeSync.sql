CREATE DATABASE IF NOT EXISTS safesync;
USE safesync;

CREATE TABLE IF NOT EXISTS empresas (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeFantasia VARCHAR(100) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    cep CHAR(9) NOT NULL,
    numero VARCHAR(5) NOT NULL,
    complemento VARCHAR(10),
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    senhaEmpresa VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS funcionarios (
    idFuncionario INT AUTO_INCREMENT,
    nomeFuncionario VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    cpf CHAR(11) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresas(idEmpresa),
    PRIMARY KEY (idFuncionario, fkEmpresa) 
);

CREATE TABLE IF NOT EXISTS hardwares(
	idHardware INT AUTO_INCREMENT,
	sistemaOperacional VARCHAR(50),
    totalCpu DOUBLE NOT NULL,
	totalDisco DOUBLE NOT NULL,
	totalRam DOUBLE NOT NULL,
    fkEmpresa INT NOT NULL,
	fkFuncionario INT NOT NULL,
	FOREIGN KEY (fkFuncionario) REFERENCES funcionarios(idFuncionario),
    FOREIGN KEY (fkEmpresa) REFERENCES empresas(idEmpresa),
    PRIMARY KEY (idHardware, fkEmpresa, fkFuncionario)
);

CREATE TABLE IF NOT EXISTS volateis(
	idVolateis INT AUTO_INCREMENT,
	consumoCpu DOUBLE NOT NULL,
	consumoDisco DOUBLE NOT NULL,
	consumoRam DOUBLE NOT NULL,
	totalJanelas INT NOT NULL,
	dataHora DATETIME,
	fkHardware INT,
	FOREIGN KEY (fkHardware) REFERENCES hardwares(idHardware),
	PRIMARY KEY (idVolateis, fkHardware)
);

CREATE TABLE IF NOT EXISTS limitador(
	idLimitador INT AUTO_INCREMENT,
	tipoComponente VARCHAR(45),
    maxCpu INT NOT NULL,
    maxDisco INT NOT NULL,
	maxRam INT NOT NULL,
	fkEmpresa INT NOT NULL,
	FOREIGN KEY (fkEmpresa) REFERENCES empresas(idEmpresa),
    PRIMARY KEY (idLimitador, fkEmpresa)
);

CREATE TABLE IF NOT EXISTS arquivos (
	idArquivos INT AUTO_INCREMENT,
	nomeArquivo LONGTEXT NOT NULL,
	tipoArquivo VARCHAR(100) NOT NULL,
	tamanhoArquivo INT NOT NULL,
	dadosArquivo LONGBLOB NOT NULL,
	dataUpload TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	fkFuncionario INT NOT NULL,
	FOREIGN KEY (fkFuncionario) REFERENCES funcionarios(idFuncionario),
	PRIMARY KEY (idArquivos, fkFuncionario)
);