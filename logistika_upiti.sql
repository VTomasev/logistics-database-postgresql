-- JEDNOSTAVNI UPITI

-- to je važna informacija za planiranje plovidbe
SELECT ime, model, max_br_kontejnera, nosivost
FROM brod
WHERE max_br_kontejnera > 20000 AND nosivost > 100000
ORDER BY max_br_kontejnera, nosivost;

-- sve plovidbe planirane između 2 datuma
SELECT planirani_polazak, planirani_dolazak, trenutna_lokacija_broda, polazna_luka, dolazna_luka
FROM plovidbe
WHERE planirani_polazak BETWEEN '2023-06-01' AND '2023-12-31'
ORDER BY planirani_polazak, planirani_dolazak;


-- informacija potrebna proizvođaču da zna gdje će slati narudžbu, koga kontaktirati
SELECT naziv, adresa, kontakt 
FROM uvoznik
WHERE naziv LIKE 'Global Trade';


-- dohvati sve stavke narudžbe za narudžbu s id-jem 2, važno kad se slaže narudžba
SELECT * 
FROM stavka
WHERE narudžba_id = 2
ORDER BY proizvod_id;


-- koji se kontejneri mogu dalje preuzimati i voziti nakon iskrcaja
-- (jesu li ispunili sve potrebne uvjete: prošli carinu, inspekcije, odrađena špedicija)
SELECT kontejner_id, kamion_id, termin_preuzimanja 
FROM iskrcaj
WHERE inspekcije_status = TRUE AND carina_status = TRUE AND špedicija_status = TRUE;




-- UPITI NAD VIŠE TABLICA

-- uvoznik prati svoj kontejner
SELECT b.ime, b.model, p.trenutna_lokacija_broda, p.planirani_dolazak
FROM kontejner k INNER JOIN plovidbe p
USING (plovidba_id)
INNER JOIN brod b
USING (brod_id)
INNER JOIN narudžba
USING (narudžba_id)
INNER JOIN uvoznik u
USING (uvoznik_id)
WHERE u.naziv = 'Import Co';



-- kad koji vozač i s kojim kamionom preuzima koji kontejner
SELECT v.ime || ' ' || v.prezime AS "Ime i prezime vozača", k.registracija, k.model, 
	i.termin_preuzimanja, kon.kontejner_id
FROM vozač v INNER JOIN kamion k
USING (vozač_id)
INNER JOIN iskrcaj i
USING (kamion_id)
INNER JOIN kontejner kon
USING (kontejner_id)
GROUP BY v.ime, v.prezime, k.registracija, k.model, i.termin_preuzimanja, kon.kontejner_id
ORDER BY i.termin_preuzimanja;



-- adresa na koju kamion vozi kontejner
SELECT n.adresa_dostave, kon.kontejner_id
FROM narudžba n INNER JOIN kontejner kon
USING (narudžba_id)
INNER JOIN iskrcaj i
USING (kontejner_id)
INNER JOIN kamion k
USING (kamion_id)
INNER JOIN vozač v
USING (vozač_id)
WHERE kon.kontejner_id = 6;


-- ukupna količina naručenih proizvoda po po uvozniku
SELECT u.naziv,
SUM(s.količina) AS "Ukupna količina proizvoda"
FROM narudžba n JOIN uvoznik u
USING (uvoznik_id)
JOIN stavka s
USING (narudžba_id)
GROUP BY u.naziv
ORDER BY SUM(s.količina) DESC;


-- ukupna prodaja po proizvodu
SELECT
    p.naziv AS naziv_proizvoda,
    SUM(s.količina * p.cijena) AS ukupna_prodaja
FROM narudžba n
JOIN stavka s
USING (narudžba_id)
JOIN proizvod p
USING (proizvod_id)
GROUP BY p.naziv
ORDER BY ukupna_prodaja;



-- UPITI S AGREGIRAJUĆIM FUNKCIJAMA

