with AUnit.Assertions;

with Des_P.Clef_P;

package body Des_P.Sous_Clef_P.Constructeur_P.Test_P is

   --  La clef de 56 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   resultat_attendu : constant Tableau_Bits_T :=
      (0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1,
      1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0);

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
   procedure Test_Preparation (T : in out Test_Fixt_T) is
   begin
      null;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construire (T : in out Test_Fixt_T) is
   begin
      null;
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
   begin
      null;
   end Test_Recuperation;

end Des_P.Sous_Clef_P.Constructeur_P.Test_P;
