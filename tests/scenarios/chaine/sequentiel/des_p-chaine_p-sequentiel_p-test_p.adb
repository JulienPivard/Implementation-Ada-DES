with AUnit.Assertions;

with Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;
with Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P;

package body Des_P.Chaine_P.Sequentiel_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
   begin
      null;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Initialisation (T : in out Test_Fixt_T) is
      pragma Unreferenced (T);
      use Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
      use Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;
      use Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P;
      C_64 : Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P.Clef_Simplifie_T;
      Const : constant access Constructeur_Clef_56_T :=
         new Constructeur_Clef_56_T;
      C_56 : Clef_56_T;
      Chaine : Chaine_T;
      Fab : Fabrique_Cryptage_T;
   begin
      C_64.Init ((others => False), Const);
      C_56 := C_64.Lire_Clef_56;
      Chaine.Initiliser (Fab, C_64);
      AUnit.Assertions.Assert
         (Clef_56_T (Chaine.Clef.Element) = C_56,
         "La clef de 56 n'est pas correct."
         );
   end Test_Initialisation;

   ---------------------------------------------------------------------------
   procedure Test_Filtre (T : in out Test_Fixt_T) is
      pragma Unreferenced (T);
   begin
      AUnit.Assertions.Assert
         (False,
         "A implementer !!!!!"
         );
   end Test_Filtre;

end Des_P.Chaine_P.Sequentiel_P.Test_P;
