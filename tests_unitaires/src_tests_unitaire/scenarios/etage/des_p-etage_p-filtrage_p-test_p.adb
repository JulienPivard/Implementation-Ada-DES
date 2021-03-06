with AUnit.Assertions;

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
         "L'estage ne devrait pas posseder de successeur."
         );
      AUnit.Assertions.Assert
         (Etage.Possede_Successeur = False,
         "L'estage ne devrait pas posseder de successeur."
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
         "L'estage devrait posseder un successeur."
         );
      AUnit.Assertions.Assert
         (Etage.Possede_Successeur,
         "L'estage ne devrait pas posseder de successeur."
         );
   end Test_Initialisation_Avec_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Ajout_Filtre_Sans_Successeur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
      Etage : Etage_T := Construire_Etage_Sans_Successeur;
      Filtre : Filtre_Simple_R.Filtre_Simple_T;
   begin
      AUnit.Assertions.Assert
         (
            Etage.Filtre.Is_Empty,
            "L'estage ne devrait pas comporter de filtre."
         );
      AUnit.Assertions.Assert
         (
            not Etage.Possede_Filtre,
            "L'estage ne devrait pas comporter de filtre."
         );
      Etage.Modifier_Filtre (Filtre);
      AUnit.Assertions.Assert
         (
            not Etage.Filtre.Is_Empty,
            "L'estage devrait comporter un filtre."
         );
      AUnit.Assertions.Assert
         (
            Etage.Possede_Filtre,
            "L'estage devrait comporter un filtre."
         );
   end Test_Ajout_Filtre_Sans_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Ajout_Filtre_Avec_Successeur
      (T : in out Test_Fixt_T)
   is
      Etage : Etage_T := Construire_Etage_Avec_Successeur (T.Etage);
      Filtre : Filtre_Simple_R.Filtre_Simple_T;
   begin
      AUnit.Assertions.Assert
         (
            Etage.Filtre.Is_Empty,
            "L'estage ne devrait pas comporter de filtre."
         );
      Etage.Modifier_Filtre (Filtre);
      AUnit.Assertions.Assert
         (
            not Etage.Filtre.Is_Empty,
            "L'estage devrait comporter un filtre."
         );
   end Test_Ajout_Filtre_Avec_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Filtrer_Sans_Successeur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
      Etage : Etage_T := Construire_Etage_Sans_Successeur;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Filtre : Filtre_Simple_R.Filtre_Simple_T;
      Attendu, Resultat : Boolean;
      use type Des_P.Bloc_P.Bloc_64_P.Intervalle_T;
   begin
      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      Etage.Modifier_Filtre (Filtre);
      Etage.Filtrer (Bloc);
      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         Resultat := Bloc.Lire_Bit (I);
         if (I mod 2) = 0 then
            Attendu := False;
         else
            Attendu := True;
         end if;
         AUnit.Assertions.Assert
            (Resultat = Attendu,
            "Le bit : " & I'Img &
            " vaut : " & Resultat'Img &
            " au lieu de : " & Attendu'Img
            );
      end loop;
   end Test_Filtrer_Sans_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Filtrer_Avec_Successeur
      (T : in out Test_Fixt_T)
   is
      Etage : Etage_T := Construire_Etage_Avec_Successeur (T.Etage);
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Filtre : Filtre_Simple_R.Filtre_Simple_T;
      Attendu, Resultat : Boolean;
      use type Des_P.Bloc_P.Bloc_64_P.Intervalle_T;
   begin
      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      Etage.Modifier_Filtre (Filtre);
      Etage.Filtrer (Bloc);
      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         Resultat := Bloc.Lire_Bit (I);
         if (I mod 2) = 0 then
            Attendu := False;
         else
            Attendu := True;
         end if;
         AUnit.Assertions.Assert
            (Resultat = Attendu,
            "Le bit : " & I'Img &
            " vaut : " & Resultat'Img &
            " au lieu de : " & Attendu'Img
            );
      end loop;
   end Test_Filtrer_Avec_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Iterer_Sans_Successeur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
      Etage : Etage_T := Construire_Etage_Sans_Successeur;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Filtre : Filtre_Simple_R.Filtre_Simple_T;
      Attendu, Resultat : Boolean;
      use type Des_P.Bloc_P.Bloc_64_P.Intervalle_T;
   begin
      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      Etage.Modifier_Filtre (Filtre);
      Etage.Iterer (Bloc);
      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         Resultat := Bloc.Lire_Bit (I);
         if (I mod 2) = 0 then
            Attendu := False;
         else
            Attendu := True;
         end if;
         AUnit.Assertions.Assert
            (Resultat = Attendu,
            "Le bit : " & I'Img &
            " vaut : " & Resultat'Img &
            " au lieu de : " & Attendu'Img
            );
      end loop;
   end Test_Iterer_Sans_Successeur;

   ---------------------------------------------------------------------------
   procedure Test_Iterer_Avec_Successeur
      (T : in out Test_Fixt_T)
   is
      Etage : Etage_T;
      Bloc : Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
      Filtre : Filtre_Simple_R.Filtre_Simple_T;
      Attendu, Resultat : Boolean;
      use type Des_P.Bloc_P.Bloc_64_P.Intervalle_T;
   begin
      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         if (I mod 2) = 0 then
            Bloc.Ecrire_Bit (I, True);
         else
            Bloc.Ecrire_Bit (I, False);
         end if;
      end loop;
      T.Etage.Modifier_Filtre (Filtre);
      Etage.Modifier_Filtre (Filtre);
      Etage.Modifier_Successeur (T.Etage);
      Etage.Iterer (Bloc);
      for I in Des_P.Bloc_P.Bloc_64_P.Intervalle_T loop
         Resultat := Bloc.Lire_Bit (I);
         if (I mod 2) = 0 then
            Attendu := True;
         else
            Attendu := False;
         end if;
         AUnit.Assertions.Assert
            (Resultat = Attendu,
            "Le bit : " & I'Img &
            " vaut : " & Resultat'Img &
            " au lieu de : " & Attendu'Img
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
