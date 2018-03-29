# Implémentation en Ada de l'algorithme DES

Implémentation en Ada de l'algorithme de chiffrement symétrique DES (Data
Encryption Standard). Cette méthode étant lente et la clef de petite
taille, son utilisation n'est plus recommandée aujourd'hui.

Cette application est un **projet universitaire** ayant pour but de
permettre l'apprentissage du langage Ada; de développer une version
parallèle de l'algorithme DES; et pour finir (optionnel) de porter cette
implémentation dans un environnement temps-réel. Le choix de l'algorithme
DES n'est qu'un prétexte pour réaliser ces objectifs lors d'un projet
concret.

Durant tout le projet, chaque composant est vérifié grâce à une batterie
des tests unitaires avec l'outil **AUnit**. Une documentation programmeur
est également rédigée pour chacun et peut être générée avec l'outil
**gnatdoc**.

# Objectifs

## Apprentissage du langage Ada

Le premier objectif du projet est de se familiariser avec le langage.
L'algorithme DES étant une méthode de chiffrement par bloc, il nécessite
de manipuler directement les bits des dit blocs et donc de comprendre
comment modéliser des manipulations de bas niveau en Ada. L'application
nécessite également un travail de conception à haut niveau en utilisant la
méthode objet. Des tests unitaires de chaque partie de l'application ont
été systématiquement réalisés tout au long du développement.

Chaque partie de l'application est modélisée de manière à être la plus
indépendante possible des autres.

Les manipulations bas niveau, ainsi que Le passage d'un bloc de bits vers
une version facilement manipulable (et inversement), sont réalisées grâce
à des clauses de représentations permettant de modifier et consulter
facilement chaque bit des blocs manipulé tout en permettant de ne pas
avoir à employer de masque binaire.

La premiere version séquentiel est indiqué par (tag:
fin\_version\_sequentiel)

## Version parallèle

Le second objectif est de réaliser une version parallèle utilisant le
design pattern **Pipeline** par le biais de tâches (présente en standard
dans le langage). Afin de modéliser la chaine d'étages (ou cycles) on
utilisera une tâche par étage. La communication et la transmission de
données entre les tâches sera assuré à l'aide de rendez-vous chacune ne
pouvant contacter que le cycle suivant. Ainsi pendant qu'un bloc est
transformé par une tâche à un cycle particulier, un autre bloc peut en
même temps être transformé par une autre tâche à un autre cycle. Cette
organisation permet en théorie de maximiser l'utilisation des ressources
matériel de la machine en faisant travailler simultanément plusieurs cœurs
sur des données différentes.

Dans la première version parallèle (tag: v1\_version\_taches) les blocs
étaient passés un par un aux tâches, chacune ne traitait qu'un seul bloc
à la fois la rendant plus lente que la version séquentielle précédemment
développée. La cause en revenait à une charge de travail par tâche
insuffisante, ce qui avait pour conséquence que le temps de communication
entre deux tâches était plus long que le temps de transformation du bloc
par la dite tâche. Celles-ci passaient donc plus de temps à attendre ou
communiquer entre elles qu'à travailler. La solution choisie pour
améliorer les performances a été de ne plus traiter les blocs un par un,
mais en grappe.

Dans la deuxième version (tag: v2\_version\_taches) les blocs sont passés
en grappe. Ainsi chaque tâche reste liée à un cycle, mais lors de la
communication avec une autre tâche elle ne reçoit pas qu'un bloc, mais un
ensemble de blocs. Le temps de communication entre les tâches devient
ainsi moins long que le temps de traitement et l'application gagne en
performance. La grappe est entièrement traitée avant d'être envoyée à la
tâche suivante. Cette version utilise des grappes de 512 blocs et est
environ deux fois plus rapide que la version séquentielle.

Une troisième version (tag: v3\_version\_taches) s'est vue ajouter un
limiteur afin de contrôler le nombre de grappes de blocs présentes en même
temps dans le pipeline. Le but est d'éviter l'engorgement des cœurs du
processeur en les faisant trop souvent changer de contexte. L'amélioration
des temps d'exécution est bien moins impressionnante que pour la
précédente amélioration, mais il est sensible.

