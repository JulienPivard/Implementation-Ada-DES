with Des_P.Bloc_P.Bloc_32_P;

--  @summary
--  Un bloc de 64 bits de données.
--  @description
--  Cette représentation permet de manipuler facilement des
--  blocs de 64 bits sans avoir à en connaitre le détail.
--  @group Bloc
package Des_P.Bloc_P.Bloc_64_P is

   pragma Pure;

   --  L'intervalle pour accéder aux bits du bloc de 64 bits.
   type Intervalle_Bloc_64_T is range 1 .. 64;

   --  Représente un bloc de 64 bits.
   type Bloc_64_T is new Bloc_Abstrait_T with private;

   --  Désigne le bloc de gauche ou le bloc de droite.
   --  @value Gauche
   --  Le bloc de 32 bits de gauche.
   --  @value Droite
   --  Le bloc de 32 bits de droite.
   type Position_Bloc_T is (Gauche, Droite);

   overriding
   --  Création d'un bloc de 64 bits avec la valeur 0.
   --  @param B
   --  Le bloc de 64 bits.
   procedure Initialize (B : in out Bloc_64_T);

   overriding
   --  Supprime le bloc.
   --  @param B
   --  Le bloc de 64 bits.
   procedure Finalize (B : in out Bloc_64_T);

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param B
   --  Le bloc de 64 bits.
   procedure Adjust (B : in out Bloc_64_T);

   --  Intervertit les blocs de 32 bits gauche et droite.
   --  @param B
   --  Le bloc de 64 bits.
   procedure Intervertir_Blocs (B : in out Bloc_64_T);

   --  Écrit le bit à la position demandé dans le bloc de 64.
   --  @param B
   --  Le bloc de 64 bits.
   --  @param Position
   --  La position du bit qu'on veut écrire.
   --  @param Bit
   --  Le bit qu'on veut écrire.
   procedure Ecrire_Bit
   (
      B : in out Bloc_64_T;
      Position : Intervalle_Bloc_64_T;
      Bit : Bit_T
   );

   --  Lit le bit demandé dans le bloc de 64.
   --  @param B
   --  Le bloc de 64 bits.
   --  @param Position
   --  La position du bit qu'on veut lire.
   --  @return Le bit demandé.
   function Lire_Bit
   (
      B : Bloc_64_T;
      Position : Intervalle_Bloc_64_T
   ) return Bit_T;

   --  Écrit le bit à la position demandé dans le bloc
   --  gauche de 32 bits du bloc de 64.
   --  @param B
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc gauche ou droite à écrire.
   --  @param Position
   --  La position du bit qu'on veut écrire dans le bloc gauche.
   --  @param Bit
   --  Le bit qu'on veut écrire.
   procedure Ecrire_Bit_Bloc
   (
      B : in out Bloc_64_T;
      Bloc_G_Ou_D : Position_Bloc_T;
      Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_Bloc_32_T;
      Bit : Bit_T
   );

   --  Lit le bit à la position demandé dans le bloc
   --  de 32 bits, gauche ou droit, du bloc de 64.
   --  @param B
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc gauche ou droite à lire.
   --  @param Position
   --  La position du bit qu'on veut lire dans le bloc gauche ou droit.
   --  @return Le bit lu.
   function Lire_Bit_Bloc
   (
      B : Bloc_64_T;
      Bloc_G_Ou_D : Position_Bloc_T;
      Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_Bloc_32_T
   ) return Bit_T;

private

   --  Type modulaire permettant de connaitre le bloc de droite.
   type Decalage_T is mod 2;

   --  Les deux blocs de 32 bits. Celui de gauche est placé en
   --  position 1 et celui de droite est placé en position 1
   --  Les blocs ne sont jamais réellement échangé mais
   --  seulement décalé grâce à un opérateur de décalage.
   type Tableau_Bloc_T is array
      (Decalage_T range Decalage_T'Range)
      of Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;

   type Bloc_64_T is new Bloc_Abstrait_T with
      record
         Blocs_32 : Tableau_Bloc_T;
         Decalage : Decalage_T;
      end record;

end Des_P.Bloc_P.Bloc_64_P;
