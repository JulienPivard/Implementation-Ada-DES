package body Des_P.Filtre_P.Filtre_Simple_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Modifier_Numero
      (
         Filtre : in out Filtre_Simple_T;
         Numero : Numero_Filtre_T
      ) is
      pragma Unreferenced (Filtre);
      pragma Unreferenced (Numero);
   begin
      null;
   end Modifier_Numero;

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Filtre : Filtre_Simple_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      )
   is
      use Des_P.Bloc_P.Bloc_64_P;
      pragma Unreferenced (Clef);
      pragma Unreferenced (Filtre);
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         Bloc.Ecrire_Bit (I, Bloc.Lire_Bit (I) xor True);
      end loop;
   end Filtrer;

end Des_P.Filtre_P.Filtre_Simple_P;
