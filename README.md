# com_nicodevelop_boilerplate

Projet de base de création d'application avec Flutter

## Installation de l'application

Installation de Flutter Fire CLI.

```bash
dart pub global activate flutterfire_cli

export PATH="$PATH":"$HOME/.pub-cache/bin"

flutterfire configure
```

Remplacer toutes le références de `com_nicodevelop_boilerplate` par votre nom de projet.

Remplacer toutes le références de `com.nicodevelop.boilerplate` par votre nom de package du projet.

## Installation et demarrage du serveur

Créer un fichier `.firebaserc` à la racine du projet du dossier `server` avec le contenu suivant :

```json
{
  "projects": {
    "default": "<project_id>"
  }
}
```

Connecter votre projet à un projet Firebase.

```bash
firebase use --add <project_id>
```

Installer les dépendances.

```bash
cd server/functions

npm i
```

Démarrer le serveur (dans le dossier `server/functions`).

```bash
npm run serve
```

Installation des données de tests

```bash
curl http://localhost:5001/<project_id>/us-central1/createUsers
```

## Informations

Un fichier `constants.dart` est présent dans le dossier `lib/config` pour centraliser les paramètres de l'application.