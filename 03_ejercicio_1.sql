-- 1) Crear una función que calcule el descuento aplicado a un producto.
-- Parámetros: precio original, porcentaje de descuento (0..100)
-- Retorna: precio final redondeado a 2 decimales

CREATE OR REPLACE FUNCTION calcular_precio_descuento(precio NUMERIC, porcentaje NUMERIC)
RETURNS NUMERIC AS $$
DECLARE
  pct  NUMERIC := GREATEST(0, LEAST(porcentaje, 100));
  base NUMERIC := GREATEST(precio, 0);
BEGIN
  RETURN ROUND(base * (1 - pct / 100.0), 2);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