## Version temps-réel

Cette version est implémentée en utilisant le profil **Ravenscar**. (tag:
v1\_version\_ravenscar)

Aucune communication directe n'est autorisée entre deux tâches; un objet
protégé ne doit pas avoir plus d'une entrée maximum; deux tâches ne
peuvent communiquer qu'au travers d'un ou plusieurs objets protégés.
Afin de transmettre les données et de contrôler les tâches, il a fallu en
construire un certain nombre.

Pour que deux tâches puissent se communiquer les blocs de bits, il faut
deux objets protégés :
* un premier va interdire que la donnée soit écrite tant qu'elle n'a pas
  été récupérée par la tâche suivante et ce afin d'éviter que la grappe de
  blocs ne soit modifiée alors que la précédente n'a même pas été
  récupérée par la tâche suivante;
* un second objet protégé va, lui, interdire à la tâche suivante de lire
  la donnée tant qu'elle n'a pas été écrite par la tâche précédente. On
  cherche ici a éviter que la tâche suivante ne récupère deux fois la même
  grappe de blocs.

Il a également fallu mettre au point un signal pour savoir si le bloc
transmis est le dernier ou non. C'est l'objet protégé par lequel transit
le bloc qui s'en charge à l'aide d'un booléen (directement inclut dans la
donnée pour la version corrigée).

Les filtres utilisés par les tâches doivent pouvoir être modifiés, ils
sont donc transmis à celle-ci par un objet protégé. Cet objet est lu juste
après avoir reçu le signal de démarrage.

Pour lire et écrire dans les fichiers la tâche de lecture et la tâche
d'écriture passent aussi chacune par un objet protégé. Le nom du fichier
à manipuler est donné à l'objet avant le démarrage du chiffrement, c'est
lui qui s'occupe de toute la gestion du fichier. Afin de permettre de
réaliser les tests unitaires plus facilement ces deux objets peuvent être
remplacé par un générateur et un receveur afin de ne pas avoir à manipuler
de fichiers.

Pour signaler aux tâches de commencer le chiffrement ou pour que la
dernière tâche puisse signaler que le chiffrement est fini, on utilise
deux autres objets protégés, un pour le démarreur et l'autre pour le
signal de fin.

Enfin deux derniers objets sont dévolus à mettre totalement fin à toutes
les tâches en cours et à faire attendre les tâches une fois leur travail
fini avant d'éventuellement relancer le chiffrement d'un autre jeu de
données. Les tâches vérifient l'objet d'avortement seulement après avoir
reçu le signal de démarrage, ce qui implique que les tâches ne peuvent pas
être stoppées en pleins milieu du traitement d'un jeu de données. L'objet
destiné à faire attendre les tâches, le temps qu'elles aient toutes fini,
est là pour empêcher une tâche précoce de repasser la barrière du
démarreur avant sa fermeture.

Une grosse correction (tag: v2\_version\_ravenscar) d'un possible blocage
à cause de contrôle mal placé. La terminaison était mal placé et pouvait
considérer que l'avant dernière grappe de bloc était la dernière. La
valeur de la terminaison est maintenant stockée dans une variable au
moment où la donnée est lue pour éviter de lire la valeur de terminaison
de la grappe suivante.

(tag: v3\_version\_ravenscar) La grappe de blocs est désormais incluse
dans un objet qui contient également un booléen indiquant si cette grappe
est la dernière à traiter. Le signal de terminaison étant désormais
transmis avec la donnée il ne devrait plus y avoir de problèmes de
confusion.

# Compilation et exécution

Les commandes de manipulation basique pour compiler les tests unitaires ou
le projet en lui-même. La plupart des manipulations sont faites via des
makefiles.

Une description de la structure du projet.

