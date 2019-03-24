with AUnit.Assertions;

with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Filtre_P.Clef_Tests_P;

with Des_P.Clef_P.Clef_48_Simplifie_P;

package body Des_P.Filtre_P.Corps_P.Dechiffre_P.Test_P is

   package Bloc_64_R renames Des_P.Bloc_P.Bloc_64_P;

   type Bits_Bloc_64_T is array (Bloc_64_R.Intervalle_T) of Des_P.Bloc_P.Bit_T;

   --  Nombre de départ
   --  00001111 00001111 00001111 00001111
   --  00010100 01010111 11010011 10110101
   Depart : constant Bits_Bloc_64_T := Bits_Bloc_64_T'
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
      Clef : Des_P.Clef_P.Clef_64_Simplifie_P.Clef_S_T;
   begin

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         Bloc.Ecrire_Bit (I, Depart (I));
      end loop;

      T.Filtre := Filtre;
      T.Bloc := Bloc;

      Clef.Init (Des_P.Filtre_P.Clef_Tests_P.Contenu_Clef);
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
   procedure Test_Dechiffrement_Niveau_1
      (T : in out Test_Fixt_T)
   is
      --  Valeur attendu
      --  00001111 00001111 00001111 00001111
      --  00001111 00001111 00001111 00001111
      Attendu : constant Tableau_Bits_64_T :=
         Tableau_Bits_64_T'
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

      --  Valeur attendu
      --  11111000 X0011000 0X110X10 X011 1101 00X10X11 00X10010 11000X11
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T := T.Bloc;
      Champs_48 : constant Des_P.Clef_P.Clef_48_Simplifie_P.Champ_De_Bits_T :=
         Des_P.Clef_P.Clef_48_Simplifie_P.Champ_De_Bits_T'
         (
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True,
            False, False, False, False, True, True, True, True
         );
      Clef_48 : Des_P.Clef_P.Clef_48_Simplifie_P.Clef_S_T;
   begin

      Clef_48.Init (Champs_48);
      T.Filtre.Modifier_Clef (Clef_48);
      T.Filtre.Filtrer (Bloc);

      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         Verification_Bit :
         declare
            B : constant Des_P.Bloc_P.Bit_T := Bloc.Lire_Bit (I);
            Bit_Resulta : constant Bit_IO_T := (if B then 1 else 0);
            Bit_Attendu : constant Bit_IO_T := (if Attendu (I) then 1 else 0);
         begin
            AUnit.Assertions.Assert
               (Bit_Resulta = Bit_Attendu,
               "Le bit " & I'Img &
               " vaut : " & Bit_Resulta'Img &
               " au lieu de " & Bit_Attendu'Img
               );
         end Verification_Bit;
      end loop;

   end Test_Dechiffrement_Niveau_1;

end Des_P.Filtre_P.Corps_P.Dechiffre_P.Test_P;
