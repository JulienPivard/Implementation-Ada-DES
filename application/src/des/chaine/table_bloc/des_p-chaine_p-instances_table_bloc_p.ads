with Des_P.Chaine_P.Table_Bloc_G;

private package Des_P.Chaine_P.Instances_Table_Bloc_P is

   type Indice_Ravenscar_T is range 1 .. 512;
   package Table_Bloc_Ravenscar_P is new Table_Bloc_G (Indice_Ravenscar_T);

   type Indice_Taches_T is range 1 .. 512;
   package Table_Bloc_Taches_P    is new Table_Bloc_G (Indice_Taches_T);

end Des_P.Chaine_P.Instances_Table_Bloc_P;
