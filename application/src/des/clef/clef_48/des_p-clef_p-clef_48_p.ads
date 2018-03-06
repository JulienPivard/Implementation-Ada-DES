with Des_P.Clef_P.Clef_48_I_P;

--  @summary
--  Une clef concrète de 48 bits.
--  @description
--  La représentation d'une clef de 48 bits dans le standard DES.
--  @group Clef
package Des_P.Clef_P.Clef_48_P is

   pragma Pure;

   type Clef_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T with private;
   --  La clef de 48 bits.

   overriding
   function Lire_Bit
      (
         Clef : Clef_T;
         Position : Des_P.Clef_P.Clef_48_I_P.Intervalle_T
      )
      return Bit_T;
   --  Permet de lire le bit n de la clef.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit dans la clef.
   --  @return Le bit lu.

   overriding
   procedure Initialize
      (Clef : in out Clef_T);
   --  Création d'une clef vide par défaut valeur 0.
   --  @param Clef
   --  La clef.

   overriding
   procedure Finalize
      (Clef : in out Clef_T);
   --  Supprime la clef.
   --  @param Clef
   --  La clef.

   overriding
   procedure Adjust
      (Clef : in out Clef_T);
   --  Ajuste le contenu après l'affectation.
   --  @param Clef
   --  La clef.

private

   type Tableau_Bits_T is array
      (Des_P.Clef_P.Clef_48_I_P.Intervalle_T) of Bit_T;
   --  Les bits de la clefs rangé dans un tableau. Un bit par case.

   type Clef_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T with
      record
         Bits : Tableau_Bits_T;
      end record;

end Des_P.Clef_P.Clef_48_P;
