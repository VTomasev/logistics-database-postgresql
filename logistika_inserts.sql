INSERT INTO vrsta_proizvoda (naziv) VALUES
('Elektronika'),
('Hrana'),
('Odjeća');


INSERT INTO proizvođač (naziv, adresa_sjedišta, kontakt_podaci, rok_proizvodnje) VALUES
('Samsung', 'Seul, Koreja', '1234567890', '2023-01-01 12:00:00+01'),
('Nestle', 'Vevey, Švicarska', '0987654321', '2023-01-02 12:00:00+01'),
('Nike', 'Beaverton, SAD', '1122334455', '2023-01-03 12:00:00+01'),
('Adidas', 'Herzogenaurach, Njemačka', '3344556677', '2023-01-04 12:00:00+01');


INSERT INTO proizvod (naziv, vrsta_proizvoda_id, proizvođač_id, opis, cijena, valuta) VALUES
('Galaxy S21', 4, 5, 'Smartphone', 799.99, 'USD'),
('KitKat', 5, 6, 'Chocolate bar', 1.50, 'EUR'),
('Air Max', 6, 7, 'Running shoes', 120.00, 'USD'),
('Galaxy Z Flip5', 4, 5, 'Smartphone', 999.99, 'USD'),
('SAMSUNG Galaxy Book3 360', 4, 5, 'Laptop', 1299.99, 'USD'),
('Nescafe', 5, 6, 'Instant Coffee', 5.99, 'EUR'),
('Maggi Noodles', 5, 6, 'Instant Noodles', 0.99, 'EUR'),
('Jordan Sneakers', 6, 7, 'Basketball shoes', 150.00, 'USD'),
('Nike T-shirt', 6, 7, 'Sport T-shirt', 25.00, 'USD'),
('Adidas Ultraboost', 6, 8, 'Running shoes', 180.00, 'USD'),
('Adidas Hoodie', 6, 8, 'Sport Hoodie', 70.00, 'USD');


INSERT INTO uvoznik (naziv, adresa, kontakt) VALUES
('Import Co', 'Zagreb, Croatia', '0912345678'),
('Global Trade', 'Ljubljana, Slovenia', '0958765432'),
('ABC Imports', '123 Market St, Springfield', '1234567890'),
('Global Traders', '456 Commerce Ave, Capital City', '2345678901'),
('Euro Import', '789 Trade Blvd, Metropolis', '3456789012');


INSERT INTO luka (luka_id, ime_luke, koordinate, vremenska_zona, mjesto, trošak_luke, valuta, rok_ukrcaja_tereta, rok_iskrcaja_tereta) VALUES
(1, 'Luka Rijeka', '(45.3269, 14.4444)', 'CET', 'Rijeka', 1000.00, 'HRK', '5 dana', '5 dana'),
(2, 'Port of Koper', '(45.5469, 13.7294)', 'CET', 'Koper', 800.00, 'EUR', '4 dana', '4 dana'),
(3, 'Port of Singapore', '(103.9400, 1.2654)', 'Asia/Singapore', 'Singapore', 450.00, 'SGD', '24h', '24h'),
(4, 'Port of Shanghai', '(121.491, 31.224)', 'Asia/Shanghai', 'Shanghai', 400.00, 'CNY', '24h', '24h'),
(5, 'Port of Hamburg', '(9.9937, 53.5411)', 'Europe/Berlin', 'Hamburg', 550.00, 'EUR', '24h', '24h'),
(6, 'Port of Los Angeles', '(-118.2653, 33.7361)', 'America/Los_Angeles', 'Los Angeles', 600.00, 'USD', '24h', '24h'),
(7, 'Port of Rotterdam', '(4.47917, 51.9225)', 'Europe/Amsterdam', 'Rotterdam', 500.00, 'EUR', '24h', '24h');


