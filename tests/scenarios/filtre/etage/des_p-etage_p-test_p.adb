with AUnit.Assertions;

with Des_P.Filtre_P.Filtre_Simple_P;
use  Des_P.Filtre_P.Filtre_Simple_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Simple_P;
use  Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Simple_P;

package body Des_P.Etage_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      Etage : constant access Etage_T := new Etage_T (False);
   begin
      T.Etage := Etage;
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
   procedure Test_Initialisation_Sans_Successeur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
      Etage : constant Etage_T := Construire_Etage_Sans_Successeur;
   begin
      AUnit.Assertions.Assert
         (Etage.Avec_Successeur = False,
         "L'etage ne devrai pas posseder de successeur."
         );
      AUnit.Assertions.Assert
         (Etage.Possede_Successeur = False,
         "L'etage ne devrai pas posseder de successeur."
         );
   end Test_Initialisation_Sans_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Initialisation_Avec_Successeur
      (T : in out Test_Fixt_T)
   is
      Etage : constant Etage_T :=
         Construire_Etage_Avec_Successeur (T.Etage);
   begin
      AUnit.Assertions.Assert
         (Etage.Avec_Successeur,
         "L'etage devrai posseder un successeur."
         );
      AUnit.Assertions.Assert
         (Etage.Possede_Successeur,
         "L'etage ne devrai pas posseder de successeur."
         );
   end Test_Initialisation_Avec_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Ajout_Filtre_Sans_Successeur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
      Etage : Etage_T := Construire_Etage_Sans_Successeur;
      Filtre : constant access Filtre_Simple_T := new Filtre_Simple_T;
   begin
      AUnit.Assertions.Assert
         (
            Etage.Filtre = null,
            "L'etage ne devrait pas comporter de filtre."
         );
      Etage.Ajouter_Filtre (Filtre);
      AUnit.Assertions.Assert
         (
            Etage.Filtre /= null,
            "L'etage devrait comporter un filtre."
         );
   end Test_Ajout_Filtre_Sans_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Ajout_Filtre_Avec_Successeur
      (T : in out Test_Fixt_T)
   is
      Etage : Etage_T := Construire_Etage_Avec_Successeur (T.Etage);
      Filtre : constant access Filtre_Simple_T := new Filtre_Simple_T;
   begin
      AUnit.Assertions.Assert
         (
            Etage.Filtre = null,
            "L'etage ne devrait pas comporter de filtre."
         );
      Etage.Ajouter_Filtre (Filtre);
      AUnit.Assertions.Assert
         (
            Etage.Filtre /= null,
            "L'etage devrait comporter un filtre."
         );
   end Test_Ajout_Filtre_Avec_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Filtrer_Sans_Successeur
      (T : in out Test_Fixt_T)
   is
      use Des_P.Bloc_P.Bloc_64_P;
      pragma Unreferenced (T);
      Etage : Etage_T := Construire_Etage_Sans_Successeur;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Clef : Clef_56_T;
      Filtre : constant access Filtre_Simple_T := new Filtre_Simple_T;
      attendu, resultat : Boolean;
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      Etage.Ajouter_Filtre (Filtre);
      Etage.Filtrer (Bloc, Clef);
      for I in Intervalle_Bloc_64_T'Range loop
         resultat := Bloc.Lire_Bit (I);
         if (I mod 2) = 0 then
            attendu := False;
         else
            attendu := True;
         end if;
         AUnit.Assertions.Assert
            (resultat = attendu,
            "Le bit : " & I'Img &
            " vaut : " & resultat'Img &
            " au lieu de : " & attendu'Img
            );
      end loop;
   end Test_Filtrer_Sans_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Filtrer_Avec_Successeur
      (T : in out Test_Fixt_T)
   is
      use Des_P.Bloc_P.Bloc_64_P;
      Etage : Etage_T := Construire_Etage_Avec_Successeur (T.Etage);
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Clef : Clef_56_T;
      Filtre : constant access Filtre_Simple_T := new Filtre_Simple_T;
      attendu, resultat : Boolean;
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      Etage.Ajouter_Filtre (Filtre);
      Etage.Filtrer (Bloc, Clef);
      for I in Intervalle_Bloc_64_T'Range loop
         resultat := Bloc.Lire_Bit (I);
         if (I mod 2) = 0 then
            attendu := False;
         else
            attendu := True;
         end if;
         AUnit.Assertions.Assert
            (resultat = attendu,
            "Le bit : " & I'Img &
            " vaut : " & resultat'Img &
            " au lieu de : " & attendu'Img
            );
      end loop;
   end Test_Filtrer_Avec_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Iterer_Sans_Successeur
      (T : in out Test_Fixt_T)
   is
      use Des_P.Bloc_P.Bloc_64_P;
      pragma Unreferenced (T);
      Etage : Etage_T := Construire_Etage_Sans_Successeur;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Clef : Clef_56_T;
      Filtre : constant access Filtre_Simple_T := new Filtre_Simple_T;
      attendu, resultat : Boolean;
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      Etage.Ajouter_Filtre (Filtre);
      Etage.Iterer (Bloc, Clef);
      for I in Intervalle_Bloc_64_T'Range loop
         resultat := Bloc.Lire_Bit (I);
         if (I mod 2) = 0 then
            attendu := False;
         else
            attendu := True;
         end if;
         AUnit.Assertions.Assert
            (resultat = attendu,
            "Le bit : " & I'Img &
            " vaut : " & resultat'Img &
            " au lieu de : " & attendu'Img
            );
      end loop;
   end Test_Iterer_Sans_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Iterer_Avec_Successeur
      (T : in out Test_Fixt_T)
   is
      use Des_P.Bloc_P.Bloc_64_P;
      Etage : Etage_T := Construire_Etage_Avec_Successeur (T.Etage);
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Clef : Clef_56_T;
      Filtre : constant access Filtre_Simple_T := new Filtre_Simple_T;
      attendu, resultat : Boolean;
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      T.Etage.all.Ajouter_Filtre (Filtre);
      Etage.Ajouter_Filtre (Filtre);
      Etage.Iterer (Bloc, Clef);
      for I in Intervalle_Bloc_64_T'Range loop
         resultat := Bloc.Lire_Bit (I);
         if (I mod 2) = 0 then
            attendu := True;
         else
            attendu := False;
         end if;
         AUnit.Assertions.Assert
            (resultat = attendu,
            "Le bit : " & I'Img &
            " vaut : " & resultat'Img &
            " au lieu de : " & attendu'Img
            );
      end loop;
   end Test_Iterer_Avec_Successeur;

end Des_P.Etage_P.Test_P;
