with Des_P.Clef_P.Clef_56_I_P;

--  @summary
--  La clef de 56 bits permettant de chiffrer les données.
--  @description
--  La représentation d'une clef de 56 bits, dans le standard DES.
--  @group Clef 56
package Des_P.Clef_P.Clef_56_P
   with Pure
is

   type Clef_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T with private;
   --  La clef de 56 bits.

   overriding
   procedure Decaler_Bits_A_Gauche
      (
         Clef        : in out Clef_T;
         Nb_Decalage :        Des_P.Clef_P.Clef_56_I_P.Decalage_T := 1
      )
      with Inline;
   --  Décale les bits de la clef vers la gauche
   --  @param Clef
   --  La clef dont on veut décaler les bits.
   --  @param Nb_Decalage
   --  Le nombre de décalages vers la gauche. Par défaut 1.

   overriding
   procedure Decaler_Bits_A_Droite
      (
         Clef        : in out Clef_T;
         Nb_Decalage :        Des_P.Clef_P.Clef_56_I_P.Decalage_T := 1
      )
      with Inline;
   --  Décale les bits de la clef vers la droite
   --  @param Clef
   --  La clef dont on veut décaler les bits.
   --  @param Nb_Decalage
   --  Le nombre de décalages vers la droite. Par défaut 1.

   overriding
   function Lire_Bit
      (
         Clef     : Clef_T;
         Position : Des_P.Clef_P.Clef_56_I_P.Intervalle_T
      )
      return Bit_T;
   --  Lit un bit spécifié.
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

   subtype Intervalle_Demi_Clef_T is Des_P.Clef_P.Clef_56_I_P.Decalage_T;
   --  L'intervalle des demi tableau de bits de la clef.

   type Champ_De_Bits_T is array
      (Intervalle_Demi_Clef_T) of Bit_T;
   --  Les bits de la clef de 56 sont divisée en deux groupes
   --  de même taille.
   --  Tableau des bits de la clef. Intervalle de 0 à 27

   type Clef_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T with
      record
         Decalage : Des_P.Clef_P.Clef_56_I_P.Decalage_T;
         --  Le nombre de décalage à appliquer aux bits de la clef.
         C1       : Champ_De_Bits_T;
         --  Un tableau de bits de la première moitié de la clef.
         C2       : Champ_De_Bits_T;
         --  Un tableau de bits de la seconde moitié de la clef.
      end record;

end Des_P.Clef_P.Clef_56_P;
