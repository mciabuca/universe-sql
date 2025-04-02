-- Drop and recreate the database
DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;
\c universe

-- Create galaxy table
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    age_in_millions_of_years INT NOT NULL,
    has_life BOOLEAN NOT NULL,
    galaxy_type VARCHAR(50) NOT NULL
);

-- Create star table
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    age_in_millions_of_years INT NOT NULL,
    spectral_type VARCHAR(50) NOT NULL,
    FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
);

-- Create planet table
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    star_id INT NOT NULL,
    has_life BOOLEAN NOT NULL,
    distance_from_earth NUMERIC NOT NULL,
    planet_type VARCHAR(50) NOT NULL,
    FOREIGN KEY (star_id) REFERENCES star(star_id)
);

-- Create moon table
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    planet_id INT NOT NULL,
    description TEXT NOT NULL,
    size INT NOT NULL,
    has_atmosphere BOOLEAN NOT NULL,
    orbital_period INT NOT NULL,
    FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);

-- Optional 5th table: comet
CREATE TABLE comet (
    comet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    is_periodic BOOLEAN NOT NULL,
    tail_length NUMERIC NOT NULL
);

-- Insert galaxies
INSERT INTO galaxy (name, description, age_in_millions_of_years, has_life, galaxy_type) VALUES
('Milky Way', 'Our home galaxy', 13700, TRUE, 'Spiral'),
('Andromeda', 'Nearest spiral galaxy', 10000, FALSE, 'Spiral'),
('Triangulum', 'Small spiral galaxy', 12000, FALSE, 'Spiral'),
('Sombrero', 'Distinctive bulging galaxy', 8000, FALSE, 'Spiral'),
('Whirlpool', 'Famous for its spiral arms', 7000, FALSE, 'Spiral'),
('Black Eye', 'Notable for its dark band of absorbing dust', 9000, FALSE, 'Spiral');

-- Insert stars
INSERT INTO star (name, galaxy_id, is_spherical, age_in_millions_of_years, spectral_type) VALUES
('Sun', 1, TRUE, 4600, 'G2V'),
('Sirius', 1, TRUE, 242, 'A1V'),
('Betelgeuse', 1, TRUE, 8000, 'M2Iab'),
('Rigel', 2, TRUE, 10, 'B8Ia'),
('Alpha Centauri', 1, TRUE, 5000, 'G2V'),
('Proxima Centauri', 1, TRUE, 4500, 'M5.5V');

-- Insert planets
INSERT INTO planet (name, star_id, has_life, distance_from_earth, planet_type) VALUES
('Earth', 1, TRUE, 0.0, 'Terrestrial'),
('Mars', 1, FALSE, 0.5, 'Terrestrial'),
('Venus', 1, FALSE, 0.3, 'Terrestrial'),
('Jupiter', 1, FALSE, 5.2, 'Gas Giant'),
('Saturn', 1, FALSE, 9.5, 'Gas Giant'),
('Mercury', 1, FALSE, 0.4, 'Terrestrial'),
('Neptune', 1, FALSE, 30.1, 'Ice Giant'),
('Uranus', 1, FALSE, 19.2, 'Ice Giant'),
('Kepler-22b', 2, FALSE, 600, 'Super Earth'),
('Gliese 581d', 2, FALSE, 20.3, 'Super Earth'),
('Proxima b', 6, TRUE, 4.2, 'Terrestrial'),
('TRAPPIST-1e', 6, FALSE, 40, 'Terrestrial');

-- Insert moons
INSERT INTO moon (name, planet_id, description, size, has_atmosphere, orbital_period) VALUES
('Moon', 1, 'Earth''s only natural satellite', 3474, FALSE, 27),
('Phobos', 2, 'Moon of Mars', 22, FALSE, 0.3),
('Deimos', 2, 'Smaller moon of Mars', 12, FALSE, 1.3),
('Europa', 4, 'Icy moon of Jupiter', 3121, FALSE, 3.5),
('Ganymede', 4, 'Largest moon in the solar system', 5268, TRUE, 7.1),
('Callisto', 4, 'Heavily cratered moon of Jupiter', 4820, FALSE, 16.7),
('Titan', 5, 'Largest moon of Saturn', 5150, TRUE, 16),
('Enceladus', 5, 'Icy moon of Saturn', 504, TRUE, 1.4),
('Rhea', 5, 'Second-largest moon of Saturn', 1530, FALSE, 4.5),
('Dione', 5, 'Moon of Saturn', 1120, FALSE, 2.7),
('Tethys', 5, 'Moon of Saturn with a large canyon', 1060, FALSE, 1.9),
('Iapetus', 5, 'Moon with a unique color dichotomy', 1460, FALSE, 79),
('Miranda', 8, 'Moon of Uranus', 480, FALSE, 1.4),
('Ariel', 8, 'Icy moon of Uranus', 1158, FALSE, 2.5),
('Umbriel', 8, 'Dark moon of Uranus', 1169, FALSE, 4.1),
('Titania', 8, 'Largest moon of Uranus', 1578, FALSE, 8.7),
('Oberon', 8, 'Second-largest moon of Uranus', 1523, FALSE, 13.5),
('Charon', 11, 'Moon of Pluto-like body', 1212, FALSE, 6.4),
('Nix', 11, 'Smaller moon', 50, FALSE, 24),
('Hydra', 11, 'Another small moon', 60, FALSE, 27);

-- Insert comets
INSERT INTO comet (name, description, is_periodic, tail_length) VALUES
('Halley', 'Famous periodic comet', TRUE, 15.0),
('Hale-Bopp', 'Bright comet visible to the naked eye', FALSE, 20.5),
('Encke', 'Short period comet', TRUE, 10.0);
