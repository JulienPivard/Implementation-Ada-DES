with Des_P.Clef_P.Clef_64_I_P;

--  @summary
--  La clef de 64 bits permettant de chiffrer les données.
--  @description
--  La représentation d'une clef de 64 bits, dans le standard DES.
--  @group Clef 64
package Des_P.Clef_P.Clef_64_P
   with Pure
is

   type Clef_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T with private;
   --  La clef de 64 bits.

   overriding
   function Lire_Bit
      (
         Clef     : Clef_T;
         Position : Des_P.Clef_P.Clef_64_I_P.Intervalle_T
      )
      return Bit_T
      with Inline;
   --  Lit le bit à la position spécifié.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit que l'on veut lire.
   --  @return Le bit lu.

   overriding
   procedure Initialize
      (Clef : in out Clef_T);
   --  Création d'une clef vide par défaut.
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
      (Des_P.Clef_P.Clef_64_I_P.Intervalle_T) of Bit_T;
   --  Tableau des bits de la clef. Un bit par case.
   --  Cette représentation à été choisie pour faciliter la
   --  construction depuis la forme brut des bits.

   type Clef_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T with
      record
         Bits : Tableau_Bits_T;
         --  Les bits qui composent la clef stocké dans un tableau
         --  pour en faciliter l'accès et la manipulation.
      end record;

end Des_P.Clef_P.Clef_64_P;
