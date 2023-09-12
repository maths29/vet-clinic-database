/*Queries that provide answers to the questions from all projects.*/

      SELECT * FROM animals WHERE name like '%mon'
      SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
      SELECT name FROM animals WHERE neutered=true  AND (escape_attempts < 3);
      SELECT date_of_birth FROM animals WHERE (name='Agumon' Or name='Pikachu');
      SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
      SELECT * FROM animals WHERE neutered=true;
      SELECT * FROM animals WHERE name NOT IN ('Gabumon');
      SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.13 ;




      
-- Query and Update animals table

BEGIN;

UPDATE animals SET species='unspecified';

ROLLBACK;


BEGIN;

UPDATE animals
SET species ='digimon'
WHERE name like '%mon';


UPDATE animals
SET species ='pokemon'
WHERE name NOT like '%mon';

COMMIT;

BEGIN;

DELETE FROM animals;

ROLLBACK;


BEGIN;

SAVEPOINT SP1;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP2;

UPDATE animals SET weight_kg=weight_kg * (-1);

ROLLBACK TO SP1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;




/*How many animals are there?*/
SELECT COUNT(*) from animals;
/*How many animals have never tried to escape?*/
SELECT COUNT(*) from animals WHERE escape_attempts=0;
/*What is the average weight of animals?*/
SELECT AVG(weight_kg)::NUMERIC(10,2) As avg_weight from animals;
/*Who escapes the most, neutered or not neutered animals?*/
SELECT SUM(escape_attempts) AS escape_attempts,neutered from animals GROUP BY neutered;
/*What is the minimum and maximum weight of each type of animal?*/
SELECT MIN(weight_kg) AS minimum_weight,MAX(weight_kg) as max_weight,species from animals GROUP BY species;
/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
SELECT AVG(escape_attempts)::NUMERIC(10,2) from animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;

