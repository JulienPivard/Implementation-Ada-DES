with Ada.Finalization;

--  @summary
--  La clef permettant de chiffrer les données.
--  @description
--  Version généraliste des clefs de chiffrement/déchiffrement.
--  @group Clef
package Des_P.Clef_P
   with Pure
is

   subtype Bit_T is Boolean;
   --  Un bit de la clef.

   type Clef_Abstrait_T is abstract
      new Ada.Finalization.Controlled with private;
   --  Une clef permettant de chiffrement/déchiffrement.

   overriding
   procedure Initialize
      (Clef : in out Clef_Abstrait_T)
   is abstract;
   --  Création d'une clef vide par défaut.
   --  @param Clef
   --  La clef.

   overriding
   procedure Finalize
      (Clef : in out Clef_Abstrait_T)
   is abstract;
   --  Supprime la clef.
   --  @param Clef
   --  La clef.

   overriding
   procedure Adjust
      (Clef : in out Clef_Abstrait_T)
   is abstract;
   --  Ajuste le contenu après l'affectation.
   --  @param Clef
   --  La clef.

private

   type Clef_Abstrait_T is abstract
      new Ada.Finalization.Controlled with null record;

end Des_P.Clef_P;
