with AUnit.Assertions;

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
   procedure Test_Filtre (T : in out Test_Fixt_T) is
      pragma Unreferenced (T);
   begin
      AUnit.Assertions.Assert
         (False,
         "A implementer !!!!!"
         );
   end Test_Filtre;

   ---------------------------------------------------------------------------
   procedure Test_Execution (T : in out Test_Fixt_T) is
      pragma Unreferenced (T);
   begin
      AUnit.Assertions.Assert
         (False,
         "A implementer !!!!!"
         );
   end Test_Execution;

end Des_P.Chaine_P.Sequentiel_P.Test_P;
