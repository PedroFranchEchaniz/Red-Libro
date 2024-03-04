INSERT INTO user_model (account_non_expired, account_non_locked, credentials_non_expired, enabled, uuid, password, username) VALUES (true, true, true, true, 'c4e27173-52b5-4bd9-94ee-88a07167fa72', '{bcrypt}$2b$12$FV5uUswMRP9NMgZGDeMm6ejlQ37SIAe6biliXr5Dc1dEL4sQLB6Yq', 'username');
INSERT INTO Client (name, last_name, uuid) values ('Paco', 'Fernadez', 'c4e27173-52b5-4bd9-94ee-88a07167fa72');
INSERT INTO user_model_roles(user_model_uuid, roles) values ('c4e27173-52b5-4bd9-94ee-88a07167fa72', 1);

INSERT INTO user_model (account_non_expired, account_non_locked, credentials_non_expired, enabled, uuid, password, username) VALUES (true, true, true, true, 'c4e27173-52b5-4bd9-94ee-88a07167fa71', '{bcrypt}$2b$12$FV5uUswMRP9NMgZGDeMm6ejlQ37SIAe6biliXr5Dc1dEL4sQLB6Yq', 'username2');
INSERT INTO Client (name, last_name, uuid) values ('Paco', 'Fernadez', 'c4e27173-52b5-4bd9-94ee-88a07167fa71');
INSERT INTO user_model_roles(user_model_uuid, roles) values ('c4e27173-52b5-4bd9-94ee-88a07167fa71', 1);

INSERT INTO book (isbn, titulo, autor, editorial, portada, fecha, fecha_alta, resumen, media_valoracion, disponible) VALUES ('1234567890', 'El Señor de los Anillos', 'J.R.R. Tolkien', 'Minotauro', 'https://m.media-amazon.com/images/I/91CZONTFNgL._SY342_.jpg', '1891-06-2', '2023-01-19', 'En la conclusión épica de "El Señor de los Anillos", Frodo y Sam, guiados por Gollum, continúan su peligrosa misión hacia el Monte del Destino para destruir el Anillo Único. Mientras, Aragorn lidera a los Pueblos Libres en la batalla final contra las fuerzas de Sauron en Minas Tirith. Es una lucha desesperada por la libertad y la esperanza, con el destino de la Tierra Media en la balanza. J.R.R. Tolkien cierra su obra maestra con heroísmo, sacrificio y la promesa de paz tras la oscuridad.', 5, true);
INSERT INTO book_genres (book_isbn, genres) VALUES ('1234567890', 0);

INSERT INTO book (isbn, titulo, autor, editorial, portada, fecha, fecha_alta, resumen, media_valoracion, disponible) VALUES ('1234567891', 'Guia del autoestopista intergalactico', 'Douglas Adams', 'Anagrama', 'https://quelibroleo.com/images/libros/libro_1384705967.jpg', '1999-06-2', '2024-02-22', 'Descripción del libro Guia del autoestopista intergalactico', 5, true);
INSERT INTO book_genres (book_isbn, genres) VALUES ('1234567891', 4);

INSERT INTO book (isbn, titulo, autor, editorial, portada, fecha, fecha_alta, resumen, media_valoracion, disponible) VALUES ('9780307474728', 'Cien anios de soledad', 'Gabriel García Márquez', 'Vintage Español', 'URL_GENÉRICA_DE_PORTADA', '1967-06-05', '2024-02-23', 'Descripción del libro Cien anios de soledad', 0, true);
INSERT INTO book_genres (book_isbn, genres) VALUES ('9780307474728', 0);

INSERT INTO book (isbn, titulo, autor, editorial, portada, fecha, fecha_alta, resumen, media_valoracion, disponible) VALUES ('9781503290563', 'Orgullo y prejuicio', 'Jane Austen', 'CreateSpace Independent Publishing Platform', 'URL_GENÉRICA_DE_PORTADA', '1813-01-28', '2024-02-23', 'Descripción del libro Orgullo y prejuicio', 0, true);
INSERT INTO book_genres (book_isbn, genres) VALUES ('9781503290563', 1);

INSERT INTO book (isbn, titulo, autor, editorial, portada, fecha, fecha_alta, resumen, media_valoracion, disponible) VALUES ('9780060935467', 'Matar a un ruisenioor', 'Harper Lee', 'Harper Perennial Modern Classics', 'URL_GENÉRICA_DE_PORTADA', '1960-07-11', '2024-02-23', 'Descripción del libro Matar a un ruisenioor', 0, true);
INSERT INTO book_genres (book_isbn, genres) VALUES ('9780060935467', 2);

