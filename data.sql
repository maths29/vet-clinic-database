/* Populate database with sample data. */

INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES('Agumon', '2020-02-03', 0, true, 10.23),
      ('Gabumon', '2018-11-15', 2, true,8),
      (' Pikachu', '2021-01-07', 1, false,15.04),
      ('Devimon', '2017-05-12', 5, true,11);


      -- Query and Update animals table


INSERT INTO animals(name,date_of_birth, escape_attempts,neutered,weight_kg,species) VALUES('Charmander', '2020-02-08', 0, false,-11,NULL),
     ('Plantmon', '2021-11-15', 2, true,-5.7,NULL),
     ('Squirtle', '1993-04-02', 3, false,-12.13,NULL),
     ('Angemon', '2005-06-12', 1, true,-45,NULL),
     ('Boarmon', '2005-06-07', 7, true,20.4,NULL),
     ('Blossom', '1998-10-13', 3, true,17,NULL),
     ('Ditto', '2022-05-14', 4, true,22,NULL);


     /*Day Three Project*/
     
     INSERT INTO owners (full_name, age) VALUES('Sam Smith', 34);
     INSERT INTO owners (full_name, age) VALUES('Jennifer Orwell', 19);
     INSERT INTO owners (full_name, age) VALUES('Bob', 45);
     INSERT INTO owners (full_name, age) VALUES('Melody Pond', 77);
     INSERT INTO owners (full_name, age) VALUES('Dean Winchester', 14);
     INSERT INTO owners (full_name, age) VALUES('Jodie Whittaker', 38);

     INSERT INTO species (name) VALUES('Digimon');
     INSERT INTO species (name) VALUES('Pokemon');

     /*Updates*/
     UPDATE animals SET species_id = 1 WHERE name LIKE '%mon';
     UPDATE animals SET species_id = 2 WHERE species_id IS NULL;

     UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
     UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon','Pikachu');
     UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon','Plantmon');
     UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander','Squirtle','Blossom');
     UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon','Boarmon');


     
/**Day Four Projects*/
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, date '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, date '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, date '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, date '2008-06-08');

INSERT INTO specializations (vet_id, species_id) VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), 1);
INSERT INTO specializations (vet_id, species_id) VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 2);
INSERT INTO specializations (vet_id, species_id) VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 1);
INSERT INTO specializations (vet_id, species_id) VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), 2);

INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), date '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), date '2020-07-22');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), date '2021-02-02');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2020-01-05');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2020-03-08');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2020-05-14');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), date '2021-05-04');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), date '2021-02-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2019-12-21');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), date '2020-08-10');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2021-04-07');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), date '2019-09-29');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), date '2020-10-03');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), date '2020-11-04');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2019-01-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2019-05-15');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2020-02-27');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2020-08-03');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), date '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), date '2021-01-11');