```sh
.
├── README.md
├── application/
│   ├── build.gpr                   # La configuration du projet
│   ├── genererChaineAleatoire.sh   # Générateur de fichier dont la taille
│   │                               # est un multiple de 64 bits.
│   ├── makefile
│   ├── makefile.checks     # Vérifications des variables de la configuration
│   ├── makefile.conf       # Configuration spécifique au projet.
│   ├── makefile.template   # Des cibles commune utilisés par tous les
│   │                       # makefile
│   ├── src/        # Les sources de l'application
│   └── test.txt    # Un fichier de tests
├── makefile
├── makefile.conf   # Configuration des variables pour les tests unitaires
├── tests/          # Les sources des tests unitaires
└── unitaire.gpr    # La configuration des tests unitaires du projet
```

## Tests unitaires

### Compilation

La compilation des tests unitaires se fait à la racine du projet en tapant :

```sh
make
```

### Exécution

Le lancement des tests unitaires :

```sh
make run
```

ou

```sh
./bin/test_unitaire_executable
```

## Application

### Compilation

La compilation de l'application se fait dans le dossier **application** :

```sh
cd ./application
make
```

Par défaut la compilation se fait en mode _debug_, pour compiler en
_release_ il faut modifier la variable `ACTIVER_DEBUG` à _false_ dans le
fichier `./application/makefile.conf`. Désactiver le _debug_ va activer
l'optimisation à la compilation avec l'option `-O3`. La version optimisé
est environ 2 fois plus rapide que la version _debug_.

### Exécution

L'application possède 3 programmes principaux, un pour chaque objectif :
* Une version séquentielle : `executable_sequentiel`;
* Une version parallèle : `executable_taches`;
* Une version Ravenscar : `executable_ravenscar`.

Par défaut `make run` exécute la version séquentiel.

Chaque client accepte un certain nombre d'options :

```man
executable [-c|-d|--crypter|--decrypter] <nom_fichier> <clef>

-c --crypter    Chiffre le fichier avec la clef
-d --decrypter    Déchiffre le fichier avec la clef
```

Lors de l'exécution du chiffrement, le résultat est écrit dans un autre
fichier et pas à la place du fichier original.

Vous pouvez facilement comparer les temps d'exécutions des 3 versions,
pour une même opération sur un même fichier avec la même clef. Dans
`application/makefile.conf` modifiez la variable `VARNOMFICHIER` et
indiquez le fichier que vous voulez chiffrer. Ensuite exécutez :

```sh
make crypt
# ou
make decrypt
# ou encore les deux à la suite
make crypt decrypt
```

Attention `make decrypt` se base sur la version chiffré de votre fichier
vous devrez lancer `make crypt` avant.

Vous pourrez voir apparaitre 6 fichiers supplémentaires qui contiendront
soit :
* la version chiffré de votre fichier original;
* la version déchiffré de la version chiffré de votre version original.

Pour chacun de ces deux cas, il y a 3 fichiers :
* 1 pour la version séquentiel;
* 1 pour la version tâches;
* 1 pour la version Ravenscar.

Pour les comparer rapidement tapez :

```sh
make fichier_comparer
```

Cette commande va lancer la comparaison de votre fichier original avec le
résultat du déchiffrement effectué par :
* la version séquentiel;
* la version tâches;
* la version Ravenscar.

Les versions chiffrés seront également comparé entre elles pour montrer que
chacun des algorithmes, pour un même fichier avec une même clef, donnent
bien le même résultat chiffré.

#### Exemples d'utilisations

``` sh
# Chiffrement

./bin/[debug|release]/executable_sequentiel --crypter <nom_fichier> <clef>
./bin/[debug|release]/executable_taches --crypter <nom_fichier> <clef>
./bin/[debug|release]/executable_ravenscar --crypter <nom_fichier> <clef>

# Déchiffrement

./bin/[debug|release]/executable_sequentiel --decrypter <nom_fichier> <clef>
./bin/[debug|release]/executable_taches --decrypter <nom_fichier> <clef>
./bin/[debug|release]/executable_ravenscar --decrypter <nom_fichier> <clef>
```

# Temps d'exécution