INSERT INTO agent (agent_id, naziv, kontakt, luka_id) VALUES
(1, 'Trade Partners', '0987654321', 1),
(2, 'Freight Forwarders', '0912345678', 2),
(3, 'Logistics Expert', '8765432109', 3),
(4, 'Trade Services', '7654321098', 4),
(5, 'Harbor Solutions', '6543210987', 5),
(6, 'Port Solutions', '0987654322', 3),
(7, 'Cargo Experts', '0987654323', 4),
(8, 'Global Freight', '0987654324', 5),
(9, 'Seaway Services', '0987654325', 6),
(10, 'Marine Logistics', '0987654326', 1),
(11, 'Agent Smith', '9876543210', 2);


INSERT INTO narudžba (narudžba_id, cijena, valuta, uvjeti_plaćanja, datum, adresa_dostave, agent_id, uvoznik_id) VALUES
(1, 1500.00, 'USD', '30 days', '2023-05-15', 'Zagreb, Croatia', 1, 2),
(2, 500.00, 'EUR', '60 days', '2023-05-20', 'Ljubljana, Slovenia', 2, 3),
(3, 1500.50, 'EUR', '15 days', '2024-06-05', '456 Industrial Ave, Capital City', 3, 1),
(4, 2500.75, 'USD', '60 days', '2024-06-10', '789 Export Rd, Metropolis', 4, 3),
(5, 1750.00, 'SGD', '45 days', '2024-06-15', '321 Import Blvd, Metropolis', 5, 4),
(6, 2000.00, 'USD', '30 days', '2024-06-01', '123 Commerce St, Springfield', 2, 5),
(7, 2200.50, 'EUR', '15 days', '2024-06-25', '222 Industrial Ave, Capital City', 7, 2),
(8, 3500.75, 'USD', '60 days', '2024-07-01', '333 Export Rd, Metropolis', 8, 1),
(9, 2750.00, 'SGD', '45 days', '2024-07-05', '444 Import Blvd, Metropolis', 9, 3),
(10, 3200.00, 'USD', '30 days', '2024-07-10', '555 Commerce St, Springfield', 10, 3),
(11, 2800.50, 'EUR', '15 days', '2024-07-15', '666 Industrial Ave, Capital City', 11, 4),
(12, 4000.75, 'USD', '60 days', '2024-07-20', '777 Export Rd, Metropolis', 2, 5),
(13, 3000.00, 'USD', '30 days', '2024-06-20', '111 Commerce St, Springfield', 6, 5);


INSERT INTO stavka (proizvod_id, narudžba_id, količina) VALUES
(31, 1, 2),
(32, 2, 10),
(23, 2, 50),
(24, 2, 30),
(25, 3, 20),
(26, 3, 40),
(27, 4, 10),
(23, 4, 60),
(24, 5, 25),
(25, 5, 35),
(26, 6, 45),
(27, 6, 15),
(23, 7, 20),
(24, 7, 30),
(25, 8, 40),
(26, 8, 50),
(27, 9, 60),
(28, 9, 10),
(29, 10, 20),
(30, 10, 30),
(33, 11, 40),
(31, 11, 50),
(30, 12, 60),
(29, 12, 10);


INSERT INTO brodar (brodar_id, naziv, adresa_sjedišta, kontakt, cijena_usluge, valuta, vremenski_rok_prijevoza) VALUES
(1, 'MSC', 'Geneva, Switzerland', '0212345678', 2000.00, 'USD', '10 dana'),
(2, 'Maersk', 'Copenhagen, Denmark', '0312345678', 1800.00, 'EUR', '12 dana'),
(3, 'Maritime Logistics', '789 Dock St, Baytown', '8765432109', 20000.00, 'EUR', '25 days'),
(4, 'Global Marine Transport', '101 Marina Ave, Seaside', '7654321098', 18000.00, 'GBP', '40 days'),
(5, 'SeaLink Cargo', '202 Pier Rd, Oceanview', '6543210987', 16000.00, 'USD', '35 days'),
(6, 'Blue Ocean Shipping', '456 Seaport Blvd, Harbor City', '9876543210', 15000.00, 'USD', '30 days');


