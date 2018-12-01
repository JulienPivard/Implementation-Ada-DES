with Des_P.Clef_P.Clef_64_I_P;
with Des_P.Chaine_P.Faiseur_I_P;

private with Des_P.Clef_P.Clef_56_P.Faiseur_P;
private with Des_P.Clef_P.Clef_48_P.Faiseur_P;

--  @summary
--  Une suite d'opérations d'initialisation utilisé par le client.
--  @description
--  Un groupe de procédure et de fonction pour faciliter les
--  manipulations par le client. L'initialisation de la chaine
--  et des différents filtres.
--  @group Principal
generic

   Extension : String;
   Nom_Version : String;
   --  Constructeur de chaine de chiffrement.
   type Faiseur_Chiffrement_G_T is new
      Des_P.Chaine_P.Faiseur_I_P.Faiseur_Interface_T with private;
   --  Constructeur de chaine de déchiffrement.
   type Faiseur_Dechiffrement_G_T is new
      Des_P.Chaine_P.Faiseur_I_P.Faiseur_Interface_T with private;

package Procedure_Run_G is

   type Action_T is (Chiffrer, Dechiffrer);
   --  L'action à effectuer sur le fichier.
   --  @value Chiffrer L'action de chiffrer.
   --  @value Dechiffrer L'action de déchiffrer.

   procedure Executer_Chiffrement
      (
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class;
         Nom_Fichier : String;
         Action : Action_T
      );
   --  Initialise et exécute le filtrage sur le fichier.
   --  @param Clef
   --  La clef avec laquelle on va travailler.
   --  @param Nom_Fichier
   --  Le nom du fichier à lire.
   --  @param Action
   --  L'action à effectuer : chiffrer ou déchiffrer.

private

   package Faiseur_56_R renames Des_P.Clef_P.Clef_56_P.Faiseur_P;
   package Faiseur_48_R renames Des_P.Clef_P.Clef_48_P.Faiseur_P;

   package Faiseur_I_R renames Des_P.Chaine_P.Faiseur_I_P;

   function Init_Faiseur_Chaine
      (Action : Action_T)
      return Faiseur_I_R.Faiseur_Interface_T'Class;
   --  Initialise un constructeur de chaines.
   --  @param Action
   --  L'action à effectuer : chiffrer ou déchiffrer.
   --  @return Le constructeur de chaine.

   function Init_Extension
      (Action : Action_T)
      return String;
   --  Initialise l'extension pour le fichier alternatif.
   --  @param Action
   --  L'action à effectuer : chiffrer ou déchiffrer.
   --  @return L'extension du fichier alternatif.

   function Init_Chaine
      (
         Faiseur : in out Faiseur_I_R.Faiseur_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
      return Des_P.Chaine_P.Chaine_Interface_T'Class;
   --  Initialise une chaine de chiffrement ou de déchiffrement.
   --  @param Faiseur
   --  Le constructeur de chaine.
   --  @param Clef
   --  La clef de chiffrement.
   --  @return La chaine construite.

end Procedure_Run_G;
