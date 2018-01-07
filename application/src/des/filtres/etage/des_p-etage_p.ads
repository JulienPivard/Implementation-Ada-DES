with Des_P.Clef_P.Clef_56_Abs_P;
with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Filtre_P;

--  @summary
--  Un étage de DES
--  @description
--  Un étage de DES paramétré par un filtre qui va porter toutes ces
--  particularité.
--  @group Filtre
package Des_P.Etage_P is

   pragma Pure;

   Pas_De_Filtre_E : exception;

   --  Un étage du standard DES.
   type Etage_T (<>) is tagged private;

   --  Construit un étage sans successeur.
   --  @return Un nouvel étage sans successeur.
   function Construire_Etage_Sans_Successeur return Etage_T;

   --  Construit un étage avec un successeur.
   --  @param Successeur
   --  Le successeur de l'étage qui va être créé.
   --  @return Un nouvel étage qui contient un étage successeur.
   function Construire_Etage_Avec_Successeur
      (Successeur : not null access Etage_T)
      return Etage_T;

   --  Ajoute un filtre à l'étage.
   --  @param Etage
   --  L'étage auquel on ajoute un filtre.
   --  @param Filtre
   --  Le filtre.
   procedure Ajouter_Filtre
      (
         Etage : in out Etage_T;
         Filtre : not null access Des_P.Filtre_P.Filtre_Abstrait_T'Class
      );

   --  Filtre le bloc de 64 bits avec une clef.
   --  @param Etage
   --  L'étage.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Clef
   --  la clef de 56 bits.
   procedure Filtrer
      (
         Etage : Etage_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      );

   --  Vérifie si l'étage possède un successeur.
   --  @param Etage
   --  L'étage.
   --  @return L'étage possède un successeur.
   function Possede_Successeur (Etage : Etage_T) return Boolean;

   --  Déclenche les filtre en cascade jusqu'à ce qu'il n'y ai
   --  plus de successeur.
   --  @param Etage
   --  L'étage.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Clef
   --  la clef de 56 bits.
   procedure Iterer
      (
         Etage : Etage_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      );

private

   type Etage_T (Avec_Successeur : Boolean) is tagged
      record
         Filtre : access Des_P.Filtre_P.Filtre_Abstrait_T'Class;
         case Avec_Successeur is
            when True =>
               Successeur : access Etage_T;
            when False =>
               null;
         end case;
      end record;

end Des_P.Etage_P;
