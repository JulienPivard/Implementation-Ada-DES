package body Des_P.Bloc_P.Bloc_64_P.Permutations_P is

   ---------------------------------------------------------------------------
   procedure Permutation_Entrante
      (Bloc : in out Bloc_64_T)
   is
      --  La table de permutation IP
      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      Table : constant Table_Permutations_T :=
         Table_Permutations_T'
         (
            58, 50, 42, 34, 26, 18, 10, 2,
            60, 52, 44, 36, 28, 20, 12, 4,
            62, 54, 46, 38, 30, 22, 14, 6,
            64, 56, 48, 40, 32, 24, 16, 8,
            57, 49, 41, 33, 25, 17, 9, 1,
            59, 51, 43, 35, 27, 19, 11, 3,
            61, 53, 45, 37, 29, 21, 13, 5,
            63, 55, 47, 39, 31, 23, 15, 7
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );
      --  On copie le bloc dans un nouveau bloc pour
      --  conserver la configuration initial du bloc.
      B : constant Bloc_64_T := Bloc;
   begin
      --  Écrit les permutations dans le nouveau bloc.
      for I in Intervalle_T loop
         Bloc.Ecrire_Bit (I, B.Lire_Bit (Table (I)));
      end loop;
   end Permutation_Entrante;

   ---------------------------------------------------------------------------
   procedure Permutation_Sortante
      (Bloc : in out Bloc_64_T)
   is
      --  La table de permutation IP-1
      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      Table : constant Table_Permutations_T :=
         Table_Permutations_T'
         (
            40, 8, 48, 16, 56, 24, 64, 32,
            39, 7, 47, 15, 55, 23, 63, 31,
            38, 6, 46, 14, 54, 22, 62, 30,
            37, 5, 45, 13, 53, 21, 61, 29,
            36, 4, 44, 12, 52, 20, 60, 28,
            35, 3, 43, 11, 51, 19, 59, 27,
            34, 2, 42, 10, 50, 18, 58, 26,
            33, 1, 41,  9, 49, 17, 57, 25
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );
      --  On copie le bloc dans un nouveau bloc pour
      --  conserver la configuration initial du bloc.
      B : constant Bloc_64_T := Bloc;
   begin
      --  Écrit les permutations dans le nouveau bloc.
      for I in Intervalle_T loop
         Bloc.Ecrire_Bit (I, B.Lire_Bit (Table (I)));
      end loop;
   end Permutation_Sortante;

end Des_P.Bloc_P.Bloc_64_P.Permutations_P;
