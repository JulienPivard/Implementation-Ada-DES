--  @summary
--  Un bloc de 48 bits de données.
--  @description
--  Cette représentation permet de manipuler facilement des
--  blocs de 48 bits sans avoir à en connaitre le détail.
--  @group Bloc
package Des_P.Bloc_P.Bloc_48_P is

   pragma Pure;

   type Intervalle_T is range 1 .. 48;
   --  L'intervalle pour accéder à notre bloc de 48 bits.

   type Bloc_48_T is new Bloc_Abstrait_T with private;
   --  Représente un bloc de 32 bits.

   overriding
   procedure Initialize (B : in out Bloc_48_T);
   --  Création d'un bloc de 48 bits avec la valeur 0.
   --  @param B
   --  Le bloc de 48 bits.

   overriding
   procedure Finalize (B : in out Bloc_48_T);
   --  Supprime le bloc.
   --  @param B
   --  Le bloc de 48 bits.

   overriding
   procedure Adjust (B : in out Bloc_48_T);
   --  Ajuste le contenu après l'affectation.
   --  @param B
   --  Le bloc de 48 bits.

   procedure Ecrire_Bit
      (
         B : in out Bloc_48_T;
         Position : Intervalle_T;
         Bit : Bit_T
      );
   --  Écrit le bit à la position demandé dans le bloc de 48.
   --  @param B
   --  Le bloc de 48 bits.
   --  @param Position
   --  La position du bit qu'on veut écrire.
   --  @param Bit
   --  Le bit qu'on veut écrire.

   function Lire_Bit
      (
         B : Bloc_48_T;
         Position : Intervalle_T
      )
      return Bit_T;
   --  Lit le bit demandé dans le bloc de 48.
   --  @param B
   --  Le bloc de 48 bits.
   --  @param Position
   --  La position du bit qu'on veut lire.
   --  @return Le bit demandé.

private

   type Tableau_Bits_T is array (Intervalle_T) of Bit_T
      with Size => 48, Pack;
   --  Le tableau de bits. Une case par bit.
   --  La taille du tableau est fixée à 48 bits dans un soucis
   --  de faciliter la manipulation par l'implémentation.
   --  Initialement le choix s'était porté sur un simple tableau
   --  mais forcer sa représentation en taille fixe a permis
   --  l'utilisation de méthode de création plus fiable,
   --  notamment pour ne pas fausser l'ordre des bits lu.

   type Bloc_48_T is new Bloc_Abstrait_T with
      record
         Bits : Tableau_Bits_T;
      end record;

end Des_P.Bloc_P.Bloc_48_P;
