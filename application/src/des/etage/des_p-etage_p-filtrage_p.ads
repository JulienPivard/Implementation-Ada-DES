with Des_P.Clef_P.Clef_56_Abs_P;
with Des_P.Bloc_P.Bloc_64_P;
with Des_P.Filtre_P;

private with Ada.Containers.Indefinite_Holders;
private with Des_P.Filtre_P.Holder_P;
private with Des_P.Clef_P.Clef_48_Abs_P.Holder_P;

--  @summary
--  Un étage de DES
--  @description
--  Un étage de DES paramétré par un filtre.
--  @group Étage
package Des_P.Etage_P.Filtrage_P is

   Pas_De_Filtre_E : exception;

   --  Un étage du standard DES.
   type Etage_T is new Etage_Abstrait_T with private;

   --  Construit un étage sans successeur.
   --  @return Un nouvel étage sans successeur.
   function Construire_Etage_Sans_Successeur return Etage_T;

   --  Construit un étage avec un successeur.
   --  @param Successeur
   --  Le successeur de l'étage qui va être créé.
   --  @return Un nouvel étage avec un successeur.
   function Construire_Etage_Avec_Successeur
      (Successeur : Etage_Abstrait_T'Class)
      return Etage_T;

   overriding
   --  Vérifie si l'étage possède un filtre.
   --  @param Etage
   --  L'étage.
   --  @return L'étage possède un filtre.
   function Possede_Filtre (Etage : Etage_T) return Boolean;

   overriding
   --  Vérifie si l'étage possède un successeur.
   --  @param Etage
   --  L'étage.
   --  @return L'étage possède un successeur.
   function Possede_Successeur (Etage : Etage_T) return Boolean;

   overriding
   --  Ajoute un successeur à l'étage.
   --  Si l'étage possède déjà un successeur alors on invoque
   --  cette méthode sur le successeur actuel.
   --  @param Etage
   --  L'étage.
   --  @param Successeur
   --  Le Successeur.
   procedure Ajouter_Successeur
      (
         Etage : in out Etage_T;
         Successeur : Etage_Abstrait_T'Class
      );

   overriding
   --  Modifie le successeur de l'étage.
   --  @param Etage
   --  L'étage à modifier.
   --  @param Successeur
   --  Le successeur.
   procedure Modifier_Successeur
      (
         Etage : in out Etage_T;
         Successeur : Etage_Abstrait_T'Class
      );

   overriding
   --  Modifie le filtre de l'étage.
   --  @param Etage
   --  L'étage à modifier.
   --  @param Filtre
   --  Le filtre.
   procedure Modifier_Filtre
      (
         Etage : in out Etage_T;
         Filtre : Des_P.Filtre_P.Filtre_Interface_T'Class
      );

   overriding
   --  Modifie la clef de 48 bits.
   --  @param Etage
   --  L'étage.
   --  @param Clef
   --  la clef de 56 bits.
   procedure Modifier_Clef
      (
         Etage : in out Etage_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abs_T'Class
      );

   overriding
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

   package Holder_P is new Ada.Containers.Indefinite_Holders
      (Etage_Abstrait_T'Class);

   type Etage_T is new Etage_Abstrait_T with
      record
         Filtre : Des_P.Filtre_P.Holder_P.Holder;
         Successeur : Holder_P.Holder;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Holder_P.Holder;
      end record;

end Des_P.Etage_P.Filtrage_P;
