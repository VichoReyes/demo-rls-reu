-- Primero permitimos todo en user_profiles
grant SELECT on users to web_logged;
grant all on user_profiles to web_logged;
grant SELECT on users to web_anon;
grant all on user_profiles to web_anon;

grant all on claims to web_logged;
grant all on claims to web_anon;

-- pero después decimos jajaj no era verdad saludos
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- cualquier usuario (e incluso personas no logueadas) puede ver todos los perfiles que no sean privados
CREATE POLICY all_view ON user_profiles FOR SELECT USING (not is_private);
-- cada usuario logueado puede ver y modificar su propio perfil, pero su descripción no puede contener garabatos
CREATE POLICY user_view_mod ON documentos doc FOR UPDATE TO web_logged
  USING (current_user IN (
      SELECT u.nombre_usuario
      FROM usuarios u
      JOIN usuarios_documentos usr_doc ON u.id = usr_doc.id_usuario
      WHERE usr_doc.id_documento = doc.id
    ) OR current_user IN (
      SELECT u.nombre_usuario
      FROM usuarios u
      WHERE doc.dueño = u.id
    ));

GRANT ALL (titulo, contenidos) ON documentos TO usuarios