Des résultats concret de temps d'exécutions de l'application exécuté sur
différents processeurs, pour donner une idée des performances de
l'application.
* OS : GNU/linux avec CPU : Intel Pentium P6000; 1.87GHz; 2 core;
  1 thread/core
* OS : MacOS avec CPU : Intel Core i5; 2,7GHz; 2 core; 2 thread/core

Pour générer le fichier de 1,8 Mo qui a été utilisé pour les tests, tapez
la commande

```
./application/genererChaineAleatoire.sh -f autre.test -r 20
```

#### Version Débogue

Résultat de la version _debug_ avec un fichier de 1,8 Mo

```sh
# Version intel pentium
───────────────────────────────
Chiffrement
./bin/debug/executable_sequentiel --crypter autre.test lovecrft

Temps séquentiel :
         24.679975561 s

./bin/debug/executable_taches --crypter autre.test lovecrft

Temps parallèle :
         15.107683892 s

./bin/debug/executable_ravenscar --crypter autre.test lovecrft

Temps ravenscar :
         11.760052344 s


Déchiffrement
./bin/debug/executable_sequentiel --decrypter autre.test.sequ.crypt lovecrft

Temps séquentiel :
         24.803278867 s

./bin/debug/executable_taches --decrypter autre.test.task.crypt lovecrft

Temps parallèle :
         15.131196912 s

./bin/debug/executable_ravenscar --decrypter autre.test.rave.crypt lovecrft

Temps ravenscar :
         11.784276361 s


# Version intel core i5
───────────────────────────────
Chiffrement
./bin/debug/executable_sequentiel --crypter autre.test lovecrft

Temps séquentiel :
         13.273618000 s

./bin/debug/executable_taches --crypter autre.test lovecrft

Temps parallèle :
          5.981384000 s

./bin/debug/executable_ravenscar --crypter autre.test lovecrft

Temps ravenscar :
          5.647463000 s


Déchiffrement
./bin/debug/executable_sequentiel --decrypter autre.test.sequ.crypt lovecrft

Temps séquentiel :
         13.187634000 s

./bin/debug/executable_taches --decrypter autre.test.task.crypt lovecrft

Temps parallèle :
          6.254259000 s

./bin/debug/executable_ravenscar --decrypter autre.test.rave.crypt lovecrft

Temps ravenscar :
          5.751005000 s
```

#### Version optimisé

Résultat de la version optimisé (option -O3 lors de la compilation) avec
un fichier de 1,8 Mo

```sh
# Version intel pentium
───────────────────────────────
Chiffrement
./bin/release/executable_sequentiel --crypter autre.test lovecrft

Temps séquentiel :
         10.815002487 s

./bin/release/executable_taches --crypter autre.test lovecrft

Temps parallèle :
          6.368551113 s

./bin/release/executable_ravenscar --crypter autre.test lovecrft

Temps ravenscar :
          5.131816230 s


Déchiffrement
./bin/release/executable_sequentiel --decrypter autre.test.sequ.crypt lovecrft

Temps séquentiel :
         10.584909492 s

./bin/release/executable_taches --decrypter autre.test.task.crypt lovecrft

Temps parallèle :
          6.502066890 s

./bin/release/executable_ravenscar --decrypter autre.test.rave.crypt lovecrft

Temps ravenscar :
          4.958255953 s

# Version intel core i5
───────────────────────────────
Chiffrement
./bin/release/executable_sequentiel --crypter autre.test lovecrft

Temps séquentiel :
          7.852298000 s

./bin/release/executable_taches --crypter autre.test lovecrft

Temps parallèle :
          3.472909000 s

./bin/release/executable_ravenscar --crypter autre.test lovecrft

Temps ravenscar :
          3.131888000 s


Déchiffrement
./bin/release/executable_sequentiel --decrypter autre.test.sequ.crypt lovecrft

Temps séquentiel :
          7.623947000 s

./bin/release/executable_taches --decrypter autre.test.task.crypt lovecrft

Temps parallèle :
          3.493629000 s

./bin/release/executable_ravenscar --decrypter autre.test.rave.crypt lovecrft

Temps ravenscar :
          3.244890000 s
```
