-- S100:
SELECT z.jmeno, z.prijmeni FROM AERO.pilot p, AERO.zamestnanec z 
WHERE p.zamestnanec_id = z.zamestnanec_id AND p.hodnost = 'Captain'
ORDER BY z.prijmeni;

-- S101:
--- smazano ---

-- S102:
SELECT z.prijmeni, z.jmeno, tl.nazev
FROM AERO.zamestnanec z, AERO.pilot p, AERO.let lt, AERO.letadlo ld, AERO.typ_letadla tl
WHERE z.zamestnanec_id = p.zamestnanec_id AND lt.pilot_id = p.pilot_id
AND lt.letadlo_id = ld.letadlo_id AND ld.typ_letadla_id = tl.typ_letadla_id
ORDER BY z.prijmeni, z.jmeno;

-- S103:
SELECT z.prijmeni, z.jmeno FROM AERO.zamestnanec z, AERO.pilot p
WHERE z.zamestnanec_id = p.zamestnanec_id AND z.datum_ukonceni IS NOT NULL
ORDER BY z.prijmeni, z.jmeno;

-- S104:
SELECT z.prijmeni, z.jmeno FROM AERO.zamestnanec z, AERO.pilot p
WHERE z.zamestnanec_id = p.zamestnanec_id AND z.datum_ukonceni IS NULL
AND z.aktivni = 'n'
ORDER BY z.prijmeni, z.jmeno;

-- S105:
SELECT zc.prijmeni, zc.jmeno FROM AERO.zamestnanec zc, AERO.zamestnani zi
WHERE zc.zamestnani_id = zi.zamestnani_id AND (zi.nazev_pozice = 'Pilot' 
OR zi.nazev_pozice = 'Instruktor pilot�e letadel') 
AND zc.datum_ukonceni IS NULL
ORDER BY zc.prijmeni, zc.jmeno;

-- S106:
SELECT
  LET.CISLO_LETU,
  LETADLO.TYP_LETADLA_ID,
  LETOVA_LINKA.NAZEV,
  ZAMESTNANEC.JMENO,
  ZAMESTNANEC.PRIJMENI
FROM
  LET
INNER JOIN LETOVA_LINKA
ON
  LETOVA_LINKA.CISLO_LETOVE_LINKY = LET.CISLO_LETOVE_LINKY
INNER JOIN LETADLO
ON
  LETADLO.LETADLO_ID = LET.LETADLO_ID
INNER JOIN PILOT
ON
  PILOT.PILOT_ID = LET.PILOT_ID
INNER JOIN ZAMESTNANEC
ON
  ZAMESTNANEC.ZAMESTNANEC_ID = PILOT.ZAMESTNANEC_ID
WHERE
  LETOVA_LINKA.NAZEV LIKE 'Prague%';
  
  
-- S107:
SELECT PASAZER.JMENO,
  PASAZER.PRIJMENI,
  DESTINACE.NAZEV
FROM PASAZER
INNER JOIN UCASTNIK_LETU
ON PASAZER.PASAZER_ID = UCASTNIK_LETU.PASAZER_ID
INNER JOIN DESTINACE
ON DESTINACE.DESTINACE_ID = UCASTNIK_LETU.ODKUD
WHERE DESTINACE.NAZEV     = 'Prague';

-- S108:
SELECT ZAMESTNANEC.JMENO,
  ZAMESTNANEC.PRIJMENI,
  DESTINACE.NAZEV,
  LETOVA_LINKA.NAZEV AS NAZEV_LINKY,
  ZASTAVKA.PORADI_ZASTAVKY
FROM ZAMESTNANEC
INNER JOIN PILOT
ON ZAMESTNANEC.ZAMESTNANEC_ID = PILOT.ZAMESTNANEC_ID
INNER JOIN LET
ON PILOT.PILOT_ID = LET.PILOT_ID
INNER JOIN LETOVA_LINKA
ON LETOVA_LINKA.CISLO_LETOVE_LINKY = LET.CISLO_LETOVE_LINKY
INNER JOIN ZASTAVKA
ON LETOVA_LINKA.CISLO_LETOVE_LINKY = ZASTAVKA.CISLO_LETOVE_LINKY
INNER JOIN DESTINACE
ON DESTINACE.DESTINACE_ID    = ZASTAVKA.DESTINACE_ID
WHERE DESTINACE.NAZEV        = 'Prague'
AND ZASTAVKA.PORADI_ZASTAVKY = 0;


-- S200:
SELECT ZAMESTNANEC.JMENO,
  ZAMESTNANEC.PRIJMENI,
  LETADLO.TYP_LETADLA_ID
FROM ZAMESTNANEC
INNER JOIN PILOT
ON ZAMESTNANEC.ZAMESTNANEC_ID = PILOT.ZAMESTNANEC_ID
INNER JOIN LET
ON PILOT.PILOT_ID = LET.PILOT_ID
INNER JOIN LETADLO
ON LETADLO.LETADLO_ID = LET.LETADLO_ID
WHERE LETADLO.TYP_LETADLA_ID IN ('A310', 'A319');
-- S200 - rozsireni:
SELECT DISTINCT ZAMESTNANEC.JMENO,
  ZAMESTNANEC.PRIJMENI,
  LETADLO.TYP_LETADLA_ID
FROM ZAMESTNANEC
INNER JOIN PILOT
ON ZAMESTNANEC.ZAMESTNANEC_ID = PILOT.ZAMESTNANEC_ID
INNER JOIN LET
ON PILOT.PILOT_ID = LET.PILOT_ID
INNER JOIN LETADLO
ON LETADLO.LETADLO_ID = LET.LETADLO_ID
WHERE LETADLO.TYP_LETADLA_ID IN ('A310', 'A319');


-- S201:
SELECT count(distinct PASAZER.JMENO)
FROM PASAZER
INNER JOIN ZAMESTNANEC
ON PASAZER.JMENO = ZAMESTNANEC.JMENO
INNER JOIN PILOT
ON ZAMESTNANEC.ZAMESTNANEC_ID = PILOT.ZAMESTNANEC_ID