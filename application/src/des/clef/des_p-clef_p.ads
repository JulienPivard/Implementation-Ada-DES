--  with Ada.Finalization;

--  @summary
--  La clef permettant de crypter les données.
--  @description
--  Version généraliste des clefs de cryptage/décryptage.
--  @group Clef
package Des_P.Clef_P is

   pragma Pure;

   --  Un bit de la clef.
   type Bit_T is range 0 .. 1;

   --  Une clef permettant de crypter/décrypter.
   type Clef_Abstraite_T is abstract tagged private;

   --  overriding
   --  --  Création d'une clef vide par défaut.
   --  --  @param Clef
   --  --  La clef de 56 bits.
   --  procedure Initialize (Clef : in out Clef_Abstraite_T);

   --  overriding
   --  --  Supprime la clef.
   --  --  @param Clef
   --  --  La clef de 56 bits.
   --  procedure Finalize (Clef : in out Clef_Abstraite_T);

   --  overriding
   --  --  Ajuste le contenu après l'affectation.
   --  --  @param Clef
   --  --  La clef de 56 bits.
   --  procedure Adjust (Clef : in out Clef_Abstraite_T);

private

   type Clef_Abstraite_T is abstract tagged null record;

end Des_P.Clef_P;
