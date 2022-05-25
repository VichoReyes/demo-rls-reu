# Demo Web

correr con `docker-compose up`

## Ejemplos simples

Primero, listar todos los usuarios:

```
http :3000/users
```

Después, listar todos los perfiles

```
http :3000/user_profiles
```

Ooh, hay uno menos. Será por el is_private?

## Logins

Los tokens son

```
ALICE=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoid2ViX2xvZ2dlZCIsInVzZXJfaWQiOjF9.Pr7zpvTcS2hCFJoHRHyONV4WSQDJjvhYrnNGyL5puFk
BOB=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoid2ViX2xvZ2dlZCIsInVzZXJfaWQiOjJ9.Cqx1GtF95pxqkyRj8Tb7Sf-hiE4085_UBDdJ-y-PqXM
CHARLIE=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoid2ViX2xvZ2dlZCIsInVzZXJfaWQiOjN9.QKe146iF0FC5sfr6HXG4Qsau7CAowjoJNj1Z-DTcz6M
```

Loguiémonos como Charlie y listemos los perfiles, para ver si algo cambia

```bash
http :3000/user_profiles "Authorization:Bearer $ALICE"
http :3000/user_profiles "Authorization:Bearer $CHARLIE"
```

## Editar cosas

```bash
# Alice puede cambiar su descripción
http PATCH ":3000/user_profiles?users_id=eq.1" "Authorization:Bearer $ALICE" "descrip=Nueva descripción para Alice"

# Pero no puede cambiar la de Bob
http PATCH ":3000/user_profiles?users_id=eq.2" "Authorization:Bearer $ALICE" "descrip=Nueva descripción para Bob"

# ni puede poner garabatos en la suya
http PATCH ":3000/user_profiles?users_id=eq.1" "Authorization:Bearer $ALICE" "descrip=Soy Alice, recorcholis"
```

# Muy bonito todo, pero quiero usar postgres directamente

La verdad no estoy muy seguro de cuál es la forma "segura" de hacer esto. Porque "hackear" los intentos simples es muy básico:

```
$ docker-compose exec db psql -U postgres

-- esto funciona bien!
set role web_anon;
select * from user_profiles; 

-- esto funciona, pero no debería poder meterme a un rol más poderoso
set role postgres;

-- muestra el mismo resultado que web_anon, supongo que porque el POLICY que falla se toma como falso
set role web_logged;
select * from user_profiles;
-- no sé cómo poner un user_id donde lo pone postgrest

```

