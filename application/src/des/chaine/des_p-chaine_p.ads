private with Des_P.Clef_P.Clef_56_I_P;

--  @summary
--  Interface de chaine de filtre.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P is

   pragma Pure;

   type Chaine_Interface_T is interface;
   --  L'interface de la chaine de filtre.

   procedure Filtrer
      (
         Chaine : Chaine_Interface_T;
         Nom_Fichier : String;
         Extension : String
      )
   is abstract;
   --  Lance le filtrage du fichier avec la clef. La version chiffré ou
   --  déchiffré est écrite dans un autre fichier avec l'extension chiffre ou
   --  dechiffre selon le filtrage effectué.
   --  @param Chaine
   --  La chaine de filtre.
   --  @param Nom_Fichier
   --  Le nom du fichier à chiffrer déchiffrer.
   --  @param Extension
   --  Extension du fichiers de sortie.

private

   type Numero_Filtre_T is range 1 .. 16;
   --  La position du filtre dans la chaine.

   Table_Decalage : constant
      array (Numero_Filtre_T)
      of Des_P.Clef_P.Clef_56_I_P.Decalage_T :=
      (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1);
   --  Table pour connaitre le nombre de décalages à appliquer à la clef

end Des_P.Chaine_P;
