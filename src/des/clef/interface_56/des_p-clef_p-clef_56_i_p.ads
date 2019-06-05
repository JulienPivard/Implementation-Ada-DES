--  @summary
--  Une clef abstraite de 56 bits.
--  @description
--  La représentation d'une clef de 56 bits dans le standard DES
--  @group Clef 56
package Des_P.Clef_P.Clef_56_I_P
   with Pure
is

   type Clef_Interface_T is interface;
   --  La clef de 56 bits.

   type Intervalle_T is range 1 .. 56;
   --  L'intervalle d'accès aux bits contenu dans la clef.

   type Decalage_T is mod 28;
   --  Le nombre de décalage à gauche.

   procedure Decaler_Bits_A_Gauche
      (
         Clef        : in out Clef_Interface_T;
         Nb_Decalage :        Decalage_T := 1
      )
   is abstract;
   --  Décale (par une rotation) les bits de la clef vers la gauche
   --  @param Clef
   --  La clef dont on veut décaler les bits.
   --  @param Nb_Decalage
   --  Le nombre de décalages vers la gauche. Par défaut 1.

   procedure Decaler_Bits_A_Droite
      (
         Clef        : in out Clef_Interface_T;
         Nb_Decalage :        Decalage_T := 1
      )
   is abstract;
   --  Décale (par une rotation) les bits de la clef vers la droite
   --  @param Clef
   --  La clef dont on veut décaler les bits.
   --  @param Nb_Decalage
   --  Le nombre de décalages vers la droite. Par défaut 1.

   function Lire_Bit
      (
         Clef     : Clef_Interface_T;
         Position : Intervalle_T
      )
      return Bit_T
   is abstract;
   --  Lit un bit spécifié.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit que l'on veut lire.
   --  @return Le bit lu.

end Des_P.Clef_P.Clef_56_I_P;
