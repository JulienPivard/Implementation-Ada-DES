with Ada.Unchecked_Conversion;

with System;

package body Des_P.Clef_P.Clef_64_P.Faiseur_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Preparer_Nouvelle_Clef
      (Constructeur : in out Faiseur_Clef_T)
   is
      C : Clef_T;
   begin
      Constructeur.Clef := C;
   end Preparer_Nouvelle_Clef;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Clef
      (
         Constructeur   : in out Faiseur_Clef_T;
         Brut           :        Interface_R.Clef_64_Brut_T
      )
   is
      type Table_Tmp_T is new Tableau_Bits_T
         with
            Size                 => 64,
            Pack                 => True,
            Scalar_Storage_Order => System.Low_Order_First;

      function Brut_Vers_Table_Tmp is new Ada.Unchecked_Conversion
         (
            Source => Interface_R.Clef_64_Brut_T,
            Target => Table_Tmp_T
         );

      Resultat : constant Table_Tmp_T := Brut_Vers_Table_Tmp (S => Brut);
   begin
      Constructeur.Clef.Bits := Tableau_Bits_T (Resultat);
   end Construire_Clef;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
   is
   begin
      return Constructeur.Clef;
   end Recuperer_Clef;

   ---------------------------------------------------------------------------
   function Recuperer_Clef
      (Constructeur : Faiseur_Clef_T)
      return Clef_T
   is
   begin
      return Constructeur.Clef;
   end Recuperer_Clef;

end Des_P.Clef_P.Clef_64_P.Faiseur_P;
