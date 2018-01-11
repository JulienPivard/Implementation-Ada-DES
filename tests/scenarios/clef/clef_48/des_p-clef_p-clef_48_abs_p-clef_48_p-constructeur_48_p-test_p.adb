with AUnit.Assertions;

package body Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P.Test_P is

   --  La clef de 56 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   champ_bits_de_depart : constant Champ_De_Bits_T :=
      (1 .. 4 | 9 .. 12 | 17 .. 20 | 25 .. 28 | 33 .. 36 |
      41 .. 44 | 49 .. 52 => False, others => True);

   --  La clef de 56 bits:
   --  1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000 1111 0000
   --  Donne la sous clef suivante :
   --  0110 1011 0001 0111 1000 1101 1100 0000 1010 1100 1001 1100
   resultat_attendu : constant Tableau_Bits_T :=
      (
         True, False, False, True, False, True,
         False, False, True, True, True, False,
         True, False, False, False, False, True,
         True, True, False, False, True, False,
         False, False, True, True, True, True,
         True, True, False, True, False, True,
         False, False, True, True, False, True,
         True, False, False, False, True, True
      );

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      const : constant access Constructeur_Clef_48_T :=
         new Constructeur_Clef_48_T;
      clef : Clef_Simplifie_T;
   begin
      clef.Init (champ_bits_de_depart, const);
      T.clef_56 := clef;
      T.constructeur := const;
   end Set_Up;

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      T.constructeur := null;
   end Tear_Down;

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   procedure Test_Preparation (T : in out Test_Fixt_T) is
      bit_attendu : constant Bit_T := False;
   begin
      T.constructeur.all.Preparer_Nouvelle_Clef_48;
      for I in Intervalle_Clef_48_T'Range loop
         AUnit.Assertions.Assert
         (T.constructeur.all.Clef_48.Lire_Bit (I) = bit_attendu,
         "Le bit " & I'Img &
         " vaut " & T.constructeur.all.Clef_48.Lire_Bit (I)'Img &
         " au lieu de " & bit_attendu'Img);
      end loop;
   end Test_Preparation;

   ---------------------------------------------------------------------------
   procedure Test_Construire (T : in out Test_Fixt_T) is
   begin
      T.constructeur.all.Preparer_Nouvelle_Clef_48;
      T.constructeur.all.Construire_Clef_48 (T.clef_56);
      for I in Intervalle_Clef_48_T'Range loop
         AUnit.Assertions.Assert
         (T.constructeur.all.Clef_48.Lire_Bit (I) = resultat_attendu (I),
         "Le bit " & I'Img &
         " vaut " & T.constructeur.all.Clef_48.Lire_Bit (I)'Img &
         " au lieu de " & resultat_attendu (I)'Img);
      end loop;
   end Test_Construire;

   ---------------------------------------------------------------------------
   procedure Test_Recuperation (T : in out Test_Fixt_T) is
      clef_construite : Clef_48_T;
   begin
      T.constructeur.all.Preparer_Nouvelle_Clef_48;
      T.constructeur.all.Construire_Clef_48 (T.clef_56);
      clef_construite := T.constructeur.all.Recuperer_Clef_48;
      for I in Intervalle_Clef_48_T'Range loop
         AUnit.Assertions.Assert
         (clef_construite.Lire_Bit (I) = resultat_attendu (I),
         "Le bit " & I'Img &
         " vaut " & clef_construite.Lire_Bit (I)'Img &
         " au lieu de " & resultat_attendu (I)'Img);
      end loop;
   end Test_Recuperation;

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Constructeur_48_P.Test_P;
