with Ada.Sequential_IO;
with Ada.Containers.Indefinite_Holders;

with Des_P.Bloc_P.Bloc_64_P.Constructeur_P;

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
   --  Lance le filtrage du fichier avec la clef. La version crypté ou
   --  décrypté est écrite dans un autre fichier avec l'extension crypt ou
   --  decrypt selon le filtrage effectué.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Nom_Fichier
   --  Le nom du fichier à crypter décrypter.
   --  @param Extension
   --  Extension du fichiers de sortie.

   procedure Faire_Avorter;
   --  Met fin à toutes les taches.

private

   package C_Bloc_64_P renames Des_P.Bloc_P.Bloc_64_P.Constructeur_P;
   package Lecteur_64_IO is new Ada.Sequential_IO (C_Bloc_64_P.Bloc_64_Brut_T);

   --  Tableaux de bloc de 64 pour regrouper les données
   --  et augmenter la charge de travail par taches et améliorer
   --  les temps d'exécution
   type Indice_T is range 1 .. 512;
   type Table_Bloc_T is array (Indice_T range <>)
      of Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
   package Table_Holder_P is new
      Ada.Containers.Indefinite_Holders (Table_Bloc_T);

   ---------------------------------------
   protected Avorter_Protegee is
      procedure Avorter;
      function Avorter return Boolean;
   private
      Signal : Boolean := False;
   end Avorter_Protegee;

   ---------------------------------------
   protected Autorisation_Rearmement_Protegee is
      entry Attendre_Entree;
      procedure Autoriser;
   private
      Nb_Tache_Lancee : Natural := 0;
      Signal : Boolean := False;
   end Autorisation_Rearmement_Protegee;

   ---------------------------------------
   protected Demarreur_Protegee is
      entry Attendre_Entree;
      procedure Demarrer;
   private
      Nb_Tache_Lancee : Natural := 0;
      Signal : Boolean := False;
   end Demarreur_Protegee;

   ---------------------------------------
   protected Fin_Protegee is
      entry Attendre_Entree;
      procedure Fini;
   private
      Signal : Boolean := False;
   end Fin_Protegee;

   ---------------------------------------
   protected Ecriveur_Fichier_Protegee is
      procedure Ouvrir_Fichier (Nom : String);
      procedure Ecrire (Brut : C_Bloc_64_P.Bloc_64_Brut_T);
      procedure Fermer_Fichier;
      entry Attendre_Fermeture_Entree;
   private
      Resultat : Lecteur_64_IO.File_Type;
      Est_Ferme : Boolean;
   end Ecriveur_Fichier_Protegee;

   ---------------------------------------
   protected Lecteur_Fichier_Protegee is
      procedure Ouvrir_Fichier (Nom : String);
      function Lire return C_Bloc_64_P.Bloc_64_Brut_T;
      function Est_Fini return Boolean;
      procedure Fermer_Fichier;
      entry Attendre_Fermeture_Entree;
   private
      Fichier : Lecteur_64_IO.File_Type;
      Est_Ferme : Boolean;
   end Lecteur_Fichier_Protegee;

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

   ---------------------------------------
   protected type Autorisation_Protegee is
      entry Attendre_Entree;
      procedure Autoriser;
   private
      Signal : Boolean := False;
   end Autorisation_Protegee;

   ---------------------------------------
   protected type Donnee_Protegee is
      entry Ecrire_Donnee_Entree (Table : Table_Bloc_T);
      function Lire return Table_Bloc_T;
      procedure Lu;
      procedure Terminer;
      function Est_Terminee return Boolean;
   private
      Fin : Boolean := False;
      Signal : Boolean := True;
      Donnee : Table_Holder_P.Holder;
   end Donnee_Protegee;

   ---------------------------------------
   type Table_Filtre_T is array (Numero_Filtre_T) of
      Des_P.Filtre_P.Corps_P.Holder_P.Holder;

   type Chaine_T is new Chaine_Interface_T with
      record
         Filtre_Entree : Des_P.Filtre_P.Entree_P.Holder_P.Holder;
         Filtres_Corps : Table_Filtre_T;
         Filtre_Sortie : Des_P.Filtre_P.Sortie_P.Holder_P.Holder;
      end record;
   ---------------------------------------

   Donnee_Debut : Donnee_Protegee;
   Donnee_Fin   : Donnee_Protegee;

   Autorisateur_Debut : Autorisation_Protegee;
   Autorisateur_Fin   : Autorisation_Protegee;

   task Etage_Lecteur_Tache;
   task Etage_Ecriture_Tache;

   task Etage_Entree_Tache;
   task Etage_Sortie_Tache;

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
