CREATE OR REPLACE FUNCTION contar_empleados_en_departamento(dep_id INT)
RETURNS INT AS $$
DECLARE
  total INT;
BEGIN
  SELECT COUNT(*)
    INTO total
  FROM empleados
  WHERE departamento_id = dep_id;

  RETURN total;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
