with AUnit.Assertions;

with Des_P.Filtre_P.Filtre_Simple_P;
use  Des_P.Filtre_P.Filtre_Simple_P;
with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Simple_P;
use  Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Simple_P;

with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simple_P;

package body Des_P.Etage_P.Filtrage_P.Test_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
      Etage : constant Etage_T := Construire_Etage_Sans_Successeur;
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
         (Etage.Successeur.Is_Empty,
         "L'etage ne devrait pas posseder de successeur."
         );
      AUnit.Assertions.Assert
         (Etage.Possede_Successeur = False,
         "L'etage ne devrait pas posseder de successeur."
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
         (Etage.Successeur.Is_Empty = False,
         "L'etage devrait posseder un successeur."
         );
      AUnit.Assertions.Assert
         (Etage.Possede_Successeur,
         "L'etage ne devrait pas posseder de successeur."
         );
   end Test_Initialisation_Avec_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Modifier_Clef_48
      (T : in out Test_Fixt_T)
   is
      C : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simple_P.Clef_48_Simplifie_T;
   begin
      AUnit.Assertions.Assert
         (T.Etage.Clef.Is_Empty,
         "L'etage ne devrait pas posseder de clef."
         );
      T.Etage.Modifier_Clef (C);
      AUnit.Assertions.Assert
         (T.Etage.Clef.Is_Empty = False,
         "L'etage devrait posseder une clef."
         );
   end Test_Modifier_Clef_48;

   ---------------------------------------------------------------------------
   procedure Test_Ajout_Filtre_Sans_Successeur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
      Etage : Etage_T := Construire_Etage_Sans_Successeur;
      Filtre : Filtre_Simple_T;
   begin
      AUnit.Assertions.Assert
         (
            Etage.Filtre.Is_Empty,
            "L'etage ne devrait pas comporter de filtre."
         );
      AUnit.Assertions.Assert
         (
            not Etage.Possede_Filtre,
            "L'etage ne devrait pas comporter de filtre."
         );
      Etage.Modifier_Filtre (Filtre);
      AUnit.Assertions.Assert
         (
            not Etage.Filtre.Is_Empty,
            "L'etage devrait comporter un filtre."
         );
      AUnit.Assertions.Assert
         (
            Etage.Possede_Filtre,
            "L'etage devrait comporter un filtre."
         );
   end Test_Ajout_Filtre_Sans_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Ajout_Filtre_Avec_Successeur
      (T : in out Test_Fixt_T)
   is
      Etage : Etage_T := Construire_Etage_Avec_Successeur (T.Etage);
      Filtre : Filtre_Simple_T;
   begin
      AUnit.Assertions.Assert
         (
            Etage.Filtre.Is_Empty,
            "L'etage ne devrait pas comporter de filtre."
         );
      Etage.Modifier_Filtre (Filtre);
      AUnit.Assertions.Assert
         (
            not Etage.Filtre.Is_Empty,
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
      Filtre : Filtre_Simple_T;
      attendu, resultat : Boolean;
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      Etage.Modifier_Filtre (Filtre);
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
      Filtre : Filtre_Simple_T;
      attendu, resultat : Boolean;
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      Etage.Modifier_Filtre (Filtre);
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
      Filtre : Filtre_Simple_T;
      attendu, resultat : Boolean;
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      Etage.Modifier_Filtre (Filtre);
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
      Etage : Etage_T;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Clef : Clef_56_T;
      Filtre : Filtre_Simple_T;
      attendu, resultat : Boolean;
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      T.Etage.Modifier_Filtre (Filtre);
      Etage.Modifier_Filtre (Filtre);
      Etage.Modifier_Successeur (T.Etage);
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

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_1_Successeur
      (T : in out Test_Fixt_T)
   is
      Etage : Etage_T;
   begin
      AUnit.Assertions.Assert
         (
            not Etage.Possede_Successeur,
            "L'estage ne devrait pas avoir de successeur"
         );
      Etage.Ajouter_Successeur (T.Etage);
      AUnit.Assertions.Assert
         (
            Etage.Possede_Successeur,
            "L'estage devrait avoir un successeur"
         );
      AUnit.Assertions.Assert
         (
            not Etage.Successeur.Element.Possede_Successeur,
            "L'estage a l'interieur de l'estage ne devrait pas avoir de" &
            " successeur."
         );
   end Test_Ajouter_1_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_2_Successeur
      (T : in out Test_Fixt_T)
   is
      Etage_1 : Etage_T;
      Etage_2 : Etage_T;
   begin
      AUnit.Assertions.Assert
         (
            not Etage_1.Possede_Successeur,
            "L'estage ne devrait pas avoir de successeur"
         );
      Etage_1.Ajouter_Successeur (T.Etage);
      AUnit.Assertions.Assert
         (
            Etage_1.Possede_Successeur,
            "L'estage devrait avoir un successeur"
         );
      AUnit.Assertions.Assert
         (
            not Etage_1.Successeur.Element.Possede_Successeur,
            "L'estage a l'interieur de l'estage ne devrait pas avoir de" &
            " successeur."
         );

      AUnit.Assertions.Assert
         (
            not Etage_2.Possede_Successeur,
            "L'estage ne devrait pas avoir de successeur"
         );
      Etage_1.Ajouter_Successeur (Etage_2);
      AUnit.Assertions.Assert
         (
            Etage_1.Possede_Successeur,
            "L'estage devrait avoir un successeur"
         );
      AUnit.Assertions.Assert
         (
            Etage_1.Successeur.Element.Possede_Successeur,
            "L'estage a l'interieur de l'estage devrait avoir un" &
            " successeur."
         );
   end Test_Ajouter_2_Successeur;

end Des_P.Etage_P.Filtrage_P.Test_P;
