private with Des_P.Clef_P.Clef_56_I_P;

--  @summary
--  Interface de chaine de filtre.
--  @description
--  Permet de gérer la chaine de filtre par laquelle vont passer
--  tout les blocs de données du fichier pour être manipulé.
--  @group Chaine
package Des_P.Chaine_P
   with Pure
is

   type Chaine_Interface_T is interface;
   --  L'interface de la chaine de filtre.

   procedure Filtrer
      (
         Chaine      : Chaine_Interface_T;
         Nom_Fichier : String;
         Extension   : String
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

   type Table_Decalage_T is array (Numero_Filtre_T)
      of Des_P.Clef_P.Clef_56_I_P.Decalage_T;

   pragma Annotate
      (
         gnatcheck,
         Exempt_On,
         "Positional_Components",
         "Tableau trop grand pour positionner toutes les valeurs"
      );
   Table_Decalage : constant Table_Decalage_T :=
      Table_Decalage_T'
      (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1);
   pragma Annotate
      (
         gnatcheck,
         Exempt_Off,
         "Positional_Components"
      );
   --  Table pour connaitre le nombre de décalages à appliquer à la clef

end Des_P.Chaine_P;
