with Ada.Finalization;

--  @summary
--  Un bloc de bits de données.
--  @description
--  Cette représentation abstraite permet de manipuler facilement
--  des blocs de bits sans avoir à en connaitre le détail.
--  @group Bloc
package Des_P.Bloc_P
   with Pure
is

   subtype Bit_T is Boolean;
   --  Représente un bit du bloc.

   type Bloc_Abstrait_T is abstract
      new Ada.Finalization.Controlled with private;
   --  Représente un bloc de bits.

   overriding
   procedure Initialize
      (B : in out Bloc_Abstrait_T)
   is abstract;
   --  Création d'un bloc de bits avec la valeur 0.
   --  @param B
   --  Le bloc de bits.

   overriding
   procedure Finalize
      (B : in out Bloc_Abstrait_T)
   is abstract;
   --  Supprime le bloc.
   --  @param B
   --  Le bloc de bits.

   overriding
   procedure Adjust
      (B : in out Bloc_Abstrait_T)
   is abstract;
   --  Ajuste le contenu après l'affectation.
   --  @param B
   --  Le bloc de bits.

private

   type Bloc_Abstrait_T is abstract
      new Ada.Finalization.Controlled with null record;

end Des_P.Bloc_P;
