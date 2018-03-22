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
L'algorithme DES nécessite de manipuler directement les bits des blocs et
donc de comprendre comment modéliser des manipulations de bas niveau en
Ada. L'application nécessite également un travail de conception à haut
niveau en utilisant la méthode objet. Des tests unitaires de chaque partie
de l'application ont été systématiquement réalisés tout au long du
développement.

Chaque partie de l'application est modélisée de manière à être la plus
indépendante possible des autres.

Les manipulations bas niveau sont réalisées grâce à des clauses de
représentations permettant de modifier et consulter facilement chaque bit
des blocs manipulé et a permis de ne pas avoir à employer de masque
binaire. Le passage d'un bloc de bits à une version facilement manipulable
(et inversement) se fait aussi grâce à des clauses de représentations.

## Version parallèle

Le second objectif est de réaliser une version parallèle utilisant le
design pattern **Pipeline** pour modéliser les étages (ou cycles). Le
langage est doté en standard de la notion de tâches permettant le
traitement en parallèle des étages. Chaque tâche peut communiquer avec une
autre par le biais d'un rendez-vous.

Pour réaliser cette version de l'application les étages de la version
séquentielle ont été remplacés par des tâches, chacune étant dédié à un
cycle particulier de l'application et ne peut contacter que le cycle
suivant. Ainsi pendant qu'un bloc est transformé par une tâche à un cycle
particulier, un autre bloc peut en même temps être transformé par une
autre tâche dans un autre cycle. Cette organisation permet en théorie
d'utiliser au maximum les ressources matériel de la machine en travaillant
simultanément sur plusieurs blocs.

Dans la première version parallèle (tag: v1\_version\_taches) les blocs
étaient passés un par un aux tâches, chacune ne traitait donc qu'un seul
bloc à la fois la rendant plus lente que la version séquentielle
précédemment développée. La cause en revenait à une charge de travail par
tâche insuffisante, ce qui avait pour conséquence que le temps de
communication entre deux tâches était plus long que le temps de
transformation du bloc par l'étage. Les tâches passaient donc plus de
temps à attendre qu'à travailler. La solution choisie pour améliorer les
performances a été de ne plus traiter les blocs un par un, mais en grappe.

Dans la deuxième version (tag: v2\_version\_taches) les blocs sont passés
en grappe. Ainsi chaque tâche reste liée à un cycle, mais lors de la
communication avec une autre tâche elle ne reçoit pas qu'un bloc, mais un
ensemble de blocs. Le temps de communication entre les tâches devient
ainsi moins long que le temps de traitement de la grappe. Celle-ci est
entièrement traitée avant d'être envoyée à la tâche suivante. Cette
version utilise des grappes de 512 blocs et est environ deux fois plus
rapide que la version séquentielle.

## Version temps-réel

Cette version est implémentée en utilisant le profil **Ravenscar**.

Aucune communication direct n'est autorisé entre deux tâches; un objet
protégé ne doit pas avoir plus d'une entrée maximum; deux tâches ne
peuvent communiquer qu'au travers d'un ou plusieurs objets protégé.

Il a donc fallu construire un grand nombre d'objets protégé pour permettre
aux tâches de communiquer entre elles. Pour que deux tâches puissent se
communiquer les blocs de bits, il faut deux objets protégé : un premier va
interdire que la donnée soit écrite tant qu'elle n'a pas été récupéré par
la tâche suivante; Un second objet protégé va, lui, interdire à la tâche
suivante de lire la donnée tant qu'elle n'a par été écrite par la tâche
précédente.

Il a également fallu mettre au point un signal pour savoir si le bloc
transmit est le dernier ou non. C'est l'objet protégé par lequel transit
le bloc qui s'en charge à l'aide d'un booléen.

Les filtres utilisé par les tâches doivent pouvoir être modifié, ils sont
donc transmis à la tâche utilisatrice par un objet protégé. Cet objet est
lu juste après avoir reçus le signal de démarrage.

Pour lire et écrire dans les fichiers la tâche de lecture et la tâche
d'écriture passent aussi chacune par un objet protégé. Le nom du fichier
à manipuler est donnée à l'objet avant le démarrage du chiffrement, c'est
lui qui s'occupe de toute la gestion du fichier.

Pour signaler aux tâches de commencer le chiffrement ou pour que la
dernière tâche puisse signaler que le chiffrement est fini, on utilise
deux autres objets protégé, un pour le démarreur et l'autre pour le signal
de fin.

Enfin deux derniers objets sont dévolues à mettre totalement fin à toutes
les tâches en cours et à faire attendre les tâches une fois leur travail
fini avant d éventuellement relancer le chiffrement d'un autre jeu de
données. Les tâches ne vérifie l'objet d'avortement que juste après avoir
reçus le signal de démarrage, ce qui implique que les tâches ne peuvent
pas être stoppé en plein milieux du traitement d'un jeu de données.
L'objet destiné à faire attendre les tâches, le temps qu'elles aient
toutes fini, est là pour empêcher une tâche précoce de repasser la
barrière du démarreur avant qu'elle ne se referme.

# Compilation et exécutions

Les commandes de manipulation basique pour compiler les tests unitaires ou
le projet en lui-même. La plupart des manipulations sont faites via des
makefiles.

Une description de la structure du projet.

```
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
_release_ il faut modifier la variable ACTIVER\_DEBUG à _false_ dans le
fichier `./application/makefile.conf`

### Exécution

L'application possède 3 programmes principaux, un pour chaque objectif :
* Une version séquentielle : `executable_sequentiel`;
* Une version parallèle : `executable_taches`;
* Une version Ravenscar : `executable_ravenscar`.

Chaque client accepte un certain nombre d'options :

```man
executable [-c|-d|--crypter|--decrypter] <nom_fichier> <clef>

-c --crypter    Crypte le fichier avec la clef
-d --decrypter    Décrypte le fichier avec la clef
```

Lors de l'exécution du chiffrement, le résultat est écrit dans un autre
fichier et pas à la place du fichier original.

#### Exemples d'utilisations

``` sh
# Cryptage

./bin/[debug|release]/executable_sequentiel --crypter <nom_fichier> <clef>
./bin/[debug|release]/executable_taches --crypter <nom_fichier> <clef>
./bin/[debug|release]/executable_ravenscar --crypter <nom_fichier> <clef>

# Décryptage

./bin/[debug|release]/executable_sequentiel --decrypter <nom_fichier> <clef>
./bin/[debug|release]/executable_taches --decrypter <nom_fichier> <clef>
./bin/[debug|release]/executable_ravenscar --decrypter <nom_fichier> <clef>
```
