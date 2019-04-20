with System.Multiprocessors;

--  @summary
--  Limiteur de nombre de jetons.
--  @description
--  Un jeton est une table de blocs de 64 bits.
--  Gère et compte le nombre de jetons total. Permet de bloquer
--  la création de nouveaux jetons et ainsi d'optimiser le
--  travail des versions parallèle.
--  @group Objets Protégé
package Des_P.Chaine_P.Limiteur_Jetons_P is

   subtype Nombre_Grappes_T is System.Multiprocessors.CPU_Range;
   --  Le nombre de grappes possible dans le pipeline

   subtype Max_Grappes_T is System.Multiprocessors.CPU;
   --  Le nombre maximum de grappes en même temps
   --  dans le pipeline

   ---------------------------------------

   protected Limiteur_Protegee is
      entry Generer_Bloc_Entree;
      --  Signal qu'une grappe à été générée.

      procedure Consommer_Bloc
         with Inline;
      --  Signal qu'une grappe à été consommée.

      procedure Modifier_Nb_Max_Blocs
         (Nb : Max_Grappes_T);
      --  Fixe le nombre de grappe présente en même temps dans le pipeline.
      --  Par défaut il y en a autant que de processeurs disponible.
      --  @param Nb
      --  Le nombre maximal de grappe en même temps dans le pipeline
   private
      Nb_Blocs_Genere : Nombre_Grappes_T :=
         Nombre_Grappes_T'First;
      --  Le nombre de blocs en cours de traitement dans le pipeline.
      Nb_Max_Blocs    : Max_Grappes_T    :=
         System.Multiprocessors.Number_Of_CPUs;
      --  Le nombre maximum de blocs qui peuvent être traité en
      --  même temps dans le pipeline.
      Autorisee       : Boolean          :=
         True;
      --  Le limiteur autorise un nouveau bloc à entrer dans
      --  le pipeline de tâches.
   end Limiteur_Protegee;
   --  Limite le nombre maximum de grappes de blocs
   --  à un même moment dans le pipeline.

end Des_P.Chaine_P.Limiteur_Jetons_P;