INSERT INTO brod (brod_id, ime, model, max_br_kontejnera, nosivost, osiguranje, brodar_id) VALUES
(1, 'MSC Zoe', 'Mega-Ship', 20000, 50000, TRUE, 1),
(2, 'Maersk Triple E', 'Triple-E', 18000, 45000, TRUE, 2),
(3,'Emma Maersk', 'Triple E', 18000, 165000, TRUE, 1),
(4, 'MSC Oscar', 'G Class', 19224, 197362, TRUE, 2),
(5, 'COSCO Taurus', 'ULCV', 20000, 210000, TRUE, 3),
(6, 'Ever Given', 'Golden Class', 20124, 220000, TRUE, 3),
(7, 'HMM Algeciras', 'Algeciras Class', 23964, 240000, TRUE, 1);


INSERT INTO plovidbe (planirani_polazak, planirani_dolazak, stvarni_polazak, stvarni_dolazak, trenutna_lokacija_broda, polazna_luka, 
	dolazna_luka, brod_id) VALUES
('2023-06-01 08:00:00+01', '2023-06-11 08:00:00+01', '2023-06-01 08:00:00+01', '2023-06-11 08:00:00+01', '(45.3269, 14.4444)', 1, 2, 1),
('2023-06-15 08:00:00+01', '2023-06-25 08:00:00+01', NULL, NULL, '(45.5469, 13.7294)', 2, 1, 2),
('2024-01-01 08:00:00+01', '2024-01-31 08:00:00+01', '2024-01-01 09:00:00+01', '2024-01-31 09:00:00+01', '(44.4396, 26.0963)', 5, 7, 1),
('2024-02-01 08:00:00+01', '2024-02-28 08:00:00+01', '2024-02-01 09:00:00+01', '2024-02-28 09:00:00+01', '(36.8219, -1.2921)', 6, 3, 2),
('2024-03-01 08:00:00+01', '2024-03-30 08:00:00+01', '2024-03-01 09:00:00+01', '2024-03-30 09:00:00+01', '(35.6895, 139.6917)', 4, 1, 3),
('2023-07-01 08:00:00+01', '2023-07-11 08:00:00+01', '2023-07-01 08:00:00+01', '2023-07-11 08:00:00+01', '(51.9225, 4.47917)', 3, 5, 2),
('2023-08-01 08:00:00+01', '2023-08-11 08:00:00+01', NULL, NULL, '(31.224, 121.491)', 4, 6, 3),
('2024-01-05 08:00:00+01', '2024-01-15 08:00:00+01', '2024-01-05 09:00:00+01', '2024-01-15 09:00:00+01', '(103.9400, 1.2654)', 3, 1, 4),
('2024-02-10 08:00:00+01', '2024-02-20 08:00:00+01', '2024-02-10 09:00:00+01', '2024-02-20 09:00:00+01', '(9.9937, 53.5411)', 6, 2, 5),
('2024-03-05 08:00:00+01', '2024-03-15 08:00:00+01', '2024-03-05 09:00:00+01', '2024-03-15 09:00:00+01', '(-118.2653, 33.7361)', 7, 4, 6);


INSERT INTO kontejner (lokacija_na_brodu, veličina, težina, tracking_number, narudžba_id, plovidba_id) VALUES
('A1', '40ft', '25t', 12345, 1, 1),
('B2', '20ft', '15t', 67890, 2, 2),
('C3', '40ft', '26t', 11223, 3, 3),
('D4', '20ft', '14t', 44556, 4, 4),
('E5', '40ft', '27t', 77889, 5, 5),
('F6', '20ft', '16t', 99001, 6, 1),
('G7', '40ft', '28t', 22334, 7, 2),
('H8', '20ft', '17t', 55667, 8, 3),
('I9', '40ft', '29t', 88990, 9, 4),
('J10', '20ft', '18t', 10011, 10, 5),
('K11', '40ft', '30t', 23345, 11, 1),
('L12', '20ft', '19t', 56678, 12, 2);


