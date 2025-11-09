BEGIN;

DROP TABLE IF EXISTS empleados CASCADE;
DROP TABLE IF EXISTS departamentos CASCADE;
DROP TABLE IF EXISTS productos CASCADE;

CREATE TABLE departamentos (
  id     SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE
);

CREATE TABLE empleados (
  id              SERIAL PRIMARY KEY,
  nombre          TEXT NOT NULL,
  apellido        TEXT NOT NULL,
  departamento_id INT  NOT NULL REFERENCES departamentos(id) ON DELETE RESTRICT
);
CREATE INDEX IF NOT EXISTS idx_empleados_dep ON empleados(departamento_id);

CREATE TABLE productos (
  id     SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  precio NUMERIC(10,2) NOT NULL CHECK (precio >= 0),
  stock  INT NOT NULL CHECK (stock >= 0)
);

COMMIT;
