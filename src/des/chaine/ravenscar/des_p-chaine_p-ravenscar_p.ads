private with Ada.Containers.Indefinite_Holders;

private with Des_P.Chaine_P.Limiteur_Jetons_P;
private with Des_P.Bloc_P.Bloc_64_P;
private with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

private with Des_P.Chaine_P.Lecteur_P;
private with Des_P.Chaine_P.Lecteur_P.Fichier_P;
private with Des_P.Chaine_P.Ecriveur_P;
private with Des_P.Chaine_P.Ecriveur_P.Fichier_P;

private with Des_P.Filtre_P.Corps_P.Holder_P;
private with Des_P.Filtre_P.Entree_P.Holder_P;
private with Des_P.Filtre_P.Sortie_P.Holder_P;

private with Des_P.Chaine_P.Instances_Table_Bloc_P;

pragma Elaborate_All (Des_P.Chaine_P.Limiteur_Jetons_P);

--  @summary
--  Chaine de filtres parallèle.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P.Ravenscar_P
   with Elaborate_Body
is

   type Chaine_T is new Chaine_Interface_T with private;
   --  La chaine de filtres parallèle.

   overriding
   procedure Filtrer
      (
         Chaine      : Chaine_T;
         Nom_Fichier : String;
         Extension   : String
      );
   --  Lance le filtrage du fichier avec la clef. La version chiffré ou
   --  déchiffré est écrite dans un autre fichier avec l'extension chiffre ou
   --  déchiffre selon le filtrage effectué.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Nom_Fichier
   --  Le nom du fichier à chiffrer déchiffrer.
   --  @param Extension
   --  Extension du fichiers de sortie.

   procedure Faire_Avorter;
   --  Met fin à toutes les taches.

