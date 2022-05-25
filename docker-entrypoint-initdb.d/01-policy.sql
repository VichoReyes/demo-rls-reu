-- Primero permitimos todo en user_profiles
grant SELECT on users to web_logged;
grant all on user_profiles to web_logged;
grant SELECT on users to web_anon;
grant all on user_profiles to web_anon;

-- pero después decimos jajaj no era verdad saludos
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- cualquier usuario (e incluso personas no logueadas) puede ver todos los perfiles que no sean privados
CREATE POLICY all_view ON user_profiles FOR SELECT USING (not is_private);
-- cada usuario logueado puede ver y modificar su propio perfil, pero su descripción no puede contener garabatos
CREATE POLICY user_view_mod ON user_profiles FOR ALL TO web_logged
  USING (cast(current_setting('request.jwt.claims', true)::json->>'user_id' as integer) = users_id)
  WITH CHECK (
    cast(current_setting('request.jwt.claims', true)::json->>'user_id' as integer) = users_id AND
    descrip not ilike '%recorcholis%'
  );

