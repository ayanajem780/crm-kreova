-- CRM kréova : à coller une seule fois dans Supabase > SQL Editor, puis "Run".

create table if not exists public.crm_items (
  id   text primary key default gen_random_uuid()::text,
  col  text not null check (col in ('contacts','deals','taches','equipe','planning')),
  data jsonb not null default '{}'::jsonb,
  maj  timestamptz not null default now()
);

create index if not exists crm_items_col_idx on public.crm_items (col);

-- Seules les personnes connectées (comptes créés par vous) peuvent lire et modifier.
alter table public.crm_items enable row level security;
revoke all on public.crm_items from anon;
grant select, insert, update, delete on public.crm_items to authenticated;

drop policy if exists "equipe_lecture" on public.crm_items;
drop policy if exists "equipe_ajout" on public.crm_items;
drop policy if exists "equipe_modification" on public.crm_items;
drop policy if exists "equipe_suppression" on public.crm_items;

create policy "equipe_lecture"      on public.crm_items for select to authenticated using (true);
create policy "equipe_ajout"        on public.crm_items for insert to authenticated with check (true);
create policy "equipe_modification" on public.crm_items for update to authenticated using (true) with check (true);
create policy "equipe_suppression"  on public.crm_items for delete to authenticated using (true);

-- Mise à jour en direct entre les membres de l'équipe.
do $$ begin
  alter publication supabase_realtime add table public.crm_items;
exception when duplicate_object then null; end $$;
