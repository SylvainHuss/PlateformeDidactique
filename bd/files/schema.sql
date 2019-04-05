CREATE USER 'web'@'172.48.0.3' IDENTIFIED BY 'mdp';
CREATE USER 'compil'@'172.48.0.4' IDENTIFIED BY 'mdp';
CREATE USER 'test'@'172.48.0.5' IDENTIFIED BY 'mdp';

create database bd;
use bd;

CREATE TABLE utilisateur
(
id INT,
nom VARCHAR(255),
mdp VARCHAR(255),
type INT,
PRIMARY KEY (id)
);

CREATE TABLE chapitre
(
id INT,
nom VARCHAR(255),
indice VARCHAR(255),
PRIMARY KEY (id)
);

CREATE TABLE exercice
(
id INT,
titre VARCHAR(255),
id_chap INT,
consigne VARCHAR(255),
corrige VARCHAR(255),
parametres VARCHAR(255),
PRIMARY KEY (id),
FOREIGN KEY (id_chap) REFERENCES chapitre(id)
);

CREATE TABLE jeutest
(
id INT,
id_ex INT,
entree VARCHAR(255),
sortie VARCHAR(255),
PRIMARY KEY (id),
FOREIGN KEY (id_ex) REFERENCES exercice(id)
);

CREATE TABLE realise
(
id_ex INT,
id_eleve INT,
temps_debut TIME,
temps_valide TIME,
nb_essai INT,
PRIMARY KEY (id_ex, id_eleve),
FOREIGN KEY (id_ex) REFERENCES exercice(id),
FOREIGN KEY (id_eleve) REFERENCES utilisateur(id)
);

GRANT ALL PRIVILEGES ON bd.* TO 'web'@'172.48.0.3';
GRANT ALL PRIVILEGES ON bd.* TO 'compil'@'172.48.0.4';
GRANT ALL PRIVILEGES ON bd.* TO 'test'@'172.48.0.5';
