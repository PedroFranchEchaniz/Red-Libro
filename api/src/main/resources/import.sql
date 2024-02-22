INSERT INTO user_model (account_non_expired, account_non_locked, credentials_non_expired, enabled, uuid, password, username) VALUES (true, true, true, true, 'c4e27173-52b5-4bd9-94ee-88a07167fa72', '{bcrypt}$2b$12$FV5uUswMRP9NMgZGDeMm6ejlQ37SIAe6biliXr5Dc1dEL4sQLB6Yq', 'username');
INSERT INTO Client (name, last_name, uuid) values ('Paco', 'Fernadez', 'c4e27173-52b5-4bd9-94ee-88a07167fa72');
INSERT INTO user_model_roles(user_model_uuid, roles) values ('c4e27173-52b5-4bd9-94ee-88a07167fa72', 1);

INSERT INTO book (isbn, titulo, autor, editorial, portada) VALUES ('1234567890', 'El Señor de los Anillos', 'J.R.R. Tolkien', 'Minotauro', 'https://m.media-amazon.com/images/I/91CZONTFNgL._SY342_.jpg');
INSERT INTO book_genres (book_isbn, genres) VALUES ('1234567890', 1);

INSERT INTO user_model (account_non_expired, account_non_locked, credentials_non_expired, enabled, uuid, password, username) VALUES (true, true, true, true, '3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '{bcrypt}$2b$12$FV5uUswMRP9NMgZGDeMm6ejlQ37SIAe6biliXr5Dc1dEL4sQLB6Yq', 'shop');
INSERT INTO shop (uuid, name, direccion, contacto, lat, lon) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', 'Librería Gandalf', 'Calle Falsa 123', '+34 123 456 789', '40.416775', '-3.703790');
INSERT INTO user_model_roles(user_model_uuid, roles) values ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', 0);
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '1234567890', 10, 22, '2024-02-21');

INSERT INTO shelving (user_uuid, book_isbn) VALUES ('c4e27173-52b5-4bd9-94ee-88a07167fa72', '1234567890')