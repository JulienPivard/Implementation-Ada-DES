with Ada.Finalization;

--  @summary
--  La clef permettant de crypter les données.
--  @description
--  Version généraliste des clefs de cryptage/décryptage.
--  @group Clef
package Des_P.Clef_P is

   pragma Pure;

   --  Un bit de la clef.
   type Bit_T is range 0 .. 1
      with Size => 1;

   --  Une clef permettant de crypter/décrypter.
   type Clef_Abstraite_T is abstract
      new Ada.Finalization.Controlled with private;

   overriding
   --  Création d'une clef vide par défaut.
   --  @param Clef
   --  La clef.
   procedure Initialize (Clef : in out Clef_Abstraite_T) is abstract;

   overriding
   --  Supprime la clef.
   --  @param Clef
   --  La clef.
   procedure Finalize (Clef : in out Clef_Abstraite_T) is abstract;

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param Clef
   --  La clef.
   procedure Adjust (Clef : in out Clef_Abstraite_T) is abstract;

private

   type Clef_Abstraite_T is abstract
      new Ada.Finalization.Controlled with null record;

end Des_P.Clef_P;
