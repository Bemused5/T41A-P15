CREATE OR REPLACE FUNCTION productos_bajo_stock(minimo INT)
RETURNS TABLE(id INT, nombre TEXT, stock INT) AS $$
BEGIN
  RETURN QUERY
  SELECT p.id, p.nombre, p.stock
  FROM productos p
  WHERE p.stock < minimo
  ORDER BY p.stock ASC, p.id ASC;
END;
$$ LANGUAGE plpgsql STABLE;
