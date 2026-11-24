DROP TABLE IF EXISTS vrsta_proizvoda CASCADE;
DROP TABLE IF EXISTS proizvođač CASCADE;
DROP TABLE IF EXISTS proizvod CASCADE;
DROP TABLE IF EXISTS uvoznik CASCADE;
DROP TABLE IF EXISTS narudžba CASCADE;
DROP TABLE IF EXISTS stavka CASCADE;
DROP TABLE IF EXISTS luka CASCADE;
DROP TABLE IF EXISTS agent CASCADE;
DROP TABLE IF EXISTS brodar CASCADE;
DROP TABLE IF EXISTS brod CASCADE;
DROP TABLE IF EXISTS plovidbe CASCADE;
DROP TABLE IF EXISTS kontejner CASCADE;
DROP TABLE IF EXISTS vozač CASCADE;
DROP TABLE IF EXISTS prijevoznik CASCADE;
DROP TABLE IF EXISTS kamion CASCADE;
DROP TABLE IF EXISTS iskrcaj CASCADE;


CREATE TABLE vrsta_proizvoda (
	vrsta_proizvoda_id SERIAL CONSTRAINT vrsta_proizvoda_pk PRIMARY KEY,
	naziv VARCHAR(20) NOT NULL
);
COMMENT ON TABLE vrsta_proizvoda IS 'Sadrži podatke o vrstama proizvoda';

CREATE TABLE proizvođač(
	proizvođač_id SERIAL CONSTRAINT proizvođač_pk PRIMARY KEY,
	naziv VARCHAR(20) NOT NULL,
	adresa_sjedišta VARCHAR(30),
	kontakt_podaci VARCHAR(10) NOT NULL,
	rok_proizvodnje TIMESTAMP WITH TIME ZONE
);
COMMENT ON TABLE vrsta_proizvoda IS 'Sadrži podatke o proizvođačima';

CREATE TABLE proizvod(
	proizvod_id SERIAL CONSTRAINT proizvod_pk PRIMARY KEY,
	naziv VARCHAR(30) NOT NULL,
	vrsta_proizvoda_id INTEGER CONSTRAINT proizvod_fk_vrsta_proizvoda
	REFERENCES vrsta_proizvoda(vrsta_proizvoda_id),
	proizvođač_id INTEGER CONSTRAINT proizvod_fk_proizvođač
	REFERENCES proizvođač(proizvođač_id),
	opis VARCHAR(50) DEFAULT 'Nema opisa',
	cijena NUMERIC(8,2) NOT NULL CHECK (cijena > 0),
	valuta CHARACTER(3) NOT NULL DEFAULT 'USD'
);
COMMENT ON TABLE proizvod IS 'Sadrži podatke o proizvodima';

CREATE TABLE uvoznik(
	uvoznik_id SERIAL CONSTRAINT uvoznik_pk PRIMARY KEY,
	naziv VARCHAR(30) NOT NULL,
	adresa VARCHAR(50) NOT NULL,
	kontakt VARCHAR(10) NOT NULL
);
COMMENT ON TABLE uvoznik IS 'Sadrži podatke o uvoznicima';

CREATE TABLE luka(
	luka_id INTEGER CONSTRAINT luka_pk PRIMARY KEY,
	ime_luke VARCHAR(30) NOT NULL,
	koordinate POINT NOT NULL,
	vremenska_zona TEXT NOT NULL,
	mjesto VARCHAR(30) NOT NULL,
	trošak_luke NUMERIC(7,2) NOT NULL CHECK (trošak_luke > 0),
	valuta CHARACTER(3) NOT NULL DEFAULT 'USD',
	rok_ukrcaja_tereta VARCHAR(10) DEFAULT 'Nepoznato',
	rok_iskrcaja_tereta VARCHAR(10) DEFAULT 'Nepoznato'
);
COMMENT ON TABLE luka IS 'Sadrži podatke o lukama';

CREATE TABLE agent(
	agent_id INTEGER CONSTRAINT agent_pk PRIMARY KEY,
	naziv VARCHAR(20) NOT NULL,
	kontakt VARCHAR(10) NOT NULL,
	luka_id INTEGER CONSTRAINT agent_fk_luka
	REFERENCES luka(luka_id)
);
COMMENT ON TABLE agent IS 'Sadrži podatke o agentima';

CREATE TABLE narudžba(
	narudžba_id INTEGER CONSTRAINT narudžba_pk PRIMARY KEY,
	cijena MONEY NOT NULL,
	valuta CHARACTER(3) NOT NULL DEFAULT 'USD',
	uvjeti_plaćanja VARCHAR(30) NOT NULL DEFAULT 'Nedogovoreno',
	datum DATE NOT NULL,
	adresa_dostave VARCHAR(50) NOT NULL,
	agent_id INTEGER CONSTRAINT narudžba_fk_agent
	REFERENCES agent(agent_id),
	uvoznik_id INTEGER CONSTRAINT narudžba_fk_uvoznik
	REFERENCES uvoznik(uvoznik_id)
);
COMMENT ON TABLE narudžba IS 'Sadrži podatke o narudžbama';

CREATE TABLE stavka(
	proizvod_id INTEGER CONSTRAINT stavka_fk_proizvod
	REFERENCES proizvod(proizvod_id),
	narudžba_id INTEGER CONSTRAINT stavka_fk_narudžba
	REFERENCES narudžba(narudžba_id),
	količina INTEGER NOT NULL CHECK (količina >= 0),
	CONSTRAINT stavka_pk PRIMARY KEY (proizvod_id, narudžba_id)
);
COMMENT ON TABLE stavka IS 'Sadrži stavke narudžbi';

