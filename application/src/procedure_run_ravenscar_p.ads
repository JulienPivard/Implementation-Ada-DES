with Des_P.Clef_P.Clef_64_P;

private with Des_P.Chaine_P.Constructeur_I_P;
private with Des_P.Clef_P.Clef_56_P.Constructeur_P;
private with Des_P.Clef_P.Clef_48_P.Constructeur_P;

--  @summary
--  Une suite d'opérations utilisé par le client.
--  @description
--  Un groupe de procédure et de fonction pour faciliter les
--  manipulations par le client. L'initialisation de la chaine
--  et des différents filtres.
--  @group Principal
package Procedure_Run_Ravenscar_P is

   type Action_T is (Crypter, Decrypter);
   --  L'action à effectuer sur le fichier.
   --  @value Crypter L'action de crypter.
   --  @value Decrypter L'action de décrypter.

   procedure Executer_Crypt_Decrypt
      (
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T;
         Nom_Fichier : String;
         Action : Action_T
      );
   --  Initialise et exécute le filtrage sur le fichier.
   --  @param Clef
   --  La clef avec laquelle on va travailler.
   --  @param Nom_Fichier
   --  Le nom du fichier à lire.
   --  @param Action
   --  L'action à effectuer : crypter ou décrypter.
   --  @param C_Type
   --  Choix entre séquentiel et taches.

private

   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Constructeur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Constructeur_P;

   package Faiseur_P renames Des_P.Chaine_P.Constructeur_I_P;

   function Init_Faiseur_Chaine
      (
         Action : Action_T
      )
      return Faiseur_P.Constructeur_Interface_T'Class;
   --  Initialise un constructeur de chaines.
   --  @param Action
   --  L'action à effectuer : crypter ou décrypter.
   --  @param C_Type
   --  Choix entre séquentiel et taches.
   --  @return Le constructeur de chaine.

   function Init_Extension
      (
         Action : Action_T
      )
      return String;
   --  Initialise l'extension pour le fichier alternatif.
   --  @param Action
   --  L'action à effectuer : crypter ou décrypter.
   --  @param C_Type
   --  Choix entre séquentiel et taches.
   --  @return L'extension du fichier alternatif.

   function Init_Chaine
      (
         Faiseur : in out Faiseur_P.Constructeur_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T
      )
      return Des_P.Chaine_P.Chaine_Interface_T'Class;
   --  Initialise une chaine de cryptage décryptage.
   --  @param Faiseur
   --  Le constructeur de chaine.
   --  @param Clef
   --  La clef de cryptage décryptage.
   --  @return La chaine construite.

end Procedure_Run_Ravenscar_P;