INSERT INTO vozač (ime, prezime, kontakt) VALUES
('Ivan', 'Horvat', '0991234567'),
('Marko', 'Maric', '0921234567'),
('Ana', 'Kovač', '0911234567'),
('Petar', 'Novak', '0922234567'),
('Mia', 'Babić', '0933234567'),
('Karlo', 'Marić', '0944234567'),
('Andrija', 'Horvat', '0955234567'),
('Fran', 'Tomić', '0966234567');


INSERT INTO prijevoznik (prijevoznik_id, naziv, adresa, kontakt, cijena_usluge, valuta) VALUES
(1, 'TransCo', 'Zagreb, Croatia', '0912345678', 300.00, 'EUR'),
(2, 'EuroTransport', 'Ljubljana, Slovenia', '0958765432', 400.00, 'EUR'),
(3, 'CargoTrans', 'Belgrade, Serbia', '0112345678', 500.00, 'EUR'),
(4, 'TransGlobal', 'Sofia, Bulgaria', '0298765432', 600.00, 'EUR');


INSERT INTO kamion (kamion_id, registracija, model, rok_dostave, vozač_id, prijevoznik_id) VALUES
(1, 'ZG1234AB', 'Volvo FH', '3 dana', 1, 1),
(2, 'LJ5678CD', 'Scania R', '4 dana', 2, 2),
(3, 'BG1234EF', 'Volvo FH16', '3 dana', 3, 3),
(4, 'SO5678GH', 'Scania S', '4 dana', 4, 4),
(5, 'ZG3456IJ', 'MAN TGX', '2 dana', 5, 1),
(6, 'LJ7890KL', 'DAF XF', '3 dana', 6, 2),
(7, 'BG1122MN', 'Mercedes Actros', '4 dana', 1, 3),
(8, 'SO3344OP', 'Iveco Stralis', '5 dana', 2, 4),
(9, 'ZG5566QR', 'Renault T', '2 dana', 3, 1);


INSERT INTO iskrcaj (kontejner_id, kamion_id, troškovi, valuta, inspekcije_status, carina_status, termin_preuzimanja, špedicija_status) VALUES
(1, 1, 150.00, 'HRK', TRUE, TRUE, '2023-06-12 08:00:00+01', TRUE),
(2, 2, 200.00, 'EUR', FALSE, TRUE, '2023-06-26 08:00:00+01', FALSE),
(3, 3, 180.00, 'HRK', TRUE, TRUE, '2023-07-12 08:00:00+01', TRUE),
(4, 4, 220.00, 'EUR', TRUE, FALSE, '2023-07-26 08:00:00+01', TRUE),
(5, 5, 250.00, 'USD', FALSE, TRUE, '2024-02-01 08:00:00+01', TRUE),
(6, 6, 200.00, 'SGD', TRUE, TRUE, '2024-03-02 08:00:00+01', FALSE),
(7, 7, 210.00, 'CNY', FALSE, TRUE, '2024-04-05 08:00:00+01', TRUE),
(8, 8, 190.00, 'EUR', TRUE, FALSE, '2024-05-01 08:00:00+01', TRUE),
(9, 9, 230.00, 'USD', TRUE, TRUE, '2024-06-10 08:00:00+01', FALSE),
(10, 1, 150.00, 'HRK', TRUE, TRUE, '2023-07-11 08:00:00+01', TRUE),
(11, 2, 200.00, 'EUR', FALSE, TRUE, '2023-08-01 08:00:00+01', FALSE),
(12, 3, 180.00, 'USD', TRUE, FALSE, '2024-01-05 08:00:00+01', TRUE),
(10, 4, 220.00, 'SGD', FALSE, TRUE, '2024-02-10 08:00:00+01', TRUE);


