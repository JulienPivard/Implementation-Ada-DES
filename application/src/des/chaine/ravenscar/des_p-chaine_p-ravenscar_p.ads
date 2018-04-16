private with Ada.Containers.Indefinite_Holders;

private with Des_P.Chaine_P.Limiteur_Jetons_P;
private with Des_P.Chaine_P.Accee_Fichier_P;
private with Des_P.Bloc_P.Bloc_64_P;
private with Des_P.Bloc_P.Bloc_64_P.Faiseur_P;

private with Des_P.Filtre_P.Corps_P.Holder_P;
private with Des_P.Filtre_P.Entree_P.Holder_P;
private with Des_P.Filtre_P.Sortie_P.Holder_P;

--  @summary
--  Chaine de filtres parallèle.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P.Ravenscar_P is

   type Chaine_T is new Chaine_Interface_T with private;
   --  La chaine de filtres parallèle.

   overriding
   procedure Filtrer
      (
         Chaine : Chaine_T;
         Nom_Fichier : String;
         Extension : String
      );
   --  Lance le filtrage du fichier avec la clef. La version chiffré ou
   --  déchiffré est écrite dans un autre fichier avec l'extension chiffre ou
   --  dechiffre selon le filtrage effectué.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Nom_Fichier
   --  Le nom du fichier à chiffrer déchiffrer.
   --  @param Extension
   --  Extension du fichiers de sortie.

   procedure Faire_Avorter;
   --  Met fin à toutes les taches.

