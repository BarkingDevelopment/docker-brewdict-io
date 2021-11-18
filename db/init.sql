-- User creation.
CREATE USER IF NOT EXISTS production@'%' IDENTIFIED BY 'prodPass';
SET PASSWORD FOR production@'%' = PASSWORD('prodPass');

CREATE USER IF NOT EXISTS development@'%' IDENTIFIED BY 'devPass';
SET PASSWORD FOR development@'%' = PASSWORD('devPass');

-- Database creation.
CREATE DATABASE brewdict_dev;
GRANT ALL ON brewdict_dev.* TO development@'%';

CREATE DATABASE brewdict;
GRANT ALL ON brewdict.* TO production@'%';