-- koliko neki proizvođač ima narudžbi
SELECT pr.naziv AS "Proizvođač", COUNT(narudžba_id) AS "Broj narudžbi"
FROM narudžba n INNER JOIN stavka s
USING (narudžba_id)
INNER JOIN proizvod p
USING (proizvod_id)
INNER JOIN proizvođač pr
USING (proizvođač_id)
GROUP BY pr.naziv, proizvođač_id
ORDER BY pr.naziv;


-- prosječna cijena narudžbi po uvozniku
SELECT uvoznik_id, ROUND(AVG(cijena::NUMERIC::INTEGER), 2) AS prosječna_cijena
FROM narudžba
GROUP BY uvoznik_id
ORDER BY AVG(cijena::NUMERIC::INTEGER);


-- najveća cijena narudžbe po agentu
SELECT agent_id, MAX(cijena) AS najveća_cijena
FROM narudžba
GROUP BY agent_id
ORDER BY MAX(cijena);


-- ukupna količina proizvoda po vrsti proizvoda
SELECT p.vrsta_proizvoda_id, SUM(s.količina) AS ukupna_količina
FROM stavka s
JOIN proizvod p ON s.proizvod_id = p.proizvod_id
GROUP BY p.vrsta_proizvoda_id
ORDER BY p.vrsta_proizvoda_id;


-- broj kontejnera po plovidbi
SELECT plovidba_id, COUNT(kontejner_id) AS broj_kontejnera
FROM kontejner
GROUP BY plovidba_id
ORDER BY COUNT(kontejner_id) DESC;




-- OSTALI UPITI

-- pronalazak kontejnera koji pripadaju narudžbama izvršenim od strane uvoznika s nazivom "..."
SELECT kontejner_id, narudžba_id
FROM kontejner
WHERE narudžba_id IN (SELECT narudžba_id
                      FROM narudžba
                      WHERE uvoznik_id = (SELECT uvoznik_id FROM uvoznik WHERE naziv = 'Import Co'));


-- Pronalazak proizvoda čiji proizvođač ima rok proizvodnje prije ...
SELECT naziv, proizvođač_id
FROM proizvod
WHERE proizvođač_id IN (SELECT proizvođač_id
                        FROM proizvođač
                        WHERE rok_proizvodnje < '2023-01-03')
ORDER BY proizvođač_id;


-- Pronalazak vozača koji voze kamion od prijevoznika s najnižom cijenom usluge:
SELECT ime, prezime
FROM vozač
WHERE vozač_id IN (SELECT vozač_id
                   FROM kamion
                   WHERE prijevoznik_id = (SELECT prijevoznik_id
                                           FROM prijevoznik
                                           ORDER BY cijena_usluge
                                           LIMIT 1));


-- Pronalazak brodova koji trenutno plove između dvije specifične luke:
SELECT ime
FROM brod
WHERE brod_id IN (SELECT brod_id
                  FROM plovidbe
                  WHERE polazna_luka = (SELECT luka_id FROM luka WHERE ime_luke = 'Luka1')
                  AND dolazna_luka = (SELECT luka_id FROM luka WHERE ime_luke = 'Luka2'));








-- prikaz svih luka i brodara (uključujući duplikate):
SELECT ime_luke AS naziv
FROM luka
UNION ALL
SELECT naziv
FROM brodar;


-- Prikaži popis svih agenata koji rade u lukama s troškovima manjim od 1000.
SELECT naziv
FROM agent a
JOIN luka l ON a.luka_id = l.luka_id
WHERE l.trošak_luke < 1000
INTERSECT
SELECT naziv
FROM agent;






-- INDEKSI

CREATE INDEX idx_uvoznik_naziv ON uvoznik(naziv);

CREATE INDEX idx_narudžba_cijena ON narudžba(cijena);

CREATE INDEX idx_narudžba_datum ON narudžba(datum);

CREATE INDEX idx_plovidbe_planirani_polazak ON plovidbe(planirani_polazak);

CREATE INDEX idx_plovidbe_planirani_dolazak ON plovidbe(planirani_dolazak);

CREATE INDEX idx_plovidbe_dolazna_luka ON plovidbe(dolazna_luka);












