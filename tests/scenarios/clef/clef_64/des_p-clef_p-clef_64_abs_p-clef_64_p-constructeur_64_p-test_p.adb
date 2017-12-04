with AUnit.Assertions;

package body Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P.Test_P is

   clef_brut_64 : constant Clef_64_Brut_T :=
   2#11110000_11110000_11110000_11110000_11110000_11110000_11110000_11110000#;

   --  La clef de 64 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  1    5    9    13   17   21   25   29
   --  1111 0000 1111 0000 1111 0000 1111 0000
   --  33   37   41   45   49   53   57   61
   resultat_attendu : constant Tableau_Bits_T :=
      (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 | 33 .. 36 |
      41 .. 44 | 49 .. 52 | 57 .. 60 => 1, others => 0);

   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      constr : constant access Constructeur_Clef_64_T :=
         new Constructeur_Clef_64_T;
   begin
      T.constructeur := constr;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      T.constructeur := null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   procedure Test_Preparation (T : in out Test_Fixt_T) is
      bit_attendu : constant Bit_T := 0;
      bit_lu : Bit_T;
   begin
      T.constructeur.all.Preparer_Nouvelle_Clef_64;
      for I in Intervalle_Clef_64_T'Range loop
         bit_lu := T.constructeur.all.Clef_64.Lire_Bit (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construire (T : in out Test_Fixt_T) is
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      T.constructeur.all.Preparer_Nouvelle_Clef_64;
      T.constructeur.all.Construire_Clef_64 (clef_brut_64);
      for I in Intervalle_Clef_64_T'Range loop
         bit_lu := T.constructeur.all.Clef_64.Lire_Bit (I);
         bit_attendu := resultat_attendu (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      clef_construite : Clef_64_T;
      bit_lu : Bit_T;
      bit_attendu : Bit_T;
   begin
      T.constructeur.all.Preparer_Nouvelle_Clef_64;
      T.constructeur.all.Construire_Clef_64 (clef_brut_64);
      clef_construite := T.constructeur.all.Recuperer_Clef_64;
      for I in Intervalle_Clef_64_T'Range loop
         bit_lu := clef_construite.Lire_Bit (I);
         bit_attendu := resultat_attendu (I);
         AUnit.Assertions.Assert
         (
            bit_lu = bit_attendu,
            "Le bit " & I'Img &
            " vaut " & bit_lu'Img &
            " au lieu de " & bit_attendu'Img
         );
      end loop;
   end Test_Recuperation;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P.Constructeur_64_P.Test_P;
