-- Populate the table
INSERT INTO users (username) VALUES
    ('Alice'),
    ('Bob'),
    ('Charlie');

INSERT INTO user_profiles (users_id, pic_url, descrip, is_private) VALUES
    (1, 'alice_pic.jpg', 'hola, soy Alice y esta es mi descripción', false),
    (2, 'bob_pic.jpg', 'hola, soy Bob y esta es mi descripción', false),
    (3, 'charlie.png', 'Charlie, un tipo preocupado de su privacidad, con perfil privado', true);