-- PROCEDURE
-- iduće procedure su potrebne da bi se ažurirao status inspekcija, carine i špedicije
-- korisne jer se to mijenja tek nakon iskrcaja, dotad je false a mora biti true da 
-- bismo mogli raditi s robom

CREATE OR REPLACE PROCEDURE azuriraj_status_inspekcije (
    p_kontejner_id INTEGER,
    p_kamion_id INTEGER,
    novi_status BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE iskrcaj
    SET inspekcije_status = novi_status
    WHERE kontejner_id = p_kontejner_id AND kamion_id = p_kamion_id;
END;
$$;


CALL azuriraj_status_inspekcije(2, 2, TRUE);


CREATE OR REPLACE PROCEDURE azuriraj_status_carine (
    p_kontejner_id INTEGER,
    p_kamion_id INTEGER,
    novi_status BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE iskrcaj
    SET carina_status = novi_status
    WHERE kontejner_id = p_kontejner_id AND kamion_id = p_kamion_id;
END;
$$;


CREATE OR REPLACE PROCEDURE azuriraj_status_špedicije (
    p_kontejner_id INTEGER,
    p_kamion_id INTEGER,
    novi_status BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE iskrcaj
    SET špedicija_status = novi_status
    WHERE kontejner_id = p_kontejner_id AND kamion_id = p_kamion_id;
END;
$$;



-- može se promijeniti adresa narudžbe nakon što je naručeno ili smo naručili na
-- pogrešnu adresu, a to je važna informacija, zato sam napravila ovu proceduru
CREATE OR REPLACE PROCEDURE azuriraj_adresu_dostave (
    p_narudžba_id INTEGER,
    p_nova_adresa VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE narudžba
    SET adresa_dostave = p_nova_adresa
    WHERE narudžba_id = p_narudžba_id;
END;
$$;

CALL azuriraj_adresu_dostave (2, 'Koperska ulica 3, Ljubljana');
SELECT * FROM narudžba WHERE narudžba_id = 2;


-- umetanje nove plovidbe
CREATE OR REPLACE PROCEDURE dodaj_plovidbu (
    p_planirani_polazak TIMESTAMP WITH TIME ZONE,
    p_planirani_dolazak TIMESTAMP WITH TIME ZONE,
    p_trenutna_lokacija_broda POINT,
    p_polazna_luka INTEGER,
    p_dolazna_luka INTEGER,
    p_brod_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO plovidbe (planirani_polazak, planirani_dolazak, trenutna_lokacija_broda, polazna_luka, dolazna_luka, brod_id)
    VALUES (p_planirani_polazak, p_planirani_dolazak, p_trenutna_lokacija_broda, p_polazna_luka, p_dolazna_luka, p_brod_id);
END;
$$;


CALL dodaj_plovidbu ('2024-07-15 08:00:00+00', '2024-07-20 18:00:00+00', POINT(45.8150, 15.9819), 1, 2, 1);





CREATE OR REPLACE PROCEDURE brisi_iskrcaj (
    p_kontejner_id INTEGER,
    p_kamion_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM iskrcaj
    WHERE kontejner_id = p_kontejner_id AND kamion_id = p_kamion_id;
END;
$$;




-- OKIDAČI
CREATE OR REPLACE FUNCTION provjeri_datum_trg() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.datum < CURRENT_DATE THEN
        RAISE EXCEPTION 'Datum ne može biti u prošlosti.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER provjeri_datum
BEFORE INSERT OR UPDATE ON proizvođač
FOR EACH ROW EXECUTE FUNCTION provjeri_datum_trg();


CREATE OR REPLACE FUNCTION neg_cijena() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.cijena < 0 THEN
        RAISE EXCEPTION 'Cijena ne može biti negativna.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER provjeri_cijenu
BEFORE INSERT OR UPDATE ON brodar
FOR EACH ROW EXECUTE FUNCTION neg_cijena();



CREATE OR REPLACE FUNCTION veća_cijena() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.cijena > cijena THEN
        RAISE EXCEPTION 'Povećanje cijene.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER veća_cijena
BEFORE UPDATE ON proizvod
FOR EACH ROW EXECUTE FUNCTION veća_cijena();





