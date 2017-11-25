package Des_P.Sous_Clef_P is

   pragma Pure;

   --  Un bit de la clef.
   type Bit_T is range 0 .. 1;

   --  Le nombre de bits que contient la sous clef.
   type Interval_Sous_Clef_T is range 1 .. 48;

   --  La sous clef abstraite.
   type Sous_Clef_T is tagged private;

   --  Permet de lire le bit n de la clef.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit dans la sous clef.
   --  @return Le bit lu.
   function Lire_Bit (Clef : Sous_Clef_T; Position : Interval_Sous_Clef_T)
      return Bit_T;

private

   --  La sous clefs rangé dans un tableau de bits.
   type Tableau_Bits_T is array
      (Interval_Sous_Clef_T range Interval_Sous_Clef_T'Range) of Bit_T;

   type Sous_Clef_T is tagged
      record
         Bits : Tableau_Bits_T;
      end record;

end Des_P.Sous_Clef_P;
