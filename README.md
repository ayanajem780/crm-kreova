# CRM kréova

CRM interne de kréova : tableau de bord, contacts, pipeline de deals, tâches, emploi du temps de l'équipe et analytics. Interface en français, montants en MAD.

- **Site** : un seul fichier `index.html` (aucune installation, aucun build).
- **Données** : base Supabase (gratuite), partagée en direct entre les membres de l'équipe.
- **Accès** : chaque membre se connecte avec un e-mail et un mot de passe créés par l'administratrice.

Tant que `config.js` n'est pas rempli, le site s'ouvre en **mode démonstration** (exemples non enregistrés).

## Mise en route

### 1. Créer la base Supabase
1. Aller sur https://supabase.com, créer un compte, puis **New project** (nom : `crm-kreova`, région : Europe).
2. Menu **SQL Editor** → **New query** → coller tout le contenu du fichier `supabase.sql` → **Run**.

### 2. Fermer les inscriptions (important)
Menu **Authentication** → **Sign In / Providers** → désactiver **Allow new users to sign up** → enregistrer.
Sans cela, n'importe qui pourrait se créer un compte et lire vos contacts.

### 3. Créer les comptes de l'équipe
Menu **Authentication** → **Users** → **Add user** → **Create new user** : e-mail + mot de passe, cocher **Auto Confirm User**. Répéter pour chaque membre.

### 4. Relier le site à la base
Menu **Project Settings** → **API** : copier **Project URL** et la clé **publishable**.
Dans `config.js`, remplacer `COLLEZ_ICI_PROJECT_URL` par l'URL et `COLLEZ_ICI_CLE_ANON_PUBLIC` par la clé (déjà fait pour le projet kréova).
Ne jamais utiliser une clé `secret` ou `service_role`.

### 5. Mettre en ligne sur Vercel
Sur https://vercel.com : **Add New** → **Project** → importer le dépôt `crm-kreova` → **Deploy** (aucun réglage à changer).

## Modifier le CRM
Les listes (étapes du pipeline, services, sources, horaires de l'emploi du temps) sont en haut du script dans `index.html`, section « Référentiels ».