CREATE TABLE brodar(
	brodar_id INTEGER CONSTRAINT brodar_pk PRIMARY KEY,
	naziv VARCHAR(30) NOT NULL,
	adresa_sjedišta VARCHAR(50),
	kontakt VARCHAR(10) NOT NULL,
	cijena_usluge MONEY NOT NULL,
	valuta CHARACTER(3) NOT NULL DEFAULT 'USD',
	vremenski_rok_prijevoza VARCHAR(10) NOT NULL
);
COMMENT ON TABLE brodar IS 'Sadrži podatke o brodarima';

CREATE TABLE brod(
	brod_id INTEGER CONSTRAINT brod_pk PRIMARY KEY,
	ime VARCHAR(20) NOT NULL,
	model VARCHAR(20) NOT NULL,
	max_br_kontejnera INTEGER NOT NULL DEFAULT 0,
	nosivost INTEGER NOT NULL DEFAULT 0,
	osiguranje BOOL NOT NULL DEFAULT FALSE,
	brodar_id INTEGER CONSTRAINT brod_fk_brodar
	REFERENCES brodar(brodar_id)
);
COMMENT ON TABLE brod IS 'Sadrži podatke o brodovima';

CREATE TABLE plovidbe(
	plovidba_id SERIAL CONSTRAINT plovidba_pk PRIMARY KEY,
	planirani_polazak TIMESTAMP WITH TIME ZONE NOT NULL,
	planirani_dolazak TIMESTAMP WITH TIME ZONE NOT NULL,
	stvarni_polazak TIMESTAMP WITH TIME ZONE,
	stvarni_dolazak TIMESTAMP WITH TIME ZONE,
	trenutna_lokacija_broda POINT NOT NULL,
	polazna_luka INTEGER CONSTRAINT plovidba_fk_pol_luka
	REFERENCES luka(luka_id),
	dolazna_luka INTEGER CONSTRAINT plovidba_fk_dol_luka
	REFERENCES luka(luka_id),
	brod_id INTEGER CONSTRAINT plovidba_fk_brod
	REFERENCES brod(brod_id)
);
COMMENT ON TABLE plovidbe IS 'Sadrži podatke o plovidbama';

CREATE TABLE kontejner(
	kontejner_id SERIAL CONSTRAINT kontejner_pk PRIMARY KEY,
	lokacija_na_brodu VARCHAR(20) NOT NULL,
	veličina VARCHAR(20) NOT NULL,
	težina VARCHAR(10) NOT NULL,
	tracking_number INTEGER,
	narudžba_id INTEGER CONSTRAINT kontejner_fk_narudžba
	REFERENCES narudžba(narudžba_id),
	plovidba_id INTEGER CONSTRAINT kontejner_fk_plovidba
	REFERENCES plovidbe(plovidba_id)
);
COMMENT ON TABLE kontejner IS 'Sadrži podatke o kontejnerima';

CREATE TABLE vozač(
	vozač_id SERIAL CONSTRAINT vozač_pk PRIMARY KEY,
	ime VARCHAR(20) NOT NULL,
	prezime VARCHAR(20) NOT NULL,
	kontakt VARCHAR(10) NOT NULL CHECK (char_length(kontakt) = 10)
);
COMMENT ON TABLE vozač IS 'Sadrži podatke o vozačima';

CREATE TABLE prijevoznik(
	prijevoznik_id INTEGER CONSTRAINT prijevoznik_pk PRIMARY KEY,
	naziv VARCHAR(20) NOT NULL,
	adresa VARCHAR(50) NOT NULL,
	kontakt VARCHAR(10) NOT NULL,
	cijena_usluge NUMERIC(5,2) NOT NULL CHECK (cijena_usluge > 0),
	valuta CHARACTER(3) NOT NULL DEFAULT 'USD'
);
COMMENT ON TABLE prijevoznik IS 'Sadrži podatke o prijevoznicima';

CREATE TABLE kamion(
	kamion_id INTEGER CONSTRAINT kamion_pk PRIMARY KEY,
	registracija VARCHAR(8) NOT NULL CHECK (char_length(registracija) = 8),
	model VARCHAR(20) NOT NULL,
	rok_dostave VARCHAR(10) NOT NULL DEFAULT 'Nepoznato',
	vozač_id INTEGER CONSTRAINT kamion_fk_vozač
	REFERENCES vozač(vozač_id),
	prijevoznik_id INTEGER CONSTRAINT kamion_fk_prijevoznik
	REFERENCES prijevoznik(prijevoznik_id)
);
COMMENT ON TABLE kamion IS 'Sadrži podatke o kamionima';

CREATE TABLE iskrcaj(
	kontejner_id INTEGER CONSTRAINT iskrcaj_fk_kontejner
	REFERENCES kontejner(kontejner_id),
	kamion_id INTEGER CONSTRAINT iskrcaj_fk_kamion
	REFERENCES kamion(kamion_id),
	troškovi NUMERIC(5,2) NOT NULL CHECK (troškovi > 0),
	valuta CHARACTER(3) NOT NULL DEFAULT 'USD',
	inspekcije_status BOOL NOT NULL DEFAULT FALSE,
	carina_status BOOL NOT NULL DEFAULT FALSE,
	termin_preuzimanja TIMESTAMP WITH TIME ZONE NOT NULL,
	špedicija_status BOOL NOT NULL DEFAULT FALSE
);
COMMENT ON TABLE iskrcaj IS 'Sadrži podatke o iskrcajima kontejnera';


ALTER TABLE brod
ADD CONSTRAINT provjera_max_br_kont
CHECK (max_br_kontejnera > 0);

ALTER TABLE brod
ADD CONSTRAINT provjera_nosivosti
CHECK (nosivost > 0);

