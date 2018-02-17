with AUnit.Assertions;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P;
with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;

package body Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Test_P is

   --  Nombre de départ
   --  11110000 11110000 11110000 11110000
   --  11110000 11110000 11110000 11110000
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
   begin

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T'Range loop
         Bloc.Ecrire_Bit (I, depart (I));
      end loop;

      Filtre.Modifier_Numero (1);
      T.Filtre := Filtre;
      T.Bloc := Bloc;

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
   procedure Test_Cryptage_Niveau_1
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

      use Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P;
      --  Valeur attendu
      --  11111000 X0011000 0X110X10 X0111101 00X10X11 00X10010 11000X11
      contenu_clef : constant Champ_De_Bits_T :=
         (
            True, True, True, True, True, False, False, False,
            True, False, False, True, True, False, False, False,
            False, True, True, True, False, True, True, False,
            True, False, True, True, True, True, False, True,
            False, False, True, True, False, True, True, True,
            False, False, True, True, False, False, True, False,
            True, True, False, False, False, True, True, True
         );
      use Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P;
      Clef : Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P.Clef_Simplifie_T;
      Constructeur : constant access Constructeur_Clef_48_T :=
         new Constructeur_Clef_48_T;
   begin

      Clef.Init (contenu_clef, Constructeur);

      T.Filtre.Filtrer (T.Bloc, Clef);

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_Bloc_64_T'Range loop
         declare
            b : constant Des_P.Bloc_P.Bit_T := T.Bloc.Lire_Bit (I);
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

   end Test_Cryptage_Niveau_1;

end Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Test_P;
