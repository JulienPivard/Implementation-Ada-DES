with Des_P.Clef_P.Clef_64_P;

private with Des_P.Chaine_P.Constructeur_I_P;
private with Des_P.Clef_P.Clef_56_P.Constructeur_P;
private with Des_P.Clef_P.Clef_48_P.Constructeur_P;

package Procedure_Run_P is

   type Action_T is (Crypter, Decrypter);
   type Chaine_Seq_Task_T is (Tache, Sequentiel);

   procedure Executer_Crypt_Decrypt
      (
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T;
         Nom_Fichier : String;
         Action : Action_T;
         C_Type : Chaine_Seq_Task_T
      );

private

   package Faiseur_56_P renames Des_P.Clef_P.Clef_56_P.Constructeur_P;
   package Faiseur_48_P renames Des_P.Clef_P.Clef_48_P.Constructeur_P;

   package Faiseur_P renames Des_P.Chaine_P.Constructeur_I_P;

   function Init_Faiseur_Chaine
      (
         Action : Action_T;
         C_Type : Chaine_Seq_Task_T
      )
      return Faiseur_P.Constructeur_Interface_T'Class;

   function Init_Extension
      (
         Action : Action_T;
         C_Type : Chaine_Seq_Task_T
      )
      return String;

   function Init_Chaine
      (
         Faiseur : in out Faiseur_P.Constructeur_Interface_T'Class;
         Clef : Des_P.Clef_P.Clef_64_P.Clef_T
      )
      return Des_P.Chaine_P.Chaine_Interface_T'Class;

end Procedure_Run_P;
