create role authenticator noinherit login password 'password';

create role web_anon nologin;
grant web_anon to authenticator;

create role web_logged nologin;
grant web_logged to authenticator;


create table organizations (
    id integer primary key generated always as identity,
    org_name text unique not null,
    members_need_admin boolean not null default false
);

create table users (
    id integer primary key generated always as identity,
    username text unique not null
);

create table user_org (
    id integer primary key generated always as identity,
    organization_id int references organizations(id),
    user_id int references users(id),
    is_admin boolean not null default false
);

create table repositories (
    id integer primary key generated always as identity,
    organization_id int references organizations(id),
    repo_name text not null,
    unique (organization_id, repo_name)
);

grant usage on schema public to web_anon;
grant usage on schema public to web_logged;

create table repositories (
    id integer primary key generated always as identity,
    organization_id int references organizations(id),
    repo_name text not null,
    unique (organization_id, repo_name)
);

create table documents (
    id serial,
    contents text
);

create table document_relation (
    relation_name text, -- "owner", "editor" o "viewer"
    document_id foreign key references documents(id),
    user_id foreign key references users(id)
);
