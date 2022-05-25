grant all on repositories to web_logged;
grant all on user_org to web_logged;
grant all on organizations to web_logged;

alter table repositories enable row level security;
-- alter table user_org enable row level security;
alter table organizations enable row level security;

create policy org_repo_policy on repositories
    using
    (cast(current_setting('request.jwt.claims', true)::json->>'user_id' as integer)
        in
    (select user_org.user_id 
        from
            user_org,
            organizations orgs
        where
            -- repo belongs to organization
            orgs.id = repositories.id
        and 
            -- user is admin
            (user_org.is_admin
            or
            -- org doesn't require admin privileges to see repos
            orgs.members_need_admin = false)));

create policy visible_orgs on organizations
    using
    (cast(current_setting('request.jwt.claims', true)::json->>'user_id' as integer)
        in
    (select user_org.user_id
        from
            user_org
        where
            organizations.id = user_org.organization_id));
