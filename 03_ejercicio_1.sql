CREATE OR REPLACE FUNCTION calcular_precio_descuento(precio NUMERIC, porcentaje NUMERIC)
RETURNS NUMERIC AS $$
DECLARE
  pct  NUMERIC := GREATEST(0, LEAST(porcentaje, 100));
  base NUMERIC := GREATEST(precio, 0);
BEGIN
  RETURN ROUND(base * (1 - pct / 100.0), 2);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
