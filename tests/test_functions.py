# tests/test_functions.py
import decimal
import psycopg2
from contextlib import closing

DEC = decimal.Decimal

def connect():
    return psycopg2.connect(
        dbname="test_db",
        user="postgres",
        password="postgres",
        host="localhost",
        port="5432",
    )

def fetch_one(sql, params=None):
    with closing(connect()) as conn, conn.cursor() as cur:
        cur.execute(sql, params or ())
        return cur.fetchone()[0]

def fetch_all(sql, params=None):
    with closing(connect()) as conn, conn.cursor() as cur:
        cur.execute(sql, params or ())
        return cur.fetchall()

def test_calcular_precio_descuento_basico():
    """100 con 15% de descuento = 85.00"""
    val = fetch_one(
        "SELECT calcular_precio_descuento(%s,%s);",
        (DEC("100.00"), DEC("15")),
    )
    assert val == DEC("85.00")

def test_calcular_precio_descuento_limites():
    """Límites: % negativo -> 0; % >100 -> 100"""
    sin_desc = fetch_one(
        "SELECT calcular_precio_descuento(%s,%s);",
        (DEC("100.00"), DEC("-5")),
    )
    cero = fetch_one(
        "SELECT calcular_precio_descuento(%s,%s);",
        (DEC("100.00"), DEC("150")),
    )
    assert sin_desc == DEC("100.00")
    assert cero == DEC("0.00")

def test_contiene_arroba():
    assert fetch_one("SELECT contiene_arroba(%s);", ("a@b.com",)) is True
    assert fetch_one("SELECT contiene_arroba(%s);", ("abc.com",)) is False
    assert fetch_one("SELECT contiene_arroba(%s);", ("@solo",)) is False
    assert fetch_one("SELECT contiene_arroba(%s);", ("fin@",)) is False
    assert fetch_one("SELECT contiene_arroba(%s);", ("",)) is False

def test_productos_bajo_stock_orden_y_contenido():
    rows = fetch_all("SELECT id, nombre, stock FROM productos_bajo_stock(%s);", (10,))
    assert rows == [(4, "Monitor", 0), (1, "Laptop", 3), (3, "Teclado", 8)]

def test_dia_semana():
    """2025-11-09 es Domingo."""
    val = fetch_one("SELECT dia_semana(%s);", ("2025-11-09",))
    assert val == "Domingo"

def test_contar_empleados_en_departamento_ti():
    """En el seed, TI tiene 2 empleados (Luis y María)."""
    dep_id = fetch_one("SELECT id FROM departamentos WHERE nombre='TI';")
    total = fetch_one("SELECT contar_empleados_en_departamento(%s);", (dep_id,))
    assert total == 2
