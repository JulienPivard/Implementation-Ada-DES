package body Des_P.Filtre_P.Filtre_Simple_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Filtrer
      (
         Filtre : Filtre_Simple_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
   is
      use Des_P.Bloc_P.Bloc_64_P;
      pragma Unreferenced (Filtre);
   begin
      for I in Intervalle_Bloc_64_T'Range loop
         Bloc.Ecrire_Bit (I, Bloc.Lire_Bit (I) xor True);
      end loop;
   end Filtrer;

end Des_P.Filtre_P.Filtre_Simple_P;
