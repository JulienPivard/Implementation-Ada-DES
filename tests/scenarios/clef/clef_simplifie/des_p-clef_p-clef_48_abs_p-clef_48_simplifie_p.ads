--  @summary
--  Une clef concrète de 48 bits.
--  @description
--  La représentation d'une clef de 48 bits dans le standard DES.
--  @group Clef
package Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simplifie_P is

   pragma Pure;

   --  La clef de 48 bits.
   type Clef_48_Simplifie_T is new Clef_48_Abs_T with private;

   overriding
   --  Permet de lire le bit n de la clef.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit dans la clef.
   --  @return Le bit lu.
   function Lire_Bit
      (
         Clef : Clef_48_Simplifie_T;
         Position : Intervalle_Clef_48_T
      )
      return Bit_T;

   overriding
   --  Création d'une clef vide par défaut valeur 0.
   --  @param Clef
   --  La clef.
   procedure Initialize (Clef : in out Clef_48_Simplifie_T);

   overriding
   --  Supprime la clef.
   --  @param Clef
   --  La clef.
   procedure Finalize (Clef : in out Clef_48_Simplifie_T);

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param Clef
   --  La clef.
   procedure Adjust (Clef : in out Clef_48_Simplifie_T);

private

   type Clef_48_Simplifie_T is new Clef_48_Abs_T with null record;

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simplifie_P;
