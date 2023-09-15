/* Database schema to keep the structure of entire database. */

 CREATE TABLE animals (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(100),
date_of_birth date,
escape_attempts INT,
neutered BOOLEAN ,
 weight_kg DECIMAL(5,2),
 PRIMARY KEY (id)
);

ALTAR TABLE animals ADD COLUMN species VARCHAR(100)

CREATE TABLE owners (
   id SERIAL PRIMARY KEY,
   full_name VARCHAR(255),
   age INT
);

CREATE TABLE species (
   id SERIAL PRIMARY KEY,
   name VARCHAR(100)
);

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);



CREATE TABLE vets (
   id SERIAL PRIMARY KEY,
   name VARCHAR(255),
   age INT,
   date_of_graduation date
);

CREATE TABLE specializations (
    specialization_id SERIAL PRIMARY KEY, 
    vet_id INT,                           
    species_id INT,                       
    CONSTRAINT fk_vet FOREIGN KEY (vet_id) REFERENCES vets (id),
    CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,    
    animal_id INT,                  
    vet_id INT,                     
    visit_date DATE,                
    CONSTRAINT fk_animal FOREIGN KEY (animal_id) REFERENCES animals (id),
    CONSTRAINT fk_vet FOREIGN KEY (vet_id) REFERENCES vets (id)
);
