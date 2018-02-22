with AUnit.Assertions;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;
with Des_P.Filtre_P.Clef_Tests_P;

with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simplifie_P;

package body Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Test_P is

   --  Nombre de départ
   --  00001111 00001111 00001111 00001111
   --  00010100 01010111 11010011 10110101
   depart : constant array
      (Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T)
      of Des_P.Bloc_P.Bit_T :=
      (
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, False, True, True, True, True,
         False, False, False, True, False, True, False, False,
         False, True, False, True, False, True, True, True,
         True, True, False, True, False, False, True, True,
         True, False, True, True, False, True, False, True
      );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      Filtre : Corps_T;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;

      use Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
      use Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Constructeur_56_P;
      Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_Simple_P.Clef_Simple_T;
      Constructeur_48 : constant access Constructeur_Clef_48_T :=
         new Constructeur_Clef_48_T;
      Constructeur_56 : constant access Constructeur_Clef_56_T :=
         new Constructeur_Clef_56_T;
   begin

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T'Range loop
         Bloc.Ecrire_Bit (I, depart (I));
      end loop;

      T.Filtre := Filtre;
      T.Bloc := Bloc;

      Clef.Init
         (
            Des_P.Filtre_P.Clef_Tests_P.contenu_clef,
            Constructeur_56,
            Constructeur_48
         );
      T.Clef := Clef;

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
   procedure Test_Decryptage_Niveau_1
      (T : in out Test_Fixt_T)
   is
      --  Valeur attendu
      --  00001111 00001111 00001111 00001111
      --  00001111 00001111 00001111 00001111
      attendu : constant array
         (Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T)
         of Des_P.Bloc_P.Bit_T :=
         (
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True
         );

      use type Des_P.Clef_P.Clef_56_Abs_P.Decalage_T;

      --  Valeur attendu
      --  11111000 X0011000 0X110X10 X011 1101 00X10X11 00X10010 11000X11
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T := T.Bloc;
      Champs_48 : constant
      Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simplifie_P.Champ_De_Bits_T :=
         (
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True
         );
      Clef_48 : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simplifie_P.Clef_48_T;
   begin

      Clef_48.Init (Champs_48);
      T.Filtre.Modifier_Clef (Clef_48);
      T.Filtre.Filtrer (Bloc);

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T'Range loop
         declare
            b : constant Des_P.Bloc_P.Bit_T := Bloc.Lire_Bit (I);
            bit_resulta : constant Bit_IO_T := (if b then 1 else 0);
            bit_attendu : constant Bit_IO_T := (if attendu (I) then 1 else 0);
         begin
            AUnit.Assertions.Assert
               (bit_resulta = bit_attendu,
               "Le bit " & I'Img &
               " vaut : " & bit_resulta'Img &
               " au lieu de " & bit_attendu'Img
               );
         end;
      end loop;

   end Test_Decryptage_Niveau_1;

end Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Test_P;
