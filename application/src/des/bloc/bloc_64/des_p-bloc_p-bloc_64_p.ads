with Des_P.Bloc_P.Bloc_32_P;

--  @summary
--  Un bloc de 64 bits de données.
--  @description
--  Cette représentation permet de manipuler facilement des
--  blocs de 64 bits sans avoir à en connaitre le détail.
--  @group Bloc
package Des_P.Bloc_P.Bloc_64_P
   with Pure
is

   type Intervalle_T is range 1 .. 64;
   --  L'intervalle pour accéder aux bits du bloc de 64 bits.

   type Bloc_64_T is new Bloc_Abstrait_T with private;
   --  Représente un bloc de 64 bits.

   type Position_Bloc_T is (Gauche, Droite);
   --  Désigne le bloc de 32 bits de gauche ou le bloc de droite.
   --  @value Gauche
   --  Le bloc de 32 bits de gauche.
   --  @value Droite
   --  Le bloc de 32 bits de droite.

   overriding
   procedure Initialize
      (Bloc : in out Bloc_64_T);
   --  Création d'un bloc de 64 bits avec la valeur 0.
   --  @param Bloc
   --  Le bloc de 64 bits.

   overriding
   procedure Finalize
      (Bloc : in out Bloc_64_T);
   --  Supprime le bloc.
   --  @param Bloc
   --  Le bloc de 64 bits.

   overriding
   procedure Adjust
      (Bloc : in out Bloc_64_T);
   --  Ajuste le contenu après l'affectation.
   --  @param Bloc
   --  Le bloc de 64 bits.

   procedure Intervertir_Blocs
      (Bloc : in out Bloc_64_T)
      with Inline;
   --  Fait passer le bloc de 32 bits de gauche à droite et
   --  le bloc de 32 bits de droite à gauche. L'ordre des bits
   --  à l'intérieur des bloc de 32 n'est bien entendu pas modifié.
   --  @param Bloc
   --  Le bloc de 64 bits.

   procedure Ecrire_Bit
      (
         Bloc : in out Bloc_64_T;
         Position : Intervalle_T;
         Bit : Bit_T
      );
   --  Écrit le bit à la position demandé dans le bloc de 64.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Position
   --  La position du bit qu'on veut écrire.
   --  @param Bit
   --  Le bit qu'on veut écrire.

   function Lire_Bit
      (
         Bloc : Bloc_64_T;
         Position : Intervalle_T
      )
      return Bit_T;
   --  Lit le bit demandé dans le bloc de 64.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Position
   --  La position du bit qu'on veut lire.
   --  @return Le bit demandé.

   procedure Ecrire_Bit
      (
         Bloc : in out Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_T;
         Bit : Bit_T
      );
   --  Écrit le bit à la position demandé dans le bloc
   --  gauche ou droite de 32 bits du bloc de 64.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc gauche ou droite à écrire.
   --  @param Position
   --  La position du bit qu'on veut écrire dans le bloc gauche.
   --  @param Bit
   --  Le bit qu'on veut écrire.

   function Lire_Bit
      (
         Bloc : Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_T
      )
      return Bit_T;
   --  Lit le bit à la position demandé dans le bloc
   --  de 32 bits, gauche ou droit, du bloc de 64.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc gauche ou droite à lire.
   --  @param Position
   --  La position du bit qu'on veut lire dans le bloc gauche ou droit.
   --  @return Le bit lu.

   procedure Ecrire_Bloc
      (
         Bloc : in out Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Bloc_32 : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      )
      with Inline;
   --  Écrit le bloc de 32 bits à droite ou à gauche dans le
   --  bloc de 64 bits.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc gauche ou droite à écrire.
   --  @param Bloc_32
   --  Le bloc de 32 bits.

   function Lire_Bloc
      (
         Bloc : Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T
      )
      return Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      with Inline;
   --  Permet de lire le bloc de 32 bits de gauche ou de droite.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc de 32 bits de droite ou de gauche.
   --  @return Le bloc de 32 bits qui à été désigné.

private

   type Decalage_T is mod 2;
   --  Type modulaire permettant de connaitre le bloc de droite.

   for Position_Bloc_T use
      (
         Gauche => Decalage_T'First,
         Droite => Decalage_T'Last
      );

   function "+"
      (
         Left : Position_Bloc_T;
         Right : Decalage_T
      )
      return Position_Bloc_T
      with Inline;
   --  Permet de décaler les cotés gauche et droite selon un
   --  décalage numérique modulaire.
   --  @param Left
   --  La partie gauche de l'opérande.
   --  @param Right
   --  La partie droite de l'opérande.
   --  @return Le coté décalé.

   function "+"
      (
         Left : Decalage_T;
         Right : Position_Bloc_T
      )
      return Position_Bloc_T
      with Inline;
   --  Permet de décaler les cotés gauche et droite selon un
   --  décalage numérique modulaire.
   --  @param Left
   --  La partie gauche de l'opérande.
   --  @param Right
   --  La partie droite de l'opérande.
   --  @return Le coté décalé.

   type Tableau_Bloc_T is array (Position_Bloc_T)
      of Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
   --  Les deux blocs de 32 bits. Celui de gauche est placé en
   --  position 0 et celui de droite est placé en position 1.
   --  Les blocs ne sont jamais physiquement échangé mais
   --  seulement décalé grâce à un opérateur de décalage.

   type Bloc_64_T is new Bloc_Abstrait_T with
      record
         Blocs_32 : Tableau_Bloc_T;
         Decalage : Decalage_T;
      end record;

end Des_P.Bloc_P.Bloc_64_P;
