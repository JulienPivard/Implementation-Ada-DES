with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Filtre_P;

private with Ada.Containers.Indefinite_Holders;
private with Des_P.Filtre_P.Holder_P;

--  @summary
--  Un étage de DES
--  @description
--  Un étage de DES paramétré par un filtre.
--  @group Étage
package Des_P.Etage_P.Filtrage_P is

   Pas_De_Filtre_E : exception;

   type Etage_T is new Etage_Abstrait_T with private;
   --  Un étage du standard DES.

   function Construire_Etage_Sans_Successeur return Etage_T;
   --  Construit un étage sans successeur.
   --  @return Un nouvel étage sans successeur.

   function Construire_Etage_Avec_Successeur
      (Successeur : Etage_Abstrait_T'Class)
      return Etage_T;
   --  Construit un étage avec un successeur.
   --  @param Successeur
   --  Le successeur de l'étage qui va être créé.
   --  @return Un nouvel étage avec un successeur.

   overriding
   function Possede_Filtre
      (Etage : Etage_T)
      return Boolean
      with Inline;
   --  Vérifie si l'étage possède un filtre.
   --  @param Etage
   --  L'étage.
   --  @return L'étage possède un filtre.

   overriding
   function Possede_Successeur
      (Etage : Etage_T)
      return Boolean
      with Inline;
   --  Vérifie si l'étage possède un successeur.
   --  @param Etage
   --  L'étage.
   --  @return L'étage possède un successeur.

   overriding
   procedure Ajouter_Successeur
      (
         Etage : in out Etage_T;
         Successeur : Etage_Abstrait_T'Class
      );
   --  Ajoute un successeur à l'étage.
   --  Si l'étage possède déjà un successeur alors on invoque
   --  cette méthode sur le successeur actuel.
   --  @param Etage
   --  L'étage.
   --  @param Successeur
   --  Le Successeur.

   overriding
   procedure Modifier_Successeur
      (
         Etage : in out Etage_T;
         Successeur : Etage_Abstrait_T'Class
      );
   --  Modifie le successeur de l'étage.
   --  @param Etage
   --  L'étage à modifier.
   --  @param Successeur
   --  Le successeur.

   overriding
   procedure Modifier_Filtre
      (
         Etage : in out Etage_T;
         Filtre : Des_P.Filtre_P.Filtre_Interface_T'Class
      );
   --  Modifie le filtre de l'étage.
   --  @param Etage
   --  L'étage à modifier.
   --  @param Filtre
   --  Le filtre.

   overriding
   procedure Iterer
      (
         Etage : Etage_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
      with Pre => Etage.Possede_Filtre;
   --  Déclenche les filtre en cascade jusqu'à ce qu'il n'y ai
   --  plus de successeur.
   --  @param Etage
   --  L'étage.
   --  @param Bloc
   --  Le bloc de 64 bits.

private

   procedure Filtrer
      (
         Etage : Etage_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
      with Pre => Etage.Possede_Filtre;
   --  Filtre le bloc de 64 bits avec une clef.
   --  @param Etage
   --  L'étage.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Clef
   --  la clef de 56 bits.

   package Holder_P is new Ada.Containers.Indefinite_Holders
      (Etage_Abstrait_T'Class);

   type Etage_T is new Etage_Abstrait_T with
      record
         Filtre : Des_P.Filtre_P.Holder_P.Holder;
         Successeur : Holder_P.Holder;
      end record;

end Des_P.Etage_P.Filtrage_P;
