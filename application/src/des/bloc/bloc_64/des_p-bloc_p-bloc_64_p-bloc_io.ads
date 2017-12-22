--  @summary
--  Affichage du contenu d'un bloc.
--  @description
--  Affiche le contenu d'un bloc de gauche à droite.
--  À gauche les bits qui apparaissent en premier dans le bloc
--  et à droite les derniers.
--  @group Affichage
package Des_P.Bloc_P.Bloc_64_P.Bloc_IO is

   --  Affiche chaque bits du bloc.
   --  @param Bloc
   --  Le bloc de 32 bits à afficher.
   procedure Put (Bloc : Bloc_64_T);

   --  Affiche sur une ligne chaque bits du bloc.
   --  @param Bloc
   --  Le bloc de 32 bits à afficher.
   procedure Put_Line (Bloc : Bloc_64_T);

end Des_P.Bloc_P.Bloc_64_P.Bloc_IO;