private

   package C_Bloc_64_R  renames Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
   package Limiteur_R   renames Des_P.Chaine_P.Limiteur_Jetons_P;
   package Table_Bloc_R renames Instances_Table_Bloc_P.Table_Bloc_Ravenscar_P;

   use type Table_Bloc_R.Table_Bloc_T;
   use type Table_Bloc_R.Indice_T;

   subtype Indice_T     is Table_Bloc_R.Indice_T;
   subtype Table_Bloc_T is Table_Bloc_R.Table_Bloc_T;

   package Table_Holder_P is new
      Ada.Containers.Indefinite_Holders
         (Element_Type => Table_Bloc_R.Table_Bloc_T);
   --  @private
   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate

   type Donnee_T is
      record
         Table                : Table_Holder_P.Holder;
         --  Le tableau des blocs de 64 bits.
         Est_Derniere_Grappe  : Boolean := False;
         --  Indique si on manipule la dernière grappe de données.
      end record;
   --  Une grappe de blocs avec un drapeau pour savoir si
   --  c'est la dernière.

   procedure Filtrer
      (
         Grappe_De_Donnees : in out Donnee_T;
         Procedure_Filtre  : not null access procedure
            (Table_De_Donnees : in out Table_Bloc_R.Table_Bloc_T)
      )
      with Inline;
   --  Applique le filtre aux données, peut les modifier.
   --  @param Grappe_De_Donnees
   --  La donnée à laquelle appliquer le filtre.
   --  @param Procedure_Filtre
   --  Le filtre à appliquer.
   --  @param Table_De_Donnees
   --  Le tableau de données à modifier.

   procedure Appliquer
      (
         Grappe_De_Donnees      : Donnee_T;
         Procedure_A_Appliquer  : not null access procedure
            (Table_De_Donnees : Table_Bloc_R.Table_Bloc_T)
      )
      with Inline;
   --  Applique la procédure aux données sans les modifier.
   --  @param Grappe_De_Donnees
   --  La donnée à laquelle appliquer le filtre.
   --  @param Procedure_A_Appliquer
   --  Le filtre à appliquer.
   --  @param Table_De_Donnees
   --  Le tableau de données à manipuler.

   procedure Ecrire_Table
      (
         Grappe_De_Donnees : in out Donnee_T;
         Table_De_Donnees  : Table_Bloc_R.Table_Bloc_T
      )
      with Inline;
   --  Modifie la table stockée dans la grappe de données.
   --  @param Grappe_De_Donnees
   --  La grappe de données.
   --  @param Table_De_Donnees
   --  La table de données.

   procedure Ecrire_Est_Derniere
      (
         Grappe_De_Donnees : in out Donnee_T;
         Fini              : Boolean
      )
      with Inline;
   --  Signal que la grappe de données est la dernière.
   --  @param Grappe_De_Donnees
   --  La donnée.
   --  @param Fini
   --  La grappe de données est la dernière.

   function Est_Derniere
      (Grappe_De_Donnees : Donnee_T)
      return Boolean
   is (Grappe_De_Donnees.Est_Derniere_Grappe)
      with Inline;
   --  Indique si la grappe de données est la dernière.
   --  @param Grappe_De_Donnees
   --  La grappe de données.
   --  @return La grappe de données est la dernière.

   package Donnee_Holder_P is new
      Ada.Containers.Indefinite_Holders (Element_Type => Donnee_T);
   --  @private
   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate

   ---------------------------------------

   protected Avorter_Protegee is
      procedure Avorter;
      --  Demande aux tâches de mettre fin à leur cycle.
      function Avorter return Boolean;
      --  Communique la demande de mise à off des tâches.
      --  @return Les tâches doivent s'arrêter.
   private
      Arreter_Application : Boolean := False;
      --  Drapeau de fin de programme.
   end Avorter_Protegee;
   --  Signal pour mettre fin à toutes les tâches en cours.
   --  L'instruction abort étant interdite en ravenscar les tâches
   --  ne peuvent être stoppé qu'a un seul moment de l'exécution, lors
   --  de l'envoie du signal du demarreur_protegee.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   type Compteur_Tache_T is range 0 .. 20;
   --  Destiné à compter le nombre de tâches.

   ---------------------------------------
   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   protected Autorisation_Rearmement_Protegee is
      entry Attendre_Entree;
      --  Demande aux tâches d'attendre ici avant de pouvoir
      --  retourner devant la barrière du démarreur protégé.
      procedure Autoriser
         with Inline;
      --  Donne l'autorisation aux tâches de passer la barrière.
   private
      Nb_Tache_Lancee   : Compteur_Tache_T  := Compteur_Tache_T'First;
      --  Compteur du nombre de tâches qui sont passé par la barrière.
      Autoriser_Relance : Boolean           := False;
      --  Drapeau d'autorisation de passage.
   end Autorisation_Rearmement_Protegee;
   --  Bloque les tâches une fois qu'elles ont fini de chiffrer tous les
   --  blocs. Une fois l'autorisation donnée les tâches peuvent se positionner
   --  à nouveau devant la barrière du demarreur_protegee. Le but est ici
   --  de bloquer les tâches pour ne pas qu'elles puissent se relancer
   --  elle-même si l'une d'elle est finie avant que la barrière du
   --  demarreur_protegee ne se referme.

   ---------------------------------------
   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   protected Demarreur_Protegee is
      entry Attendre_Entree;
      --  Barrière de synchronisation du démarrage de tâches.
      procedure Demarrer
         with Inline;
      --  Accorde l'autorisation de démarrer aux tâches en attente.
   private
      Nb_Tache_Lancee    : Compteur_Tache_T   := Compteur_Tache_T'First;
      --  Compteur du nombre de tâches qui ont passé la barrière.
      Demarrage_Autorise : Boolean            := False;
      --  Drapeau d'autorisation de démarrer.
   end Demarreur_Protegee;
   --  Bloque le démarrage des tâches. Tant que le signal de démarrage n'est
   --  pas donné les tâches attendent. Une fois que toutes les tâches on passé
   --  la barrière elle est refermée en attendant le prochain départ.

   ---------------------------------------
   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   protected Fin_Protegee is
      entry Attendre_Entree;
      --  Barrière de synchronisation pour la tâche principal.
      procedure Fini
         with Inline;
      --  Signal que le chiffrement ou le déchiffrement de tous les
      --  blocs est fini.
   private
      Est_Fini : Boolean := False;
      --  Drapeaux de signal de fin de traitement.
   end Fin_Protegee;
   --  Permet de signaler à la procédure appelante que toutes les tâches
   --  ont fini de chiffrer le fichier.

   package Lecteure_R renames Des_P.Chaine_P.Lecteur_P;
   package Ecriveur_R renames Des_P.Chaine_P.Ecriveur_P;

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Ecriveur_Fichier : aliased Ecriveur_R.Fichier_P.Ecriveur_Fichier_T;
   --  Un écriveur de fichier classique.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Lecteur_Fichier  : aliased Lecteure_R.Fichier_P.Lecteur_Fichier_T;
   --  Un lecteur de fichier classique.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Ecriveur : Ecriveur_R.Ecriveur_A := Ecriveur_Fichier'Access;
   --  L'écriveur de donnée effectif peut être changé
   --  par le biais de cette variable.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Lecteur  : Lecteure_R.Lecteur_A  := Lecteur_Fichier'Access;
   --  Le lecteur de donnée effectif peut être changé
   --  par le biais de cette variable.

   ---------------------------------------
   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   protected Filtre_Entree_Protegee is
      entry Attendre_Entree;
      --  Tant qu'aucun filtre n'est donné les tâches sont mise
      --  en pause.
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class);
      --  Permet de modifier le filtre.
      --  @param Filtre
      --  Le filtre à utiliser.
      function Lire_Filtre
         return Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class;
      --  Permet de récupérer le filtre.
      --  @return Le filtre.
   private
      Filtre_Initialise : Boolean                        := False;
      --  Un filtre à été configuré.
      Filtre_H          : Des_P.Filtre_P.Entree_P.Holder_P.Holder;
      --  Stock le filtre.
   end Filtre_Entree_Protegee;
   --  Permet de changer le filtre utilisé par le premier
   --  étage de chiffrement.

   ---------------------------------------
   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   protected Filtre_Sortie_Protegee is
      entry Attendre_Entree;
      --  Tant qu'aucun filtre n'est donné les tâches sont mise
      --  en pause.
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class);
      --  Permet de modifier le filtre.
      --  @param Filtre
      --  Le filtre à utiliser.
      function Lire_Filtre
         return Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class;
      --  Permet de récupérer le filtre.
      --  @return Le filtre.
   private
      Filtre_Initialise : Boolean                        := False;
      --  Un filtre à été configuré.
      Filtre_H          : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
      --  Stock le filtre.
   end Filtre_Sortie_Protegee;
   --  Permet de changer le filtre utilisé par le dernier
   --  étage de chiffrement.

   ---------------------------------------

   protected type Filtre_Corps_Protegee_T is
      entry Attendre_Entree;
      --  Tant qu'aucun filtre n'est donné les tâches sont mise
      --  en pause.
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class);
      --  Permet de modifier le filtre.
      --  @param Filtre
      --  Le filtre à utiliser.
      function Lire_Filtre
         return Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class;
      --  Permet de récupérer le filtre.
      --  @return Le filtre.
   private
      Filtre_Initialise : Boolean                       := False;
      --  Un filtre à été configuré.
      Filtre_H          : Des_P.Filtre_P.Corps_P.Holder_P.Holder;
      --  Stock le filtre.
   end Filtre_Corps_Protegee_T;
   --  Permet de changer le filtre utilisé par les étages de
   --  chiffrement principaux.

   ---------------------------------------

   protected type Autorisation_Protegee_T is
      entry Attendre_Entree;
      --  Tant qu'aucune grappe de blocs n'est disponible
      --  les tâches attendent ici.
      procedure Autoriser
         with Inline;
      --  Signal qu'une grappe de blocs est disponible.
   private
      Bloc_Disponnible : Boolean := False;
      --  Drapeau de grappe de blocs disponible.
   end Autorisation_Protegee_T;
   --  Barrière pour indiquer à la tâche suivante qu'un nouveau bloc
   --  de données est disponible et attend d'être récupéré.

   ---------------------------------------

   protected type Donnee_Protegee_T is
      entry Ecrire_Donnee_Entree (Grappe_De_Donnees : Donnee_T);
      --  Écrit la grappe de données.
      --  @param Grappe_De_Donnees
      --  La grappe de données à transmettre.
      procedure Lire_Donnee      (Grappe_De_Donnees : out Donnee_T)
         with Inline;
      --  Récupère la grappe de données.
      --  @param Grappe_De_Donnees
      --  La grappe de données à récupérer.
   private
      Bloc_Disponnible  : Boolean := True;
      --  Drapeau de blocs disponible.
      Donnee            : Donnee_T;
      --  La donnée stocké.
   end Donnee_Protegee_T;
   --  Barrière destinée à transmettre le bloc à la tâche suivante
   --  et permet également d'indiquer si le bloc à bien été récupéré
   --  par la tâche suivante.

   ---------------------------------------

   type Table_Filtre_T is array (Numero_Filtre_T) of
      Des_P.Filtre_P.Corps_P.Holder_P.Holder;
   --  Contient tous les filtres principaux qui vont être utilisé
   --  par les tâches de chiffrement, dans l'ordre d'utilisation.

   type Chaine_T is new Chaine_Interface_T with
      record
         Filtre_Entree : Des_P.Filtre_P.Entree_P.Holder_P.Holder;
         --  le Premier filtre par lequel vont passer les
         --  grappes de données.
         Filtres_Corps : Table_Filtre_T;
         --  Un tableau de filtres par lesquels vont passer les
         --  grappes de données.
         Filtre_Sortie : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
         --  Le dernier filtre par lequel vont passer les
         --  grappes de données.
         Max_Grappes   : Limiteur_R.Max_Grappes_T :=
            Limiteur_R.Max_Grappes_T'First;
         --  Le nombre maximum de grappes de blocs en même temps dans
         --  le pipeline.
         Modifier_Max_Grappes : Boolean := False;
         --  On souhaite que la modification du nombre de
         --  grappes soit prise en compte par la chaine.
      end record;

   ---------------------------------------

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Donnee_Debut : Donnee_Protegee_T;
   --  La donnée transmise par la tâche lectrice, du fichier à chiffrer,
   --  à la tâche de filtre d'entré.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Donnee_Fin   : Donnee_Protegee_T;
   --  La donnée transmise par la tâche de dernier filtre
   --  à la tâche écrivaine, du fichier chiffré.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Autorisateur_Debut : Autorisation_Protegee_T;
   --  Signal d'autorisation de lecture de la donnée de la tâche
   --  lectrice à la tâche de filtre d'entrée.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Autorisateur_Fin   : Autorisation_Protegee_T;
   --  Signal d'autorisation de lecture de la donnée de la tâche
   --  de filtre de sortie à la tâche écrivaine.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   task Etage_Lecteur_Tache;
   --  La tâche chargé de lire le fichier donné en entré.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   task Etage_Ecriture_Tache;
   --  La tâche chargé d'écrire dans le fichier en sortie.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   task Etage_Entree_Tache;
   --  La tâche appliquant le premier filtre aux blocs de données.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   task Etage_Sortie_Tache;
   --  La tâche appliquant le dernier filtre aux blocs de données.

   task type Etage_Corps_Tache_T
      (
         Filtreur               : access Filtre_Corps_Protegee_T;
         Autorisateur_Reception : access Autorisation_Protegee_T;
         Donnee_Recue           : access Donnee_Protegee_T;
         Autorisateur_Envoyee   : access Autorisation_Protegee_T;
         Donnee_A_Envoyer       : access Donnee_Protegee_T
      )
   is
   end Etage_Corps_Tache_T;
   --  La tâche appliquant les filtres principaux.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Filtreur_Corps_01 : aliased Filtre_Corps_Protegee_T;
   --  1er Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_02 : aliased Filtre_Corps_Protegee_T;
   --  2eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_03 : aliased Filtre_Corps_Protegee_T;
   --  3eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_04 : aliased Filtre_Corps_Protegee_T;
   --  4eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_05 : aliased Filtre_Corps_Protegee_T;
   --  5eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_06 : aliased Filtre_Corps_Protegee_T;
   --  6eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_07 : aliased Filtre_Corps_Protegee_T;
   --  7eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_08 : aliased Filtre_Corps_Protegee_T;
   --  8eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_09 : aliased Filtre_Corps_Protegee_T;
   --  9eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_10 : aliased Filtre_Corps_Protegee_T;
   --  10eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_11 : aliased Filtre_Corps_Protegee_T;
   --  11eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_12 : aliased Filtre_Corps_Protegee_T;
   --  12eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_13 : aliased Filtre_Corps_Protegee_T;
   --  13eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_14 : aliased Filtre_Corps_Protegee_T;
   --  14eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_15 : aliased Filtre_Corps_Protegee_T;
   --  15eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.
   Filtreur_Corps_16 : aliased Filtre_Corps_Protegee_T;
   --  16eme Modificateur de filtre de la partie principal
   --  de l'algorithme D.E.S.

   type Table_Filtreur_T is array (Numero_Filtre_T)
      of access Filtre_Corps_Protegee_T;
   --  Un tableau de modificateur de filtres, pour faciliter
   --  leur manipulations.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Table_Filtreur : Table_Filtreur_T :=
      Table_Filtreur_T'
      (
         1  => Filtreur_Corps_01'Access,
         2  => Filtreur_Corps_02'Access,
         3  => Filtreur_Corps_03'Access,
         4  => Filtreur_Corps_04'Access,
         5  => Filtreur_Corps_05'Access,
         6  => Filtreur_Corps_06'Access,
         7  => Filtreur_Corps_07'Access,
         8  => Filtreur_Corps_08'Access,
         9  => Filtreur_Corps_09'Access,
         10 => Filtreur_Corps_10'Access,
         11 => Filtreur_Corps_11'Access,
         12 => Filtreur_Corps_12'Access,
         13 => Filtreur_Corps_13'Access,
         14 => Filtreur_Corps_14'Access,
         15 => Filtreur_Corps_15'Access,
         16 => Filtreur_Corps_16'Access
      );
   --  Table contenant les modificateurs de filtre.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Donnee_01 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_02 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_03 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_04 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_05 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_06 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_07 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_08 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_09 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_10 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_11 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_12 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_13 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_14 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_15 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_16 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.
   Donnee_17 : aliased Donnee_Protegee_T;
   --  Un transmetteur de données entre les tâches principales.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   Autorisateur_01 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_02 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_03 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_04 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_05 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_06 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_07 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_08 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_09 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_10 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_11 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_12 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_13 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_14 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_15 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_16 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.
   Autorisateur_17 : aliased Autorisation_Protegee_T;
   --  Autorise la tâche suivante à lire la donnée.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_01_02_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_01'Access,
         Autorisateur_Reception => Autorisateur_01'Access,
         Donnee_Recue           => Donnee_01'Access,
         Autorisateur_Envoyee   => Autorisateur_02'Access,
         Donnee_A_Envoyer       => Donnee_02'Access
      );
   --  Lie les étages 1 et 2 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_01 : Etage_01_02_T;
   --  La tâche 1 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_02_03_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_02'Access,
         Autorisateur_Reception => Autorisateur_02'Access,
         Donnee_Recue           => Donnee_02'Access,
         Autorisateur_Envoyee   => Autorisateur_03'Access,
         Donnee_A_Envoyer       => Donnee_03'Access
      );
   --  Lie les étages 2 et 3 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_02 : Etage_02_03_T;
   --  La tâche 2 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_03_04_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_03'Access,
         Autorisateur_Reception => Autorisateur_03'Access,
         Donnee_Recue           => Donnee_03'Access,
         Autorisateur_Envoyee   => Autorisateur_04'Access,
         Donnee_A_Envoyer       => Donnee_04'Access
      );
   --  Lie les étages 3 et 4 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_03 : Etage_03_04_T;
   --  La tâche 3 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_04_05_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_04'Access,
         Autorisateur_Reception => Autorisateur_04'Access,
         Donnee_Recue           => Donnee_04'Access,
         Autorisateur_Envoyee   => Autorisateur_05'Access,
         Donnee_A_Envoyer       => Donnee_05'Access
      );
   --  Lie les étages 4 et 5 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_04 : Etage_04_05_T;
   --  La tâche 4 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_05_06_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_05'Access,
         Autorisateur_Reception => Autorisateur_05'Access,
         Donnee_Recue           => Donnee_05'Access,
         Autorisateur_Envoyee   => Autorisateur_06'Access,
         Donnee_A_Envoyer       => Donnee_06'Access
      );
   --  Lie les étages 5 et 6 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_05 : Etage_05_06_T;
   --  La tâche 5 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_06_07_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_06'Access,
         Autorisateur_Reception => Autorisateur_06'Access,
         Donnee_Recue           => Donnee_06'Access,
         Autorisateur_Envoyee   => Autorisateur_07'Access,
         Donnee_A_Envoyer       => Donnee_07'Access
      );
   --  Lie les étages 6 et 7 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_06 : Etage_06_07_T;
   --  La tâche 6 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_07_08_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_07'Access,
         Autorisateur_Reception => Autorisateur_07'Access,
         Donnee_Recue           => Donnee_07'Access,
         Autorisateur_Envoyee   => Autorisateur_08'Access,
         Donnee_A_Envoyer       => Donnee_08'Access
      );
   --  Lie les étages 7 et 8 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_07 : Etage_07_08_T;
   --  La tâche 7 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_08_09_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_08'Access,
         Autorisateur_Reception => Autorisateur_08'Access,
         Donnee_Recue           => Donnee_08'Access,
         Autorisateur_Envoyee   => Autorisateur_09'Access,
         Donnee_A_Envoyer       => Donnee_09'Access
      );
   --  Lie les étages 8 et 9 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_08 : Etage_08_09_T;
   --  La tâche 8 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_09_10_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_09'Access,
         Autorisateur_Reception => Autorisateur_09'Access,
         Donnee_Recue           => Donnee_09'Access,
         Autorisateur_Envoyee   => Autorisateur_10'Access,
         Donnee_A_Envoyer       => Donnee_10'Access
      );
   --  Lie les étages 9 et 10 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_09 : Etage_09_10_T;
   --  La tâche 9 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_10_11_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_10'Access,
         Autorisateur_Reception => Autorisateur_10'Access,
         Donnee_Recue           => Donnee_10'Access,
         Autorisateur_Envoyee   => Autorisateur_11'Access,
         Donnee_A_Envoyer       => Donnee_11'Access
      );
   --  Lie les étages 10 et 11 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_10 : Etage_10_11_T;
   --  La tâche 10 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_11_12_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_11'Access,
         Autorisateur_Reception => Autorisateur_11'Access,
         Donnee_Recue           => Donnee_11'Access,
         Autorisateur_Envoyee   => Autorisateur_12'Access,
         Donnee_A_Envoyer       => Donnee_12'Access
      );
   --  Lie les étages 11 et 12 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_11 : Etage_11_12_T;
   --  La tâche 11 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_12_13_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_12'Access,
         Autorisateur_Reception => Autorisateur_12'Access,
         Donnee_Recue           => Donnee_12'Access,
         Autorisateur_Envoyee   => Autorisateur_13'Access,
         Donnee_A_Envoyer       => Donnee_13'Access
      );
   --  Lie les étages 12 et 13 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_12 : Etage_12_13_T;
   --  La tâche 12 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_13_14_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_13'Access,
         Autorisateur_Reception => Autorisateur_13'Access,
         Donnee_Recue           => Donnee_13'Access,
         Autorisateur_Envoyee   => Autorisateur_14'Access,
         Donnee_A_Envoyer       => Donnee_14'Access
      );
   --  Lie les étages 13 et 14 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_13 : Etage_13_14_T;
   --  La tâche 13 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_14_15_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_14'Access,
         Autorisateur_Reception => Autorisateur_14'Access,
         Donnee_Recue           => Donnee_14'Access,
         Autorisateur_Envoyee   => Autorisateur_15'Access,
         Donnee_A_Envoyer       => Donnee_15'Access
      );
   --  Lie les étages 14 et 15 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_14 : Etage_14_15_T;
   --  La tâche 14 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_15_16_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_15'Access,
         Autorisateur_Reception => Autorisateur_15'Access,
         Donnee_Recue           => Donnee_15'Access,
         Autorisateur_Envoyee   => Autorisateur_16'Access,
         Donnee_A_Envoyer       => Donnee_16'Access
      );
   --  Lie les étages 15 et 16 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_15 : Etage_15_16_T;
   --  La tâche 15 du pipeline.

   --  Interdit l'utilisation d'un pragma Pure ou Preelaborate
   subtype Etage_16_17_T is Etage_Corps_Tache_T
      (
         Filtreur               => Filtreur_Corps_16'Access,
         Autorisateur_Reception => Autorisateur_16'Access,
         Donnee_Recue           => Donnee_16'Access,
         Autorisateur_Envoyee   => Autorisateur_17'Access,
         Donnee_A_Envoyer       => Donnee_17'Access
      );
   --  Lie les étages 16 et 17 du pipeline de chiffrement/déchiffrement.
   Etage_Corps_16 : Etage_16_17_T;
   --  La tâche 16 du pipeline.

end Des_P.Chaine_P.Ravenscar_P;
