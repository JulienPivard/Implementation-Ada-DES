with System.Multiprocessors;

package Des_P.Chaine_P.Limiteur_Jetons_P is

   subtype Nombre_Grappes_T is System.Multiprocessors.CPU_Range;
   --  Le nombre de grappes possible dans le pipeline

   subtype Max_Grappes_T is System.Multiprocessors.CPU;
   --  Le nombre maximum de grappes en même temps
   --  dans le pipeline

   ---------------------------------------
   protected Limiteur_Protegee is
      entry Generer_Bloc_Entree;
      procedure Consommer_Bloc;
      procedure Modifier_Nb_Max_Blocs (Nb : Max_Grappes_T);
   private
      Nb_Blocs_Genere : Nombre_Grappes_T := Nombre_Grappes_T'First;
      Nb_Max_Blocs : Max_Grappes_T :=
         (System.Multiprocessors.Number_Of_CPUs);
      Autorisee : Boolean := True;
   end Limiteur_Protegee;
   --  Limite le nombre maximum de grappes de blocs
   --  à un même moment dans le pipeline.

end Des_P.Chaine_P.Limiteur_Jetons_P;
