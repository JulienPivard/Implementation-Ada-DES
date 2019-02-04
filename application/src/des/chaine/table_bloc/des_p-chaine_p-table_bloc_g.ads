with Des_P.Bloc_P.Bloc_64_P;

private generic

   type Indice_G is range <>;
   --  Les indices des tables de blocs.

--  @summary
--  Des tables de blocs de données.
--  @description
--  Les blocs sont regroupé avec des tables pour accélérer le traitement
--  par les versions parallèle.
--  @group Chaine
package Des_P.Chaine_P.Table_Bloc_G is

   type Indice_T is new Indice_G;
   --  Les indices des tables de blocs.

   type Table_Bloc_T is array (Indice_T range <>)
      of Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
   --  Tableaux de blocs de 64 pour regrouper les données
   --  et augmenter la charge de travail par tâches et ainsi
   --  améliorer les temps d'exécution

end Des_P.Chaine_P.Table_Bloc_G;
