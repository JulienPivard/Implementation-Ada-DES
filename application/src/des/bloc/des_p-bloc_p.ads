with Ada.Finalization;

--  @summary
--  Un bloc de bits de données.
--  @description
--  Cette représentation abstraite permet de manipuler facilement
--  des blocs de bits sans avoir à en connaitre le détail.
--  @group Bloc
package Des_P.Bloc_P is

   pragma Pure;

   --  Représente un bit du bloc.
   subtype Bit_T is Boolean;

   --  Représente un bloc de bits.
   type Bloc_Abstrait_T is abstract
      new Ada.Finalization.Controlled with private;

   overriding
   --  Création d'un bloc de bits avec la valeur 0.
   --  @param B
   --  Le bloc de bits.
   procedure Initialize (B : in out Bloc_Abstrait_T) is abstract;

   overriding
   --  Supprime le bloc.
   --  @param B
   --  Le bloc de bits.
   procedure Finalize (B : in out Bloc_Abstrait_T) is abstract;

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param B
   --  Le bloc de bits.
   procedure Adjust (B : in out Bloc_Abstrait_T) is abstract;

private

   type Bloc_Abstrait_T is abstract
      new Ada.Finalization.Controlled with null record;

end Des_P.Bloc_P;
