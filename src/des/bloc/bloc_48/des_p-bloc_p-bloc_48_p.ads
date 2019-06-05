with Des_P.Bloc_P.Bloc_48_I_P;

--  @summary
--  Un bloc de 48 bits de données.
--  @description
--  Cette représentation permet de manipuler facilement des
--  blocs de 48 bits sans avoir à en connaitre le détail.
--  @group Bloc
package Des_P.Bloc_P.Bloc_48_P
   with Pure
is

   package Interface_R renames Des_P.Bloc_P.Bloc_48_I_P;

   type Bloc_48_T is new Bloc_Abstrait_T and
      Interface_R.Bloc_Interface_T with private;
   --  Représente un bloc de 32 bits.

   overriding
   procedure Initialize
      (B : in out Bloc_48_T);
   --  Création d'un bloc de 48 bits avec la valeur 0.
   --  @param B
   --  Le bloc de 48 bits.

   overriding
   procedure Finalize
      (B : in out Bloc_48_T);
   --  Supprime le bloc.
   --  @param B
   --  Le bloc de 48 bits.

   overriding
   procedure Adjust
      (B : in out Bloc_48_T);
   --  Ajuste le contenu après l'affectation.
   --  @param B
   --  Le bloc de 48 bits.

   overriding
   procedure Ecrire_Bit
      (
         B        : in out Bloc_48_T;
         Position :        Interface_R.Intervalle_T;
         Bit      :        Bit_T
      )
      with Inline;
   --  Écrit le bit à la position demandé dans le bloc de 48.
   --  @param B
   --  Le bloc de 48 bits.
   --  @param Position
   --  La position du bit qu'on veut écrire.
   --  @param Bit
   --  Le bit qu'on veut écrire.

   overriding
   function Lire_Bit
      (
         B        : Bloc_48_T;
         Position : Interface_R.Intervalle_T
      )
      return Bit_T
      with Inline;
   --  Lit le bit demandé dans le bloc de 48.
   --  @param B
   --  Le bloc de 48 bits.
   --  @param Position
   --  La position du bit qu'on veut lire.
   --  @return Le bit demandé.

private

   type Tableau_Bits_T is array (Interface_R.Intervalle_T) of Bit_T;
   --  Le tableau de bits. Une case par bit.

   type Bloc_48_T is new Bloc_Abstrait_T and
      Interface_R.Bloc_Interface_T with
      record
         Bits : Tableau_Bits_T;
         --  Les bits du bloc stocké dans un tableau pour en faciliter
         --  l'accès et la manipulation.
      end record;

end Des_P.Bloc_P.Bloc_48_P;
