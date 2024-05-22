-- Criando Usuário
--CREATE USER jvSolucoess IDENTIFIED BY "admin";

-- Alterar Usuário
--ALTER USER jvSolucoess IDENTIFIED BY "root";

-- Garantindo Privilégios ao usuário.
--GRANT ALL PRIVILEGES TO jvSolucoess;

-- Alterar Sessão
ALTER SESSION SET CURRENT_SCHEMA=jvSolucoess; // Alterando a sessão

CREATE TABLE empresa (
    id        INTEGER NOT NULL,
    nome      VARCHAR2(50 CHAR) NOT NULL,
    descricao VARCHAR2(150 CHAR),
    PRIMARY KEY (id)
);

CREATE TABLE pais (
    id   INTEGER NOT NULL,
    nome VARCHAR2(30 CHAR) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE estado (
    id      INTEGER NOT NULL,
    nome    VARCHAR2(30 CHAR) NOT NULL,
    pais_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pais_id) REFERENCES pais (id)
);

CREATE TABLE cidade (
    id        INTEGER NOT NULL,
    nome      VARCHAR2(30 CHAR) NOT NULL,
    estado_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (estado_id) REFERENCES estado (id)
);

CREATE TABLE bairro (
    id        INTEGER NOT NULL,
    nome      VARCHAR2(50 CHAR) NOT NULL,
    cidade_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (cidade_id) REFERENCES cidade (id)
);

CREATE TABLE endereco (
    id          INTEGER NOT NULL,
    rua         VARCHAR2(30 CHAR) NOT NULL,
    numero      SMALLINT NOT NULL,
    complemento VARCHAR2(20 CHAR),
    bairro_id   INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (bairro_id) REFERENCES bairro (id)
);

CREATE TABLE local_descarte (
    id                    INTEGER NOT NULL,
    nome                  VARCHAR2(50 CHAR) NOT NULL,
    horario_funcionamento VARCHAR2(50 CHAR) NOT NULL,
    endereco_id           INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (endereco_id) REFERENCES endereco (id)
);

CREATE TABLE pessoa (
    id      INTEGER NOT NULL,
    nome    VARCHAR2(50 CHAR) NOT NULL,
    contato CHAR(11 CHAR) NOT NULL,
    email   VARCHAR2(50 CHAR) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE usuario (
    pessoa_id INTEGER NOT NULL,
    PRIMARY KEY (pessoa_id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoa (id)
);

CREATE TABLE consultor (
    pessoa_id  INTEGER NOT NULL,
    senha      VARCHAR2(20 CHAR) NOT NULL,
    empresa_id INTEGER NOT NULL,
    PRIMARY KEY (pessoa_id),
    FOREIGN KEY (empresa_id) REFERENCES empresa (id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoa (id)
);

CREATE TABLE contato_consultoria (
    id                INTEGER NOT NULL,
    motivo            VARCHAR2(30 CHAR) NOT NULL,
    detalhes          VARCHAR2(100 CHAR) NOT NULL,
    usuario_pessoa_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (usuario_pessoa_id) REFERENCES usuario (pessoa_id)
);

CREATE TABLE resposta (
    id                     INTEGER NOT NULL,
    descricao              VARCHAR2(100 CHAR) NOT NULL,
    contato_consultoria_id INTEGER NOT NULL,
    consultor_pessoa_id    INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (contato_consultoria_id) REFERENCES contato_consultoria (id),
    FOREIGN KEY (consultor_pessoa_id) REFERENCES consultor (pessoa_id)
);

CREATE TABLE item_descarte (
    id         INTEGER NOT NULL,
    nome       VARCHAR2(30 CHAR) NOT NULL,
    descricao  VARCHAR2(100 CHAR) NOT NULL,
    riscos     VARCHAR2(100 CHAR) NOT NULL,
    empresa_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (empresa_id) REFERENCES empresa (id)
);

CREATE TABLE local_item_descarte (
    item_descarte_id  INTEGER NOT NULL,
    local_descarte_id INTEGER NOT NULL,
    PRIMARY KEY (item_descarte_id, local_descarte_id),
    FOREIGN KEY (item_descarte_id) REFERENCES item_descarte (id),
    FOREIGN KEY (local_descarte_id) REFERENCES local_descarte (id)
);

CREATE SEQUENCE empresa_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER empresa_id_trg
BEFORE INSERT ON empresa
FOR EACH ROW
WHEN (new.id IS NULL)
BEGIN
    :new.id := empresa_id_seq.nextval;
END;

CREATE SEQUENCE pais_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pais_id_trg 
BEFORE INSERT ON pais 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := pais_id_seq.nextval; 
END;

CREATE SEQUENCE estado_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER estado_id_trg 
BEFORE INSERT ON estado 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := estado_id_seq.nextval; 
END;

CREATE SEQUENCE cidade_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER cidade_id_trg 
BEFORE INSERT ON cidade 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := cidade_id_seq.nextval; 
END;

CREATE SEQUENCE bairro_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bairro_id_trg 
BEFORE INSERT ON bairro 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := bairro_id_seq.nextval; 
END;

CREATE SEQUENCE endereco_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER endereco_id_trg 
BEFORE INSERT ON endereco 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := endereco_id_seq.nextval; 
END;

CREATE SEQUENCE local_descarte_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER local_descarte_id_trg 
BEFORE INSERT ON local_descarte 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := local_descarte_id_seq.nextval; 
END;

CREATE SEQUENCE pessoa_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pessoa_id_trg 
BEFORE INSERT ON pessoa 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := pessoa_id_seq.nextval; 
END;

CREATE SEQUENCE contato_consultoria_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER contato_consultoria_id_trg 
BEFORE INSERT ON contato_consultoria 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := contato_consultoria_id_seq.nextval; 
END;

CREATE SEQUENCE resposta_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER resposta_id_trg 
BEFORE INSERT ON resposta 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := resposta_id_seq.nextval; 
END;

CREATE SEQUENCE item_descarte_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER item_descarte_id_trg 
BEFORE INSERT ON item_descarte 
FOR EACH ROW 
WHEN (new.id IS NULL) 
BEGIN 
    :new.id := item_descarte_id_seq.nextval; 
END;
