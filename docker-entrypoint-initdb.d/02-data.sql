insert into users (
    username
) values ('vicho');

insert into organizations (
    org_name,
    members_need_admin
) values (
    'nns',
    true
), (
    'dcc',
    false
);

insert into user_org (
    organization_id,
    user_id
) values (
    1,
    1
), (
    2,
    1
);

-- me ascendieron
update user_org
set is_admin = true
where organization_id = 1 and user_id = 1;

insert into repositories (
    organization_id,
    repo_name
) values (
    1,
    'sistema_espionaje'
), (
    2,
    'programa_tranqui'
);
