CREATE OR REPLACE FUNCTION dia_semana(fecha DATE)
RETURNS TEXT AS $$
DECLARE
  d INT := EXTRACT(DOW FROM fecha);
BEGIN
  RETURN CASE d
    WHEN 0 THEN 'Domingo'
    WHEN 1 THEN 'Lunes'
    WHEN 2 THEN 'Martes'
    WHEN 3 THEN 'Miércoles'
    WHEN 4 THEN 'Jueves'
    WHEN 5 THEN 'Viernes'
    WHEN 6 THEN 'Sábado'
  END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
