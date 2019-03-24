with Des_P.Chaine_P.Table_Bloc_G;

--  @summary
--  Les instances des versions parallèle.
--  @description
--  Les instances pour les versions parallèles des tables
--  de blocs.
--  @group Chaine Table Blocs
private package Des_P.Chaine_P.Instances_Table_Bloc_P is

   type Indice_Ravenscar_T is range 1 .. 512;
   --  L'intervalle d'indices pour la version ravenscar.
   package Table_Bloc_Ravenscar_P is new Table_Bloc_G (Indice_Ravenscar_T);
   --  L'instance de la version ravenscar.

   type Indice_Taches_T is range 1 .. 512;
   --  L'intervalle d'indices pour la version taches.
   package Table_Bloc_Taches_P    is new Table_Bloc_G (Indice_Taches_T);
   --  L'instance de la version taches.

end Des_P.Chaine_P.Instances_Table_Bloc_P;
