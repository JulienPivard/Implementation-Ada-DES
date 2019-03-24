with Des_P.Clef_P.Clef_64_I_P.Faiseur_I_P.Holder_P;
with Des_P.Clef_P.Clef_56_I_P.Faiseur_I_P.Holder_P;
with Des_P.Clef_P.Clef_56_I_P.Holder_P;

package body Des_P.Faiseur_P is

   ---------------------------------------------------------------------------
   function Faire_Clef
      (
         Faiseur  : in out Faiseur_64_I_R.Faiseur_Interface_T'Class;
         Clef     : Faiseur_64_I_R.Clef_64_Brut_T
      )
      return Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
   is
      H : Faiseur_64_I_R.Holder_P.Holder :=
         Faiseur_64_I_R.Holder_P.To_Holder (Faiseur);
   begin
      H.Reference.Preparer_Nouvelle_Clef;
      H.Reference.Construire_Clef (Clef);
      return H.Element.Recuperer_Clef;
   end Faire_Clef;

   ---------------------------------------------------------------------------
   function Faire_Clef
      (
         Faiseur  : in out Faiseur_56_I_R.Faiseur_Interface_T'Class;
         Clef     : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
      return Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class
   is
      H : Faiseur_56_I_R.Holder_P.Holder :=
         Faiseur_56_I_R.Holder_P.To_Holder (Faiseur);
   begin
      H.Reference.Preparer_Nouvelle_Clef;
      H.Reference.Construire_Clef (Clef);
      return H.Element.Recuperer_Clef;
   end Faire_Clef;

   ---------------------------------------------------------------------------
   function Faire_Clef
      (
         Faiseur  : in out Faiseur_48_I_R.Faiseur_Interface_T'Class;
         Clef     : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class
      )
      return Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
   is
      H : constant Des_P.Clef_P.Clef_56_I_P.Holder_P.Holder :=
         Des_P.Clef_P.Clef_56_I_P.Holder_P.To_Holder (Clef);
   begin
      Faiseur.Preparer_Nouvelle_Clef;
      Faiseur.Construire_Clef (H.Element);
      return Faiseur.Recuperer_Clef;
   end Faire_Clef;

end Des_P.Faiseur_P;
