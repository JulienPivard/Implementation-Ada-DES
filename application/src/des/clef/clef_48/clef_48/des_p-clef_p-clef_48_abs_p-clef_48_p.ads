--  @summary
--  Une clef concrète de 48 bits.
--  @description
--  La représentation d'une clef de 48 bits est construite
--  à partir de la clef de 56. Le constructeur se charge de
--  sélectionner les bits.
--  @group Clef
package Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P is

   pragma Pure;

   --  La sous clef abstraite.
   type Clef_48_T is new Clef_48_Abs_T with private;

   overriding
   --  Permet de lire le bit n de la clef.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit dans la sous clef.
   --  @return Le bit lu.
   function Lire_Bit
      (Clef : Clef_48_T; Position : Intervalle_Clef_48_T)
      return Bit_T;

   overriding
   --  Création d'une clef vide par défaut.
   --  @param Clef
   --  La clef.
   procedure Initialize (Clef : in out Clef_48_T);

   overriding
   --  Supprime la clef.
   --  @param Clef
   --  La clef.
   procedure Finalize (Clef : in out Clef_48_T);

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param Clef
   --  La clef.
   procedure Adjust (Clef : in out Clef_48_T);

private

   --  La sous clefs rangé dans un tableau de bits.
   type Tableau_Bits_T is array
      (Intervalle_Clef_48_T range Intervalle_Clef_48_T'Range) of Bit_T;

   type Clef_48_T is new Clef_48_Abs_T with
      record
         Bits : Tableau_Bits_T;
      end record;

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P;
