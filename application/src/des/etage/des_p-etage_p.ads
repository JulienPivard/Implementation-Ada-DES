with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Filtre_P;

--  @summary
--  Un étage de DES
--  @description
--  Un étage abstrait de DES paramétré par un filtre.
--  @group Étage
package Des_P.Etage_P
   with Pure
is

   type Etage_Abstrait_T is interface;
   --  Un étage du standard DES.

   function Possede_Filtre
      (Etage : Etage_Abstrait_T)
      return Boolean
   is abstract;
   --  Vérifie si l'étage possède un filtre.
   --  @param Etage
   --  L'étage.
   --  @return L'étage possède un filtre.

   function Possede_Successeur
      (Etage : Etage_Abstrait_T)
      return Boolean
   is abstract;
   --  Vérifie si l'étage possède un successeur.
   --  @param Etage
   --  L'étage.
   --  @return L'étage possède un successeur.

   procedure Ajouter_Successeur
      (
         Etage       : in out Etage_Abstrait_T;
         Successeur  : Etage_Abstrait_T'Class
      )
   is abstract;
   --  Ajoute un successeur à l'étage.
   --  Si l'étage possède déjà un successeur alors on invoque
   --  cette méthode sur le successeur actuel.
   --  @param Etage
   --  L'étage.
   --  @param Successeur
   --  Le Successeur.

   procedure Modifier_Successeur
      (
         Etage       : in out Etage_Abstrait_T;
         Successeur  : Etage_Abstrait_T'Class
      )
   is abstract;
   --  Modifie le successeur de l'étage.
   --  @param Etage
   --  L'étage à modifier.
   --  @param Successeur
   --  Le successeur.

   procedure Modifier_Filtre
      (
         Etage    : in out Etage_Abstrait_T;
         Filtre   : Des_P.Filtre_P.Filtre_Interface_T'Class
      )
   is abstract;
   --  Modifie le filtre de l'étage.
   --  @param Etage
   --  L'étage à modifier.
   --  @param Filtre
   --  Le filtre.

   procedure Iterer
      (
         Etage : Etage_Abstrait_T;
         Bloc  : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
   is abstract;
   --  Déclenche les filtre en cascade jusqu'à ce qu'il n'y ai
   --  plus de successeur.
   --  @param Etage
   --  L'étage.
   --  @param Bloc
   --  Le bloc de 64 bits.

end Des_P.Etage_P;
