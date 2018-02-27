--  @summary
--  Un bloc de 32 bits de données.
--  @description
--  Cette représentation permet de manipuler facilement des
--  blocs de 32 bits sans avoir à en connaitre le détail.
--  @group Bloc
package Des_P.Bloc_P.Bloc_32_P is

   pragma Pure;

   type Intervalle_T is range 1 .. 32;
   --  L'intervalle pour accéder à notre bloc de 32 bits.

   type Bloc_32_T is new Bloc_Abstrait_T with private;
   --  Représente un bloc de 32 bits.

   overriding
   procedure Initialize (B : in out Bloc_32_T);
   --  Création d'un bloc de 32 bits avec la valeur 0.
   --  @param B
   --  Le bloc de 32 bits.

   overriding
   procedure Finalize (B : in out Bloc_32_T);
   --  Supprime le bloc.
   --  @param B
   --  Le bloc de 32 bits.

   overriding
   procedure Adjust (B : in out Bloc_32_T);
   --  Ajuste le contenu après l'affectation.
   --  @param B
   --  Le bloc de 32 bits.

   procedure Ecrire_Bit
      (
         B : in out Bloc_32_T;
         Position : Intervalle_T;
         Bit : Bit_T
      );
   --  Écrit le bit à la position demandé dans le bloc de 32.
   --  @param B
   --  Le bloc de 32 bits.
   --  @param Position
   --  La position du bit qu'on veut écrire.
   --  @param Bit
   --  Le bit qu'on veut écrire.

   function Lire_Bit
      (
         B : Bloc_32_T;
         Position : Intervalle_T
      )
   return Bit_T;
   --  Lit le bit demandé dans le bloc de 32.
   --  @param B
   --  Le bloc de 32 bits.
   --  @param Position
   --  La position du bit qu'on veut lire.
   --  @return Le bit demandé.

   function "xor" (Bloc, Autre : Bloc_32_T) return Bloc_32_T;
   --  Effectue un xor bit à bit entre les deux blocs de 32.
   --  @param Bloc
   --  Le bloc de 32 bits.
   --  @param Autre
   --  L'autre bloc de 32 bits.
   --  @return Le résultat du xor bit à bit entre les deux blocs.

private

   type Tableau_Bits_T is array (Intervalle_T) of Bit_T
      with Size => 32, Pack;
   --  Le tableau de bits. Une case par bit.
   --  La taille du tableau est fixée à 32 bits dans un soucis
   --  de faciliter la manipulation par l'implémentation.
   --  Initialement le choix s'était porté sur un simple tableau
   --  mais forcer sa représentation en taille fixe a permis
   --  l'utilisation de méthode de création plus fiable,
   --  notamment pour ne pas fausser l'ordre des bits lut.

   type Bloc_32_T is new Bloc_Abstrait_T with
      record
         Bits : Tableau_Bits_T;
      end record;

end Des_P.Bloc_P.Bloc_32_P;