private

   package C_Bloc_64_P renames Des_P.Bloc_P.Bloc_64_P.Faiseur_P;
   package Limiteur_P renames Des_P.Chaine_P.Limiteur_Jetons_P;

   type Indice_T is range 1 .. 512;
   --  Les indices des table de blocs.
   type Table_Bloc_T is array (Indice_T range <>)
      of Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
   --  Tableaux de blocs de 64 pour regrouper les données
   --  et augmenter la charge de travail par tâches et ainsi
   --  améliorer les temps d'exécution

   package Table_Holder_P is new
      Ada.Containers.Indefinite_Holders (Table_Bloc_T);

   type Donnee_T is
      record
         Table : Table_Holder_P.Holder;
         Est_Derniere_Grappe : Boolean := False;
      end record;
   --  Une grappe de blocs avec un drapeau pour savoir si
   --  c'est la dernière.

   procedure Filtrer
      (
         D : in out Donnee_T;
         Procedure_Filtre : not null access
            procedure (Table : in out Table_Bloc_T)
      );

   procedure Appliquer
      (
         D : Donnee_T;
         Procedure_Appliquee : not null access
            procedure (Table : Table_Bloc_T)
      );

   procedure Ecrire_Table
      (
         D : in out Donnee_T;
         T : Table_Bloc_T
      );

   procedure Ecrire_Est_Derniere
      (
         D : in out Donnee_T;
         Fini : Boolean
      );

   function Est_Derniere
      (D : Donnee_T)
      return Boolean
   is (D.Est_Derniere_Grappe);

   package Donnee_Holder_P is new
      Ada.Containers.Indefinite_Holders (Donnee_T);

   ---------------------------------------

   protected Avorter_Protegee is
      procedure Avorter;
      function Avorter return Boolean;
   private
      Signal : Boolean := False;
   end Avorter_Protegee;
   --  Signal pour mettre fin à toutes les tâches en cours.
   --  L'instruction abort étant interdite en ravenscar les tâches
   --  ne peuvent être stoppé qu'a un seul moment de l'exécution, lors
   --  de l'envoie du signal du demarreur_protegee.

   type Compteur_Tache_T is range 0 .. 20;
   --  Destiné à compter le nombre de taches

   ---------------------------------------

   protected Autorisation_Rearmement_Protegee is
      entry Attendre_Entree;
      procedure Autoriser;
   private
      Nb_Tache_Lancee : Compteur_Tache_T := Compteur_Tache_T'First;
      Signal : Boolean := False;
   end Autorisation_Rearmement_Protegee;
   --  Bloque les tâches une fois qu'elles ont fini de chiffrer tous les
   --  blocs. Une fois l'autorisation donnée les tâches peuvent se positionner
   --  à nouveau devant la barrière du demarreur_protegee. Le but est ici
   --  de bloquer les tâches pour ne pas se relancer elle même si leur tâche
   --  est finie avant que la barrière du demarreur_protegee ne se referme.

   ---------------------------------------

   protected Demarreur_Protegee is
      entry Attendre_Entree;
      procedure Demarrer;
   private
      Nb_Tache_Lancee : Compteur_Tache_T := Compteur_Tache_T'First;
      Signal : Boolean := False;
   end Demarreur_Protegee;
   --  Bloque le démarrage des taches. Tant que le signal de démarrage n'est
   --  pas donné les tâches attendent. Une fois que toutes les tâches on passé
   --  la barrière elle est refermé en attendant le prochain départ.

   ---------------------------------------

   protected Fin_Protegee is
      entry Attendre_Entree;
      procedure Fini;
   private
      Signal : Boolean := False;
   end Fin_Protegee;
   --  Permet de signaler à la procédure appelante que toutes les tâches
   --  ont fini de chiffrer le fichier.

   package Accee_P renames Des_P.Chaine_P.Accee_Fichier_P;

   Ecriveur : access Accee_P.Ecriveur_Protegee_T'Class;
   --  L'écriveur de donnée effectif peut être changé
   --  par le biais de cette variable.

   Lecteur : access Accee_P.Lecteur_Protegee_T'Class;
   --  Le lecteur de donnée effectif peut être changé
   --  par le biais de cette variable.

   Ecriveur_Fichier : aliased Accee_P.Ecriveur_Fichier_Protegee;
   --  Un écriveur de fichier classique.

   Lecteur_Fichier : aliased Accee_P.Lecteur_Fichier_Protegee;
   --  Un lecteur de fichier classique.

   ---------------------------------------

   protected Filtre_Entree_Protegee is
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class);
      entry Attendre_Entree;
      function Lire_Filtre
         return Des_P.Filtre_P.Entree_P.Entree_Abstrait_T'Class;
   private
      Signal : Boolean := False;
      Filtre_H : Des_P.Filtre_P.Entree_P.Holder_P.Holder;
   end Filtre_Entree_Protegee;
   --  Permet de changer le filtre utilisé par le premier
   --  étage de chiffrement.

   ---------------------------------------

   protected Filtre_Sortie_Protegee is
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class);
      entry Attendre_Entree;
      function Lire_Filtre
         return Des_P.Filtre_P.Sortie_P.Sortie_Abstrait_T'Class;
   private
      Signal : Boolean := False;
      Filtre_H : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
   end Filtre_Sortie_Protegee;
   --  Permet de changer le filtre utilisé par le dernier
   --  étage de chiffrement.

   ---------------------------------------

   protected type Filtre_Corps_Protegee is
      procedure Changer_Filtre
         (Filtre : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class);
      entry Attendre_Entree;
      function Lire_Filtre
         return Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class;
   private
      Signal : Boolean := False;
      Filtre_H : Des_P.Filtre_P.Corps_P.Holder_P.Holder;
   end Filtre_Corps_Protegee;
   --  Permet de changer le filtre utilisé par les étages de
   --  chiffrement principaux.

   ---------------------------------------

   protected type Autorisation_Protegee is
      entry Attendre_Entree;
      procedure Autoriser;
   private
      Signal : Boolean := False;
   end Autorisation_Protegee;
   --  Barrière pour indiquer à la tâche suivante qu'un nouveau bloc
   --  de donné est disponible et attend d'être récupéré.

   ---------------------------------------

   protected type Donnee_Protegee is
      entry Ecrire_Donnee_Entree (Table : Donnee_T);
      procedure Lire_Donnee (Table : out Donnee_T);
   private
      Signal : Boolean := True;
      Donnee : Donnee_T;
   end Donnee_Protegee;
   --  Barrière destiné à transmettre le bloc à la tâche suivante
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
         Filtres_Corps : Table_Filtre_T;
         Filtre_Sortie : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
         Max_Grappes : Limiteur_P.Max_Grappes_T :=
            Limiteur_P.Max_Grappes_T'First;
         Modifier_Max_Grappes : Boolean := False;
      end record;

   ---------------------------------------

   Donnee_Debut : Donnee_Protegee;
   --  La donnée transmise par la tâche lectrice, du fichier à chiffrer,
   --  à la tâche de filtre d'entré.
   Donnee_Fin   : Donnee_Protegee;
   --  La donnée transmise par la tâche de dernier filtre
   --  à la tâche écrivaine, du fichier chiffré.

   Autorisateur_Debut : Autorisation_Protegee;
   --  Signal d'autorisation de lecture de la donnée de la tâche
   --  lectrice à la tâche de filtre d'entrée.
   Autorisateur_Fin   : Autorisation_Protegee;
   --  Signal d'autorisation de lecture de la donnée de la tâche
   --  de filtre de sortie à la tâche écrivaine.

   task Etage_Lecteur_Tache;
   --  La tâche lectrice.
   task Etage_Ecriture_Tache;
   --  La tâche écrivaine.

   task Etage_Entree_Tache;
   --  La tâche de premier filtre.
   task Etage_Sortie_Tache;
   --  La tâche de dernier filtre.

   task type Etage_Corps_Tache
      (
         Filtreur               : access Filtre_Corps_Protegee;
         Autorisateur_Reception : access Autorisation_Protegee;
         Donnee_Recue           : access Donnee_Protegee;
         Autorisateur_Envoyee   : access Autorisation_Protegee;
         Donnee_A_Envoyer       : access Donnee_Protegee
      )
   is
   end Etage_Corps_Tache;
   --  La tâche de filtre principaux.

   Filtreur_Corps_01 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_02 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_03 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_04 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_05 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_06 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_07 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_08 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_09 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_10 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_11 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_12 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_13 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_14 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_15 : aliased Filtre_Corps_Protegee;
   Filtreur_Corps_16 : aliased Filtre_Corps_Protegee;
   --  Les modificateurs de filtre.

   Table_Filtreur : array (Numero_Filtre_T) of access Filtre_Corps_Protegee :=
      (
         Filtreur_Corps_01'Access,
         Filtreur_Corps_02'Access,
         Filtreur_Corps_03'Access,
         Filtreur_Corps_04'Access,
         Filtreur_Corps_05'Access,
         Filtreur_Corps_06'Access,
         Filtreur_Corps_07'Access,
         Filtreur_Corps_08'Access,
         Filtreur_Corps_09'Access,
         Filtreur_Corps_10'Access,
         Filtreur_Corps_11'Access,
         Filtreur_Corps_12'Access,
         Filtreur_Corps_13'Access,
         Filtreur_Corps_14'Access,
         Filtreur_Corps_15'Access,
         Filtreur_Corps_16'Access
      );
   --  Table contenant les modificateurs de filtre.

   Donnee_01 : aliased Donnee_Protegee;
   Donnee_02 : aliased Donnee_Protegee;
   Donnee_03 : aliased Donnee_Protegee;
   Donnee_04 : aliased Donnee_Protegee;
   Donnee_05 : aliased Donnee_Protegee;
   Donnee_06 : aliased Donnee_Protegee;
   Donnee_07 : aliased Donnee_Protegee;
   Donnee_08 : aliased Donnee_Protegee;
   Donnee_09 : aliased Donnee_Protegee;
   Donnee_10 : aliased Donnee_Protegee;
   Donnee_11 : aliased Donnee_Protegee;
   Donnee_12 : aliased Donnee_Protegee;
   Donnee_13 : aliased Donnee_Protegee;
   Donnee_14 : aliased Donnee_Protegee;
   Donnee_15 : aliased Donnee_Protegee;
   Donnee_16 : aliased Donnee_Protegee;
   Donnee_17 : aliased Donnee_Protegee;
   --  Les transmetteurs de données entre les tâches principales

   Autorisateur_01 : aliased Autorisation_Protegee;
   Autorisateur_02 : aliased Autorisation_Protegee;
   Autorisateur_03 : aliased Autorisation_Protegee;
   Autorisateur_04 : aliased Autorisation_Protegee;
   Autorisateur_05 : aliased Autorisation_Protegee;
   Autorisateur_06 : aliased Autorisation_Protegee;
   Autorisateur_07 : aliased Autorisation_Protegee;
   Autorisateur_08 : aliased Autorisation_Protegee;
   Autorisateur_09 : aliased Autorisation_Protegee;
   Autorisateur_10 : aliased Autorisation_Protegee;
   Autorisateur_11 : aliased Autorisation_Protegee;
   Autorisateur_12 : aliased Autorisation_Protegee;
   Autorisateur_13 : aliased Autorisation_Protegee;
   Autorisateur_14 : aliased Autorisation_Protegee;
   Autorisateur_15 : aliased Autorisation_Protegee;
   Autorisateur_16 : aliased Autorisation_Protegee;
   Autorisateur_17 : aliased Autorisation_Protegee;
   --  Les autorisation de lecture de données entre les tâches principales.

   Etage_Corps_01 : Etage_Corps_Tache
      (
         Filtreur_Corps_01'Access,
         Autorisateur_01'Access,
         Donnee_01'Access,
         Autorisateur_02'Access,
         Donnee_02'Access
      );

   Etage_Corps_02 : Etage_Corps_Tache
      (
         Filtreur_Corps_02'Access,
         Autorisateur_02'Access,
         Donnee_02'Access,
         Autorisateur_03'Access,
         Donnee_03'Access
      );

   Etage_Corps_03 : Etage_Corps_Tache
      (
         Filtreur_Corps_03'Access,
         Autorisateur_03'Access,
         Donnee_03'Access,
         Autorisateur_04'Access,
         Donnee_04'Access
      );

   Etage_Corps_04 : Etage_Corps_Tache
      (
         Filtreur_Corps_04'Access,
         Autorisateur_04'Access,
         Donnee_04'Access,
         Autorisateur_05'Access,
         Donnee_05'Access
      );

   Etage_Corps_05 : Etage_Corps_Tache
      (
         Filtreur_Corps_05'Access,
         Autorisateur_05'Access,
         Donnee_05'Access,
         Autorisateur_06'Access,
         Donnee_06'Access
      );

   Etage_Corps_06 : Etage_Corps_Tache
      (
         Filtreur_Corps_06'Access,
         Autorisateur_06'Access,
         Donnee_06'Access,
         Autorisateur_07'Access,
         Donnee_07'Access
      );

   Etage_Corps_07 : Etage_Corps_Tache
      (
         Filtreur_Corps_07'Access,
         Autorisateur_07'Access,
         Donnee_07'Access,
         Autorisateur_08'Access,
         Donnee_08'Access
      );

   Etage_Corps_08 : Etage_Corps_Tache
      (
         Filtreur_Corps_08'Access,
         Autorisateur_08'Access,
         Donnee_08'Access,
         Autorisateur_09'Access,
         Donnee_09'Access
      );

   Etage_Corps_09 : Etage_Corps_Tache
      (
         Filtreur_Corps_09'Access,
         Autorisateur_09'Access,
         Donnee_09'Access,
         Autorisateur_10'Access,
         Donnee_10'Access
      );

   Etage_Corps_10 : Etage_Corps_Tache
      (
         Filtreur_Corps_10'Access,
         Autorisateur_10'Access,
         Donnee_10'Access,
         Autorisateur_11'Access,
         Donnee_11'Access
      );

   Etage_Corps_11 : Etage_Corps_Tache
      (
         Filtreur_Corps_11'Access,
         Autorisateur_11'Access,
         Donnee_11'Access,
         Autorisateur_12'Access,
         Donnee_12'Access
      );

   Etage_Corps_12 : Etage_Corps_Tache
      (
         Filtreur_Corps_12'Access,
         Autorisateur_12'Access,
         Donnee_12'Access,
         Autorisateur_13'Access,
         Donnee_13'Access
      );

   Etage_Corps_13 : Etage_Corps_Tache
      (
         Filtreur_Corps_13'Access,
         Autorisateur_13'Access,
         Donnee_13'Access,
         Autorisateur_14'Access,
         Donnee_14'Access
      );

   Etage_Corps_14 : Etage_Corps_Tache
      (
         Filtreur_Corps_14'Access,
         Autorisateur_14'Access,
         Donnee_14'Access,
         Autorisateur_15'Access,
         Donnee_15'Access
      );

   Etage_Corps_15 : Etage_Corps_Tache
      (
         Filtreur_Corps_15'Access,
         Autorisateur_15'Access,
         Donnee_15'Access,
         Autorisateur_16'Access,
         Donnee_16'Access
      );

   Etage_Corps_16 : Etage_Corps_Tache
      (
         Filtreur_Corps_16'Access,
         Autorisateur_16'Access,
         Donnee_16'Access,
         Autorisateur_17'Access,
         Donnee_17'Access
      );

end Des_P.Chaine_P.Ravenscar_P;
