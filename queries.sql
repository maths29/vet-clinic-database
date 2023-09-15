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

/* Transactions */

/*1*/
/*Inside a transaction update the animals table by setting the species column to unspecified*/
BEGIN;
UPDATE animals SET species = 'unspecified';

/*Roll back the change*/
ROLLBACK;
/*Verify that the species columns went back to the state before the transaction*/
SELECT * FROM animals;

/*2*/
/*Inside a transaction*/
BEGIN;
/*Update the animals table by setting the species column to digimon for all animals that have a name ending in mon*/
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
/*Update the animals table by setting the species column to pokemon for all animals that don't have species already set*/
UPDATE animals SET species = 'pokemon' WHERE species = '';
/*Commit the transaction.*/
COMMIT;
/*Verify that changes persist after commit.*/
SELECT * FROM animals;

/*3*/
/*Inside a transaction delete all records in the animals table, then roll back the transaction*/
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*4*/
/*Inside a transaction:*/
BEGIN;
/*Delete all animals born after Jan 1st, 2022.*/
DELETE FROM animals WHERE date_of_birth IN (SELECT date_of_birth WHERE date_of_birth > '2022-01-01');
/*Create a savepoint for the transaction.*/
SAVEPOINT delete_date;
/*Update all animals' weight to be their weight multiplied by -1.*/
UPDATE animals SET weight_kg = weight_kg * -1;
/*Rollback to the savepoint*/
ROLLBACK TO SAVEPOINT delete_date;
/*Update all animals' weights that are negative to be their weight multiplied by -1.*/
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
/*Commit transaction.*/
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

-- Query multiple tables

/*What animals belong to Melody Pond?*/
SELECT name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
/*List of all animals that are pokemon (their type is Pokemon).*/
SELECT animals.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
/*List all owners and their animals, remember to include those that don't own any animal.*/
SELECT full_name, name FROM owners LEFT JOIN animals ON animals.owner_id = owners.id;
/*How many animals are there per species?*/
SELECT COUNT(*), species.name FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;
/*List all Digimon owned by Jennifer Orwell.*/
SELECT animals.name FROM animals INNER JOIN species ON animals.species_id = species.id INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;
/*Who owns the most animals?*/
SELECT COUNT(*) as count, full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY count DESC;




/*Who was the last animal seen by William Tatcher?*/
SELECT animals.name FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON visits.vet_id  = vets.id WHERE vets.name = 'William Tatcher' ORDER BY visits.visit_date DESC LIMIT 1;
/*How many different animals did Stephanie Mendez see?*/
SELECT COUNT(DISTINCT visits.animal_id) AS Animals_seen FROM visits JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez';
/*List all vets and their specialties, including vets with no specialties.*/
SELECT vets.name,species.name FROM specializations RIGHT JOIN vets ON vets.id = specializations.vet_id LEFT JOIN species ON species.id  = specializations.species_id;
/*List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT vets.name AS Veterinary_name, animals.name AS Animal_name,visits.visit_date FROM visits JOIN vets ON visits.vet_id = vets.id JOIN animals ON visits.animal_id  = animals.id WHERE vets.name = 'Stephanie Mendez' AND visit_date BETWEEN '2020-04-01' AND '2020-08-30';
/*What animal has the most visits to vets?*/
SELECT animals.name AS Animal_name, COUNT(visits.visit_date) as Most_visits FROM visits JOIN vets ON visits.vet_id = vets.id JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name ORDER BY Most_visits DESC LIMIT 1;
/*Who was Maisy Smith's first visit?*/
SELECT vets.name AS Vet_name, animals.name AS Animal_name, visits.visit_date FROM visits JOIN vets ON visits.vet_id = vets.id JOIN animals ON visits.animal_id = animals.id WHERE vets.name = 'Maisy Smith' ORDER BY visit_date LIMIT 1;
/*Details for most recent visit: animal information, vet information, and date of visit.*/
SELECT animals.name AS animal_name,animals.date_of_birth,animals.escape_attempts,animals.neutered,animals.weight_kg,animals.species_id,vets.name AS vet_name,vets.age,vets.date_of_graduation,visits.visit_date FROM visits JOIN vets ON visits.vet_id = vets.id JOIN animals ON visits.animal_id = animals.id ORDER BY visit_date DESC LIMIT 1;SELECT animals.name AS animal_name,animals.date_of_birth,animals.escape_attempts,animals.neutered,animals.weight_kg,animals.species_id,vets.name AS vet_name,vets.age,vets.date_of_graduation,visits.visit_date FROM visits JOIN vets ON visits.vet_id = vets.id JOIN animals ON visits.animal_id = animals.id ORDER BY visit_date DESC LIMIT 1;
/*How many visits were with a vet that did not specialize in that animal's species?*/
SELECT vets.name AS vet_name,animals.name AS animal_name,animals.species_id AS animal_species_id,specializations.species_id AS vets_specialization_id FROM visits  JOIN vets ON visits.vet_id = vets.id JOIN animals  ON visits.animal_id = animals.id JOIN specializations  ON specializations.vet_id = vets.id WHERE specializations.species_id != animals.species_id;
/*What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT vets.name AS vet_name,species.name AS animal_species,COUNT(species.name) AS number_of_animals FROM visits JOIN vets  ON visits.vet_id = vets.id JOIN animals ON visits.animal_id = animals.id JOIN species ON animals.species_id = species.id WHERE vets.name = 'Maisy Smith' GROUP BY species.name,vets.name ORDER BY number_of_animals DESC LIMIT 1;
