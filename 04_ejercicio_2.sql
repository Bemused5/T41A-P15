CREATE OR REPLACE FUNCTION contiene_arroba(correo TEXT)
RETURNS BOOLEAN AS $$
BEGIN
  IF correo IS NULL OR correo = '' THEN
    RETURN FALSE;
  END IF;

  -- Debe existir '@' y no estar al inicio ni al final
  RETURN POSITION('@' IN correo) BETWEEN 2 AND LENGTH(correo) - 1;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
