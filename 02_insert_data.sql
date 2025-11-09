BEGIN;

-- Departamentos
INSERT INTO departamentos (nombre) VALUES
  ('TI'),
  ('Ventas'),
  ('RRHH');

-- Empleados
INSERT INTO empleados (nombre, apellido, departamento_id) VALUES
  ('Luis',   'García', (SELECT id FROM departamentos WHERE nombre='TI')),
  ('María',  'López',  (SELECT id FROM departamentos WHERE nombre='TI')),
  ('Ana',    'Pérez',  (SELECT id FROM departamentos WHERE nombre='Ventas')),
  ('Carlos', 'Díaz',   (SELECT id FROM departamentos WHERE nombre='RRHH'));

-- Productos (con stock variado)
INSERT INTO productos (nombre, precio, stock) VALUES
  ('Laptop',   15000.00, 3),
  ('Mouse',      250.00, 100),
  ('Teclado',    600.00, 8),
  ('Monitor',   3200.00, 0),
  ('Silla',     2200.00, 15);

COMMIT;
