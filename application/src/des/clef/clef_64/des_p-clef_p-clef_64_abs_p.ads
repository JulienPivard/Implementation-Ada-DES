with Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;

--  @summary
--  Une clef abstraite de 64 bits.
--  @description
--  La représentation d'une clef de 64 bits dans le standard DES.
--  @group Clef
package Des_P.Clef_P.Clef_64_Abs_P is

   Erreur_Constructeur_56_Absent : exception;

   --  La clef de 64 bits.
   type Clef_64_Abs_T is abstract new Clef_Abstraite_T with private;

   --  L'intervalle de bits de la clef.
   type Intervalle_Clef_64_T is range 1 .. 64;

   --  Indique si un constructeur de clef 56 bits à été attribué.
   --  @param Clef
   --  La clef de 64 bits.
   --  @return La clef possède un constructeur de clef 56 bits initialisé.
   function Possede_Constructeur_56 (Clef : Clef_64_Abs_T)
      return Boolean is abstract;

   --  Indique si un constructeur de clef 48 bits à été attribué.
   --  Si la clef de 64 ne possède pas de clef 48, les clef de 56
   --  qui seront construite n'auront pas de constructeur de clef
   --  48.
   --  @param Clef
   --  La clef de 48 bits.
   --  @return La clef possède un constructeur de clef 48 bits initialisé.
   function Possede_Constructeur_48 (Clef : Clef_64_Abs_T)
      return Boolean is abstract;

   --  Lit le bit à la position spécifié.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit que l'on veut lire.
   --  @return Le bit lu.
   function Lire_Bit
      (Clef : Clef_64_Abs_T; Position : Intervalle_Clef_64_T)
      return Bit_T is abstract;

   --  Permet de généré une clef de 56 bits à partir de la clef de 64.
   --  @param Clef
   --  La clef de 64 bits.
   --  @return La clef de 56 bits.
   function Lire_Clef_56 (Clef : Clef_64_Abs_T)
      return Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T is abstract;

private

   type Clef_64_Abs_T is abstract new Clef_Abstraite_T with null record;

end Des_P.Clef_P.Clef_64_Abs_P;
