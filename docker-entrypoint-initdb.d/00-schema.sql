create role authenticator noinherit login password 'password';

create role web_anon nologin;
grant web_anon to authenticator;

create role web_logged nologin;
grant web_logged to authenticator;


create table users (
    id integer primary key generated always as identity,
    username text unique not null
);

create table user_profiles (
    users_id integer references users(id),
    pic_url text,
    descrip text not null default '',
    is_private boolean
);

create view claims as select current_setting('request.jwt.claims');

