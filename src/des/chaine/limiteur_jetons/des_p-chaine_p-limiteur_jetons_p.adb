package body Des_P.Chaine_P.Limiteur_Jetons_P is

   --------------------------------------------------------------------
   protected body Limiteur_Protegee is
      ---------------------------------------------------------
      entry Generer_Bloc_Entree
         when Autorisee
      is
         use type System.Multiprocessors.CPU_Range;
      begin
         --  Incrémentation du nombre de bloc dans le pipeline
         Nb_Blocs_Genere := Nombre_Grappes_T'Succ (Nb_Blocs_Genere);
         Autorisee       := Nb_Blocs_Genere <= Nb_Max_Blocs;
      end Generer_Bloc_Entree;

      ---------------------------------------------------------
      procedure Modifier_Nb_Max_Blocs
         (Nb : Max_Grappes_T)
      is
      begin
         Nb_Max_Blocs := Nb;
      end Modifier_Nb_Max_Blocs;

      ---------------------------------------------------------
      procedure Consommer_Bloc
      is
         use type System.Multiprocessors.CPU_Range;
      begin
         --  Décrémentation du nombre de bloc dans le pipeline
         Nb_Blocs_Genere := Nombre_Grappes_T'Pred (Nb_Blocs_Genere);
         Autorisee       := Nb_Blocs_Genere <= Nb_Max_Blocs;
      end Consommer_Bloc;
      ---------------------------------------------------------
   end Limiteur_Protegee;

end Des_P.Chaine_P.Limiteur_Jetons_P;