INSERT INTO book (isbn, titulo, autor, editorial, portada, fecha, fecha_alta, resumen,media_valoracion, disponible) VALUES ('9783333333333', 'El Enigma de la Esfinge', 'Sarah Stone', 'Aventuras Eternas', 'URL_GENÉRICA_DE_PORTADA', '2024-02-28', '2024-02-28', 'Descubre los misterios que esconde la antigua esfinge a través de los ojos de nuestra heroína, en una aventura que combina historia, mitología y suspense.', 0, false);
INSERT INTO book_genres (book_isbn, genres) VALUES ('9783333333333', 1);


INSERT INTO user_model (account_non_expired, account_non_locked, credentials_non_expired, enabled, uuid, password, username) VALUES (true, true, true, true, '3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '{bcrypt}$2b$12$FV5uUswMRP9NMgZGDeMm6ejlQ37SIAe6biliXr5Dc1dEL4sQLB6Yq', 'shop');
INSERT INTO shop (uuid, name, direccion, contacto, lat, lon) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', 'Librería Gandalf', 'Calle Falsa 123', '+34 123 456 789', '40.416775', '-3.703790');
INSERT INTO user_model_roles(user_model_uuid, roles) values ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', 0);
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '1234567890', 10, 22, '2024-02-21');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '1234567891', 5, 20, '2024-02-22');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '9780307474728', 8, 18, '2024-02-23');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '9781503290563', 7, 15, '2024-02-24');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '9780060935467', 6, 12, '2024-02-25');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '9783333333333', 15, 25, '2024-02-28');


INSERT INTO user_model (account_non_expired, account_non_locked, credentials_non_expired, enabled, uuid, password, username) VALUES (true, true, true, true, '3fff85ce-354b-4e4c-bbc3-7ce138e573b7', '{bcrypt}$2b$12$FV5uUswMRP9NMgZGDeMm6ejlQ37SIAe6biliXr5Dc1dEL4sQLB6Yq', 'shop2');
INSERT INTO shop (uuid, name, direccion, contacto, lat, lon) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b7', 'Librería Gandalf', 'Calle Falsa 123', '+34 123 456 789', '40.416100', '-3.703790');
INSERT INTO user_model_roles(user_model_uuid, roles) values ('3fff85ce-354b-4e4c-bbc3-7ce138e573b7', 0);
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b7', '1234567890', 10, 22, '2024-02-21');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b7', '1234567891', 5, 20, '2024-02-22');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b7', '9780307474728', 8, 18, '2024-02-23');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b7', '9781503290563', 7, 15, '2024-02-24');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b7', '9780060935467', 6, 12, '2024-02-25');
INSERT INTO store (shop_uuid, book_isbn, stock, precio, date_registe) VALUES ('3fff85ce-354b-4e4c-bbc3-7ce138e573b7', '9783333333333', 15, 25, '2024-02-28');

INSERT INTO shelving (user_uuid, book_isbn) VALUES ('c4e27173-52b5-4bd9-94ee-88a07167fa72', '1234567890');

INSERT INTO rating (stars, book_isbn, client_uuid, opinion) VALUES (5, '1234567890', 'c4e27173-52b5-4bd9-94ee-88a07167fa71', 'Esta genial');
INSERT INTO rating (stars, book_isbn, client_uuid, opinion) VALUES (4, '1234567890', 'c4e27173-52b5-4bd9-94ee-88a07167fa72', 'Lo mejor que he leido');
INSERT INTO rating (stars, book_isbn, client_uuid, opinion) VALUES (5, '9783333333333', 'c4e27173-52b5-4bd9-94ee-88a07167fa72', 'Lo volvería a comprar');

INSERT INTO booking (uuid, client_uuid, booking_code, lat, lon, shop_uuid, fecha_reserva, fecha_expiacion, book_isbn) VALUES ('eae35383-4d00-4a98-8e38-b7c896be48e0', 'c4e27173-52b5-4bd9-94ee-88a07167fa72', 'fa40752a-db5c-4b4c-ae33-ad46c87df0cd', '40.416775', '-3.703790', '3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '2024-03-01', '2024-03-15', '1234567890');
INSERT INTO booking (uuid, client_uuid, booking_code, lat, lon, shop_uuid, fecha_reserva, fecha_expiacion, book_isbn) VALUES ('b35cfe4a-e4f5-4dc5-b6cb-c6f6fe05b050', 'c4e27173-52b5-4bd9-94ee-88a07167fa72', 'd3f7b829-f7b2-484e-8c86-2026f480b2ab', '40.416775', '-3.703790', '3fff85ce-354b-4e4c-bbc3-7ce138e573b6', '2024-03-01', '2024-03-15', '1234567891');