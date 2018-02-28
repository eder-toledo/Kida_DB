CREATE TABLE catalogSurveyType
(
 idCatalogSurveyType INT NOT NULL ,
 name                VARCHAR(50) NOT NULL ,

 CONSTRAINT PK_catalogSurveyType PRIMARY KEY (idCatalogSurveyType ASC)
);

CREATE TABLE catalog_choice
(
 idCatalogChoice INT NOT NULL ,

 CONSTRAINT PK_catalog_choice PRIMARY KEY (idCatalogChoice ASC)
);

CREATE TABLE user
(
 idUser INT NOT NULL ,
 uuid   CHAR(36) NOT NULL ,
 name   VARCHAR(200) NOT NULL ,
 email  VARCHAR(50) NOT NULL ,

 CONSTRAINT PK_user PRIMARY KEY (idUser ASC)
);

CREATE TABLE catalog_surveys
(
 idCatalogSurvey     INT NOT NULL ,
 typeName                VARCHAR(50) NOT NULL ,
 status              BOOLEAN NOT NULL ,
 idCatalogSurveyType INT NOT NULL ,

 CONSTRAINT PK_catalog_surveys PRIMARY KEY (idCatalogSurvey ASC),
 CONSTRAINT FK_204 FOREIGN KEY (idCatalogSurveyType)
  REFERENCES catalogSurveyType(idCatalogSurveyType)
);

CREATE TABLE form
(
 idForm        INT NOT NULL ,
 idUser        INT NOT NULL ,
 idFormVersion INT NOT NULL ,
 name          VARCHAR(50) NOT NULL ,
 uuid          CHAR(36) NOT NULL ,
 createdAt     DATETIME NOT NULL ,
 editedAt      DATETIME NOT NULL ,
 deleted       BOOLEAN NOT NULL ,

 CONSTRAINT PK_form PRIMARY KEY (idForm ASC),
 CONSTRAINT FK_128 FOREIGN KEY (idUser)
  REFERENCES user(idUser)
);

CREATE TABLE form_version
(
 idFormVersion INT NOT NULL ,
 idForm        INT NOT NULL ,

 CONSTRAINT PK_form_version PRIMARY KEY (idFormVersion ASC),
 CONSTRAINT FK_145 FOREIGN KEY (idForm)
  REFERENCES form(idForm)
);

CREATE TABLE response
(
 idResponse INT NOT NULL ,
 idForm     INT NOT NULL ,

 CONSTRAINT PK_response PRIMARY KEY (idResponse ASC),
 CONSTRAINT FK_171 FOREIGN KEY (idForm)
  REFERENCES form(idForm)
);

CREATE TABLE permission
(
 idForm INT NOT NULL ,

 CONSTRAINT PK_permission PRIMARY KEY (idForm ASC),
 CONSTRAINT FK_132 FOREIGN KEY (idForm)
  REFERENCES form(idForm)
);

CREATE TABLE survey
(
 idSurvey        INT NOT NULL ,
 idCatalogSurvey INT NOT NULL ,
 idForm          INT NOT NULL ,
 idFormVersion   INT NOT NULL ,
 name            VARCHAR(50) NOT NULL ,
 caption         TEXT NOT NULL ,
 hint            VARCHAR(50) NOT NULL ,
 defaultKey         TEXT NOT NULL ,
 required        BOOLEAN NOT NULL ,
 relevance       VARCHAR(50) NOT NULL ,
 filterKey          VARCHAR(50) NOT NULL ,
 relevanceValue  TEXT NOT NULL ,
 filterValue     TEXT NOT NULL ,

 CONSTRAINT PK_survey PRIMARY KEY (idSurvey ASC),
 CONSTRAINT FK_116 FOREIGN KEY (idCatalogSurvey)
  REFERENCES catalog_surveys(idCatalogSurvey),
 CONSTRAINT FK_124 FOREIGN KEY (idForm)
  REFERENCES form(idForm),
 CONSTRAINT FK_153 FOREIGN KEY (idFormVersion)
  REFERENCES form_version(idFormVersion)
);

CREATE TABLE choice
(
 idChoice        INT NOT NULL ,
 idCatalogChoice INT NOT NULL ,
 idSurvey        INT NOT NULL ,
 name            VARCHAR(50) NOT NULL ,
 caption         TEXT NOT NULL ,
 media           TEXT NOT NULL ,

 CONSTRAINT PK_choice PRIMARY KEY (idChoice ASC),
 CONSTRAINT FK_112 FOREIGN KEY (idCatalogChoice)
  REFERENCES catalog_choice(idCatalogChoice),
 CONSTRAINT FK_120 FOREIGN KEY (idSurvey)
  REFERENCES survey(idSurvey)
);

CREATE TABLE response_choice
(
 idResponseChoice INT NOT NULL ,
 idResponse       INT NOT NULL ,
 idChoice         INT NOT NULL ,
 value            JSON NOT NULL ,

 CONSTRAINT PK_response_choice PRIMARY KEY (idResponseChoice ASC),
 CONSTRAINT FK_163 FOREIGN KEY (idResponse)
  REFERENCES response(idResponse),
 CONSTRAINT FK_167 FOREIGN KEY (idChoice)
  REFERENCES choice(idChoice)
);